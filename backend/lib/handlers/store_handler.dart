// import 'dart:convert';
// import 'package:shelf/shelf.dart';
// import '../db/connection.dart';
// import '../models/store.dart';

// // GET /store - Listagem de lojas
// Future<Response> getStoresHandler(Request request) async {
//   try {
//     final result = await DB.connection.query('SELECT * FROM stores');

//     // Transforma cada linha do resultado em um Map legível (coluna: valor)
//     final stores = result.map((row) => row.toColumnMap()).toList();

//     return Response.ok(jsonEncode(stores), 
//     headers: {
//       'Content-Type': 'application/json',
//     });

//   } catch (error) {
//     print('Erro ao buscar lojas: $error');

//     return Response.internalServerError(
//       body: jsonEncode({'error': 'Erro ao buscar lojas'}),
//       headers: {'Content-Type': 'application/json'},
//     );
//   }
// }

// // GET - /store/:id - Detalhes de uma loja específica
// Future<Response> getStoreDetailHandler(Request request, String idParam) async {
//   try {
//     // Verifica se o id é válido
//     final id = int.tryParse(idParam);

//     // Validação de ID 
//     final findData = await DB.connection.query(
//       'SELECT * FROM stores WHERE id = @id',
//       substitutionValues: {'id': id},
//     );

//     if (findData.isEmpty) {
//       return Response.notFound(jsonEncode({'erro': 'Loja não encontrada. Insira um ID válido.'}));
//     }

//     if (id == null) {
//       return Response(400, body: jsonEncode({'error': 'ID inválido'}));
//     }

//     final result = await DB.connection.query(
//       'SELECT * FROM stores WHERE id = @id',
//       substitutionValues: {'id': id},
//     );

//     // Verifica se encontrou alguma loja
//     if (result.isEmpty) {
//       return Response(404, body: jsonEncode({'erro': 'Loja não encontrada'}));
//     }

//     final store = result.first.toColumnMap();

//     return Response.ok(jsonEncode(store), headers: {
//       'Content-Type': 'application/json',
//     });

//   } catch (error) {
//     print('Erro ao buscar loja: $error');

//     return Response.internalServerError(
//       body: jsonEncode({'erro': 'Erro ao buscar a loja'}),
//       headers: {'Content-Type': 'application/json'},
//     );
//   }
// }

// // Cadastro de Loja - POST /store
// Future<Response> createStoreHandler(Request request) async {
//   try {
//     final body = await request.readAsString();
//     final data = jsonDecode(body);

//     if (
//       data['store_name'] == null || 
//       data['phone'] == null ||
//       data['cep'] == null || 
//       data['latitude'] == null ||
//       data['longitude'] == null || 
//       data['city'] == null ||
//       data['uf'] == null || 
//       data['address'] == null
//     ) {
//       return Response(400, body: jsonEncode({'erro': 'Campos obrigatórios não preenchidos'}));
//     }

//     final store = Store(
//       store_name: data['store_name'],
//       phone: data['phone'],
//       cep: data['cep'],
//       latitude: data['latitude'],
//       longitude: data['longitude'],
//       city: data['city'],
//       uf: data['uf'],
//       address: data['address'],
//     );

//     await DB.connection.query('''
//       INSERT INTO stores (store_name, phone, cep, latitude, longitude, city, uf, address)
//       VALUES (@store_name, @phone, @cep, @latitude, @longitude, @city, @uf, @address)
//     ''', substitutionValues: store.toMap());

//     return Response.ok(jsonEncode(
//       {'message': 'Loja criada com sucesso!'}), 
//       headers: {
//       'Content-Type': 'application/json',
//     });
    
//   } catch (error) {
//     print('Erro: Não foi possível cadastrar os dados da loja: $error');

//     return Response.internalServerError(
//       body: jsonEncode({'erro': 'Erro ao criar a loja'}),
//       headers: {'Content-Type': 'application/json'},
//     );
//   }
// }

// // Atualização de Loja - PUT /store/:id
// Future<Response> updateStoreHandler(Request request, String idParam) async {
//   try {
//     final id = int.tryParse(idParam);

//     // Validação de ID 
//     final findData = await DB.connection.query(
//       'SELECT * FROM stores WHERE id = @id',
//       substitutionValues: {'id': id},
//     );

//     if (findData.isEmpty) {
//       return Response.notFound(jsonEncode({'erro': 'Loja não encontrada. Insira um ID válido.'}));
//     }

//     // Verificação se o ID é válido
//     if (id == null) {
//       return Response(400, body: jsonEncode({'error': 'ID inválido'}));
//     }

//     final body = await request.readAsString();
//     final data = jsonDecode(body);

//      if (
//       data['store_name'] == null || 
//       data['phone'] == null ||
//       data['cep'] == null || 
//       data['latitude'] == null ||
//       data['longitude'] == null || 
//       data['city'] == null ||
//       data['uf'] == null || 
//       data['address'] == null
//     ) {
//       return Response(400, body: jsonEncode({'erro': 'Campos obrigatórios não preenchidos'}));
//     }

//     await DB.connection.query('''
//       UPDATE stores SET 
//         store_name = @store_name,
//         phone = @phone,
//         cep = @cep,
//         latitude = @latitude,
//         longitude = @longitude,
//         city = @city,
//         uf = @uf,
//         address = @address
//       WHERE id = @id
//     ''', substitutionValues: {
//       'id': id,
//       'store_name': data['store_name'],
//       'phone': data['phone'],
//       'cep': data['cep'],
//       'latitude': data['latitude'],
//       'longitude': data['longitude'],
//       'city': data['city'],
//       'uf': data['uf'],
//       'address': data['address'],
//     });

//     return Response.ok(jsonEncode(
//       {'mensagem': 'Loja atualizada com sucesso!'}), 
//       headers: {
//       'Content-Type': 'application/json',
//     });
    
//   } catch (error) {
//     print('Erro: Não foi possível atualizar os dados da loja: $error');

//     return Response.internalServerError(
//       body: jsonEncode({'erro': 'Erro ao atualizar a loja'}),
//       headers: {'Content-Type': 'application/json'},
//     );
//   }
// }

// // Deletar Loja - DELETE /store/:id
// Future<Response> deleteStoreHandler(Request request, String idParam) async {
//   try {
//     final id = int.tryParse(idParam);

//     // Validação de ID 
//     final findData = await DB.connection.query(
//       'SELECT * FROM stores WHERE id = @id',
//       substitutionValues: {'id': id},
//     );

//     if (findData.isEmpty) {
//       return Response.notFound(jsonEncode({'erro': 'Loja não encontrada. Insira um ID válido.'}));
//     }

//     if(id == null) {
//       return Response(400, body: jsonEncode( {'erro':'ID inválido'}));
//     }

//     await DB.connection.query(
//       'DELETE FROM stores WHERE id = @id',
//       substitutionValues: {'id': id}
//     );

//     return Response.ok(jsonEncode({'mensagem': 'Loja deletada com sucesso!'}));

//   } catch (error) {
//     print('Erro: Não foi possível deletar loja. Erro: $error');

//     return Response.internalServerError(
//       body: jsonEncode({'erro': 'Erro ao deletar loja.'}),
//       headers: {'Content-Type': 'application/json'}
//       );
//   }
// }
