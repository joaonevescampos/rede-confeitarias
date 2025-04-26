import 'package:postgres/postgres.dart';

class DB {
  static final connection = PostgreSQLConnection(
    'localhost', // host
    5432,        // porta
    'confeitarias_db', // nome do banco
    username: 'postgres',
    password: 'sua_senha',
  );

  static Future<void> connect() async {
    if (connection.isClosed) {
      await connection.open();
      print('✅ Conectado ao PostgreSQL');
    }
  }
}
