import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;
  static const String DB_NAME = 'app_database.db';

  // Método para inicializar o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    return openDatabase(
      path,
      onCreate: (db, version) async {
        // Aqui você pode criar suas tabelas
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
            address TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            storeId INTEGER,
            productName TEXT,
            price REAL,
            description TEXT,
            imageUrl TEXT,
            FOREIGN KEY(storeId) REFERENCES stores(id)
          )
        ''');
      },
      version: 1,
    );
  }

  // Função para fechar o banco de dados
  Future<void> close() async {
    var dbClient = await database;
    dbClient.close();
  }
}
