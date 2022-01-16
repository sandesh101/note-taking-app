import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider db = DatabaseProvider._init();

  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(
        join(
          await getDatabasesPath(),
          "note_app.db",
        ), onCreate: (db, version) async {
      await db.execute('''
        
        ''');
    });
  }
}
