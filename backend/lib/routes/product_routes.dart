import 'package:backend_dart/handlers/product_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Router getProductRoutes() {
  final router = Router();

  router.get('/<id>', (Request request, String id) => getProductDetailHandler(request, id));
  router.post('/', createProductHandler);
  router.put('/<id>', (Request request, String id) => updateProductHandler(request, id));
  router.delete('/<id>', (Request request, String id) => deleteProductHandler(request, id));

  return router;
}

