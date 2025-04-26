import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/store_handler.dart';

Router getStoreRoutes() {
  final router = Router();

  router.get('/', getStoresHandler); // listar todas as lojas
  router.get('/<id>', (Request request, String id) => getStoreDetailHandler(request, id)); // detalhes da loja
  router.post('/', createStoreHandler); // criar loja
  router.put('/<id>', (Request request, String id) => updateStoreHandler(request, id)); // atualizar loja
  router.delete('/<id>', (Request request, String id) => deleteStoreHandler(request, id)); // deletar loja

  return router;
}
