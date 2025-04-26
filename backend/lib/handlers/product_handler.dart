import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../db/connection.dart';
import '../models/product.dart';

// GET - /product/:id - Detalhes de uma Produto específica
Future<Response> getProductDetailHandler(Request request, String idParam) async {
  try {
    // Verifica se o id é válido
    final id = int.tryParse(idParam);
    if (id == null) {
      return Response(400, body: jsonEncode({'error': 'ID inválido'}));
    }

    // Validação de ID 
    final result = await DB.connection.query(
      'SELECT * FROM products WHERE id = @id',
      substitutionValues: {'id': id},
    );

    if (result.isEmpty) {
      return Response(404, body: jsonEncode({'erro': 'Produto não encontrado. Insira um ID válido.'}));
    }

    final product = result.first.toColumnMap();

    return Response.ok(jsonEncode(product), headers: {
      'Content-Type': 'application/json',
    });

  } catch (error) {
    print('Erro ao buscar produto: $error');

    return Response.internalServerError(
      body: jsonEncode({'erro': 'Erro ao buscar o produto'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

// Cadastro de produto - POST /product
Future<Response> createProductHandler(Request request) async {
  try {
    final body = await request.readAsString();
    final data = jsonDecode(body);

    if (
      data['product_name'] == null || 
      data['price'] == null ||
      data['description'] == null || 
      data['image_url'] == null
    ) {
      return Response(400, body: jsonEncode({'erro': 'Campos obrigatórios não preenchidos'}));
    }

    final product = Product(
      store_id: data['store_id'],
      product_name: data['product_name'],
      price: data['price'],
      description: data['description'],
      image_url: data['image_url'],
    );

    await DB.connection.query('''
      INSERT INTO products (store_id, product_name, price, description, image_url)
      VALUES (@store_id, @product_name, @price, @description, @image_url)
    ''', substitutionValues: product.toMap());

    return Response.ok(jsonEncode(
      {'message': 'Produto criado com sucesso!'}), 
      headers: {
      'Content-Type': 'application/json',
    });
    
  } catch (error) {
    print('Erro: Não foi possível cadastrar os dados do Produto: $error');

    return Response.internalServerError(
      body: jsonEncode({'erro': 'Erro ao criar o produto'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

// Atualização de Produto - PUT /product/:id
Future<Response> updateProductHandler(Request request, String idParam) async {
  try {
    final id = int.tryParse(idParam);

    // Validação de ID 
    final findData = await DB.connection.query(
      'SELECT * FROM products WHERE id = @id',
      substitutionValues: {'id': id},
    );

    if (findData.isEmpty) {
      return Response.notFound(jsonEncode({'erro': 'Produto não encontrado. Insira um ID válido.'}));
    }

    // Verificação se o ID é válido
    if (id == null) {
      return Response(400, body: jsonEncode({'erro': 'ID inválido'}));
    }

    final body = await request.readAsString();
    final data = jsonDecode(body);

      if (
      data['product_name'] == null || 
      data['price'] == null ||
      data['description'] == null || 
      data['image_url'] == null
    ) {
      return Response(400, body: jsonEncode({'erro': 'Campos obrigatórios não preenchidos'}));
    }

    await DB.connection.query('''
      UPDATE products SET 
        product_name = @product_name,
        price = @price,
        description = @description,
        image_url = @image_url
      WHERE id = @id
    ''', substitutionValues: {
      'id': id,
      'product_name': data['product_name'],
      'price': data['price'],
      'description': data['description'],
      'image_url': data['image_url'],
    });

    return Response.ok(jsonEncode(
      {'mensagem': 'Produto atualizado com sucesso!'}), 
      headers: {
      'Content-Type': 'application/json',
    });
    
  } catch (error) {
    print('Erro: Não foi possível atualizar os dados do produto: $error');

    return Response.internalServerError(
      body: jsonEncode({'erro': 'Erro ao atualizar o produto'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

// Deletar Produto - DELETE /product/:id
Future<Response> deleteProductHandler(Request request, String idParam) async {
  try {
    final id = int.tryParse(idParam);

    // Validação de ID 
    final findData = await DB.connection.query(
      'SELECT * FROM products WHERE id = @id',
      substitutionValues: {'id': id},
    );

    print(findData);

    if (findData.isEmpty) {
      return Response.notFound(jsonEncode({'erro': 'Produto não encontrado. Insira um ID válido.'}));
    }

    // Validação de ID nulo
    if(id == null) {
      return Response(400, body: jsonEncode( {'erro':'ID inválido'}));
    }

    await DB.connection.query(
      'DELETE FROM products WHERE id = @id',
      substitutionValues: {'id': id}
    );

    return Response.ok(jsonEncode({'mensagem': 'Produto deletado com sucesso!'}));

  } catch (error) {
    print('Erro: Não foi possível deletar produto. Erro: $error');

    return Response.internalServerError(
      body: jsonEncode({'erro': 'Erro ao deletar produto.'}),
      headers: {'Content-Type': 'application/json'}
      );
  }
}
