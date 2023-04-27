import 'package:sqflite/sqflite.dart';
import '../model/location.dart';

class LocationDao {
  static const String _tableName = 'locations';
  static const String _dbName = 'suficiencia_marcelo_falchi';

  static final LocationDao _instance = LocationDao._();

  static Database? _database;

  factory LocationDao() => _instance;

  LocationDao._();

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        details TEXT,
        differentials TEXT,
        cep TEXT,
        image TEXT,
        included TEXT,
        latitude TEXT,
        longitude TEXT);
    ''');
  }

  Future<int> edit(Location location) async {
    dynamic map = location.toMap();
    final db = await database;
    return await db
        .update(_tableName, map, where: 'id = ?', whereArgs: [location.id]);
  }

  Future<void> insertLocation(Location location) async {
    final db = await database;
    await db.insert(
      _tableName,
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = '$databasesPath/$_dbName';
    return await openDatabase(dbPath, version: 2, onCreate: _onCreate);
  }

  Future<bool> remove(int id) async {
    final db = await database;
    final registrosAtualizados = await db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
    return registrosAtualizados > 0;
  }

  Future<List<Location>> getSearches() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('locations', orderBy: 'id DESC');

    List<Location> locations = [];

    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        locations.add(Location.fromMap(map));
      }
    }

    return locations;
  }

  Future<List<Location>> list(String where) async {
    String clause =
        "UPPER(name) LIKE '${where.toUpperCase()}%' OR UPPER(details) LIKE '${where.toUpperCase()}%' OR UPPER(differentials) LIKE '${where.toUpperCase()}%' OR UPPER(included) LIKE '${where.toUpperCase()}%'";

    final db = await database;
    final resultado = await db.query(
      _tableName,
      columns: [
        'id',
        'name',
        'details',
        'differentials',
        'cep',
        'image',
      ],
      where: clause,
      orderBy: 'id DESC',
    );
    return resultado.map((m) => Location.fromMap(m)).toList();
  }
}
