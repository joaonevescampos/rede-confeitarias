import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import '../lib/routes/store_routes.dart';
import '../lib/db/connection.dart';

void main() async {
  await DB.connect();

  final cascade = Cascade().add(getStoreRoutes());

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(cascade.handler);

  final server = await serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor rodando em http://localhost:${server.port}');
}
