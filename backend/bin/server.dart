import 'dart:io';
import 'package:backend_dart/db/connection.dart';
import 'package:backend_dart/routes/store_routes.dart';
import 'package:backend_dart/routes/product_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';



void main() async {
  await DB.connect();

  final router = Router()
    ..mount('/store', getStoreRoutes())
    ..mount('/product', getProductRoutes());

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor rodando em http://localhost:${server.port}');
}
