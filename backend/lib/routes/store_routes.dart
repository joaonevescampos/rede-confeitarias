import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/store_handler.dart';

Router getStoreRoutes() {
  final router = Router();

  router.get('/stores', getStoresHandler);
  router.get('/store/<id>', (Request request, String id) => getStoreDetailHandler(request, id));
  router.post('/store', createStoreHandler);
  router.put('/store/<id>', (Request request, String id) => updateStoreHandler(request, id));
  router.delete('/store/<id>', (Request request, String id) => deleteStoreHandler(request, id));

  return router;
}
