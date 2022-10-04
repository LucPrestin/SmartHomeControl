import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'migrations.dart';
import 'helpers/migrations.dart';

const databaseName = 'SmartHomeControl.db';

Future<Database> loadDatabase() async {
  String path = join(await getDatabasesPath(), databaseName);
  return await openDatabase(path,
      version: migrations.length, onCreate: _onCreate, onUpgrade: _onUpgrade);
}

void _onCreate(Database db, int version) async {
  for (var migration in _loadMigrations()) {
    await _runMigration(db, migration);
  }
}

void _onUpgrade(Database db, int oldVersion, int newVersion) async {
  List<Migration> loadedMigrations = _loadMigrations();
  for (int i = oldVersion + 1; i <= newVersion; i++) {
    await _runMigration(db, loadedMigrations[i]);
  }
}

Future _runMigration(Database db, Migration migration) async {
  return db.execute(migration.sqlCommand());
}

List<Migration> _loadMigrations() {
  List<Migration> loadedMigrations = [];

  for (var migrationMap in migrations) {
    loadedMigrations.add(Migration.fromMap(migrationMap));
  }

  return loadedMigrations;
}
