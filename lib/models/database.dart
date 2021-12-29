import 'package:smart_home_control/models/lightStrip.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'SmartHomeControl.db';
  static const int _databaseVersion = 1;

  static const _tableNameLightStrip = 'LightStrip';

  DatabaseHelper._privateContructor();
  static final DatabaseHelper instance = DatabaseHelper._privateContructor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initializeDatabase();

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateDatabase);
  }

  _onCreateDatabase(Database db, int version) async {
    // create light strip table
    await db.execute(
        'CREATE TABLE $_tableNameLightStrip (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, color INTEGER, isOn INTEGER)');
  }

  insertLightStrip(LightStrip lightStrip) async {
    Database db = await database;
    await db.insert(_tableNameLightStrip, lightStrip.toMap());
  }

  Future<LightStrip> getLightStrip(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> queryResult =
        await db.query(_tableNameLightStrip, where: 'id = ?', whereArgs: [id]);
    if (queryResult.isEmpty) {
      throw Exception('LightStrip with id $id not found');
    }

    return LightStrip.fromMap(queryResult.first);
  }

  Future<List<LightStrip>> getAllLightStrips() async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.query(_tableNameLightStrip, orderBy: 'id');

    List<LightStrip> result = [];
    for (var map in maps) {
      result.add(LightStrip.fromMap(map));
    }
    return result;
  }

  Future<int> updateLightStrip(LightStrip lightStrip) async {
    Database db = await database;
    return await db.update(_tableNameLightStrip, lightStrip.toMap(),
        where: 'id = ?', whereArgs: [lightStrip.id]);
  }

  Future<int> removeLightStrip(LightStrip lightStrip) async {
    Database db = await database;
    return await db.delete(_tableNameLightStrip,
        where: 'id = ?', whereArgs: [lightStrip.id]);
  }
}
