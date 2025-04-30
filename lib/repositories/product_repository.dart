import 'package:rede_confeitarias/models/product_model.dart';
import 'package:rede_confeitarias/db/db_helper.dart';

class ProductRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Lista os produtos de uma loja específica pelo ID da loja
  Future<List<Product>> getProductsByStoreId(int storeId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'store_id = ?',
      whereArgs: [storeId],  // Filtra pelos produtos da loja com o ID fornecido
    );
    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  // Lista um produto específico pelo ID
  Future<Product?> getProductById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    }
    throw Exception('Produto não encontrado');
  }

  // Cria um novo produto
  Future<int> createProduct(Product product) async {
    final db = await _databaseHelper.database;
    return await db.insert('products', product.toJson());
  }

  // Exclui um produto
  Future<int> deleteProduct(int productId) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  // Atualiza um produto
  Future<int> updateProduct(Product product) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'products',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
