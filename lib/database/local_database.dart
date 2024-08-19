import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('delivery.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = join(await getDatabasesPath(), filePath);
    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE stocks (
        id INTEGER PRIMARY KEY,
        name TEXT,
        quantity INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE retailers (
        id INTEGER PRIMARY KEY,
        name TEXT,
        latitude REAL,
        longitude REAL,
        visited INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE invoices (
        id INTEGER PRIMARY KEY,
        amount REAL
      )
    ''');
    // Define other tables similarly
  }
}
