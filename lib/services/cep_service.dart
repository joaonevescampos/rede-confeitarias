import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

// Função que trás os dados da API (Via CEP) como: cidade, bairro, logradouro... por meio do CEP
Future<Map<String, dynamic>?> fetchAddressFromCep(String cep) async {
  final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey('erro')) return null;

      return {
        'logradouro': data['logradouro'],
        'bairro': data['bairro'],
        'cidade': data['localidade'],
        'estado': data['uf'],
      };
    } else {
      return null;
    }
  } catch (e) {
      print('Erro ao buscar CEP: $e');
    return null;
  }
}

// Funcão que pega as cordenadas (latitude e longetude) a partir de um cep
Future<LatLng?> searchCoordenates({
  required String cep,
  required String cidade,
  required String estado,
  required String logradouro,
}) async {
  final query = '$logradouro, $cidade, $estado, Brazil';
  final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json');

  final response = await http.get(url, headers: {'User-Agent': 'flutter-app'});

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);
      return LatLng(lat, lon);
    }
  }

  return null;
}


