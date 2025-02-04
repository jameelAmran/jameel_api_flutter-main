import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/data_model.dart';

class LocalRepository {
  static final LocalRepository _instance = LocalRepository._internal();
  factory LocalRepository() => _instance;
  static Database? _database;

  LocalRepository._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT
      )
    ''');
  }

  Future<void> insertData(DataModel data) async {
    final db = await database;
    await db.insert('data', data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DataModel>> getPendingData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data');
    return List.generate(maps.length, (i) {
      return DataModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('data', where: 'id = ?', whereArgs: [id]);
  }
}