import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  // Cria ou abre o banco de dados
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'rede_confeitarias.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Criação das tabelas no banco de dados
  Future<void> _onCreate(Database db, int version) async {
    // Criação da tabela 'stores' (exemplo)
    await db.execute('''
      CREATE TABLE stores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        store_name TEXT,
        address TEXT,
        city TEXT,
        uf TEXT,
        cep TEXT,
        latitude REAL,
        longitude REAL,
        phone TEXT
      )
    ''');

    // Criação da tabela 'products'
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        store_id INTEGER,  -- Relacionamento com a tabela 'stores'
        name TEXT,
        description TEXT,
        price REAL,
        image_url TEXT,
        FOREIGN KEY(store_id) REFERENCES stores(id)
      )
    ''');
  }

  // Método para fechar o banco de dados
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
