import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/deliveryman_model.dart';
import 'models/stock_model.dart';
import 'models/retailer_model.dart';
import 'models/invoice_model.dart';
import 'models/sales_order_model.dart';
import 'models/visit_model.dart';
import 'models/payment_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('delivery.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = join(await getDatabasesPath(), filePath);
    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE DeliveryMan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE Stock (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE Retailer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        visited INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE Invoice (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        retailerId INTEGER NOT NULL,
        amount REAL NOT NULL,
        paid INTEGER NOT NULL,
        FOREIGN KEY (retailerId) REFERENCES Retailer(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE SalesOrder (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        retailerId INTEGER NOT NULL,
        lineItems TEXT NOT NULL,
        FOREIGN KEY (retailerId) REFERENCES Retailer(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE Visit (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        retailerId INTEGER NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (retailerId) REFERENCES Retailer(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE Payment (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoiceId INTEGER NOT NULL,
        amount REAL NOT NULL,
        FOREIGN KEY (invoiceId) REFERENCES Invoice(id)
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> row, int id) async {
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
