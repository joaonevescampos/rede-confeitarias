import 'package:backend_dart/handlers/product_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Router getStoreRoutes() {
  final router = Router();

  router.get('/products', getProductsHandler);
  router.get('/product/<id>', (Request request, String id) => getProductDetailHandler(request, id));
  router.post('/product', createProductHandler);
  router.put('/product/<id>', (Request request, String id) => updateProductHandler(request, id));
  router.delete('/product/<id>', (Request request, String id) => deleteProductHandler(request, id));

  return router;
}

