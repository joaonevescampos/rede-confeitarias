import 'package:shelf_router/shelf_router.dart';
import '../handlers/store_handler.dart';

Router getStoreRoutes() {
  final router = Router();

  router.post('/stores', createStoreHandler);

  return router;
}
