import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // Table for generic key-value data
      await db.execute('''
        CREATE TABLE form_data (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT,
          value TEXT
        )
      ''');

      // Table for vehicle types
      await db.execute('''
        CREATE TABLE vehicle_types (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          image TEXT,
          wheels INTEGER NOT NULL
        )
      ''');
    });
  }

  /// Save generic key-value data in the database
  Future<void> saveData(String key, String value) async {
    final db = await instance.database;
    await db.insert(
      'form_data',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the key exists
    );
  }

  /// Fetch generic data from the database using a key
  Future<String?> fetchData(String key) async {
    final db = await instance.database;
    final result = await db.query('form_data', where: 'key = ?', whereArgs: [key]);
    if (result.isNotEmpty) {
      return result.first['value'] as String?;
    }
    return null;
  }

  /// Insert Vehicle Type into the database
  Future<void> insertVehicleType(String name, String image, int wheels) async {
    final db = await instance.database;
    await db.insert(
      'vehicle_types',
      {
        'name': name,
        'image': image,
        'wheels': wheels,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the entry exists
    );
  }

  /// Fetch all Vehicle Types from the database
  Future<List<Map<String, dynamic>>> fetchAllVehicleTypes() async {
    final db = await instance.database;
    return await db.query('vehicle_types');
  }

  /// Delete all Vehicle Types from the database
  Future<void> clearAllVehicleTypes() async {
    final db = await instance.database;
    await db.delete('vehicle_types');
  }

  /// Close the database connection
  Future<void> close() async {
    final db = _database;
    if (db != null) await db.close();
  }
}
