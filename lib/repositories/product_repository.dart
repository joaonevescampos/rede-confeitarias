import 'package:rede_confeitarias/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class ProductRepository {
  static Database? _database;

  // Método que retorna a instância do banco de dados
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            storeId INTEGER,
            productName TEXT,
            price REAL,
            description TEXT,
            stock INTEGER,
            imageUrl TEXT,
            FOREIGN KEY(storeId) REFERENCES stores(id)
          )
        ''');
      },
      version: 1,
    );
  }

  // Cria um novo produto
  Future<int> createProduct(Product product) async {
    final db = await database;
    return await db.insert(
      'products',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Lista todos os produtos
  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  // Lista os produtos de uma loja específica
  Future<List<Product>> getProductsByStoreId(int storeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'storeId = ?',
      whereArgs: [storeId],
    );
    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  // Atualiza um produto
  Future<int> updateProduct(Product product) async {
    final db = await database;
    return await db.update(
      'products',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Deleta um produto
  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
