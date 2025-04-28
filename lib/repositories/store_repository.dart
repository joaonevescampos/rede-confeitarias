import 'package:rede_confeitarias/models/store_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class StoreRepository {
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
          CREATE TABLE stores(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            storeName TEXT,
            phone TEXT,
            cep TEXT,
            latitude REAL,
            longitude REAL,
            city TEXT,
            uf TEXT,
            address TEXT,
            neighborhood TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Cria uma loja no banco de dados
  Future<int> createStore(Store store) async {
    final db = await database;
    return await db.insert(
      'stores',
      store.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Confirme o uso de replace
    );
  }

  // Lista todas as lojas no banco
  Future<List<Store>> getAllStores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('stores');
    return List.generate(maps.length, (i) {
      return Store.fromJson(maps[i]);
    });
  }

  // Lista uma loja específica pelo ID
  Future<Store?> getStoreById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'stores',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Store.fromJson(maps.first);
    }
    return null;
  }

  // Atualiza os dados de uma loja
  Future<int> updateStore(Store store) async {
    final db = await database;
    return await db.update(
      'stores',
      store.toJson(),
      where: 'id = ?',
      whereArgs: [store.id],
    );
  }

  // Deleta uma loja pelo ID
  Future<int> deleteStore(int id) async {
    final db = await database;
    return await db.delete(
      'stores',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

