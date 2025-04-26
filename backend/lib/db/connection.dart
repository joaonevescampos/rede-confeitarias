import 'package:postgres/postgres.dart';

class DB {
  static final connection = PostgreSQLConnection(
    'localhost', // host
    5432,        // porta
    'rede_confeitarias', // nome do banco
    username: 'postgres',
    password: '3201',
  );

  static Future<void> connect() async {
    if (connection.isClosed) {
      await connection.open();
      print('✅ Conectado ao PostgreSQL');
    }
  }
}
