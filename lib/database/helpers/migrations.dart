import 'package:smart_home_control/database/helpers/fields.dart';
import 'package:smart_home_control/database/helpers/errors.dart';

import '../utils.dart';

abstract class Migration {
  static Migration fromMap(Map migrationMap) {
    if (!migrationMap.containsKey('action')) {
      throw MigrationError('A migration needs the field \'action\'');
    }

    MigrationType action = migrationMap['action'];

    switch (action) {
      case MigrationType.createTable:
        return CreateTableMigration.fromMap(migrationMap);
      case MigrationType.dropColumn:
        return DropColumnMigration.fromMap(migrationMap);
      case MigrationType.renameColumn:
        return RenameColumnMigration.fromMap(migrationMap);
      case MigrationType.dropTable:
        return DropTableMigration.fromMap(migrationMap);
      default:
        throw MigrationError(
            "The designated action must be one of the enums provided. Given value: $action");
    }
  }

  String sqlCommand();
}

class CreateTableMigration extends Migration {
  static CreateTableMigration fromMap(Map migrationMap) {
    if (!migrationMap.containsKey('tableName')) {
      throw MigrationError(
          'A create table migration needs the field \'tableName\'');
    }
    if (!migrationMap.containsKey('fields')) {
      throw MigrationError(
          'A create table migration needs the field \'fields\'');
    }

    String tableName = migrationMap['tableName'];
    List<CreateTableField> fields = [];
    for (var fieldMap in migrationMap['fields']) {
      fields.add(CreateTableField.fromMap(fieldMap));
    }

    return CreateTableMigration(tableName: tableName, fields: fields);
  }

  String tableName = '';
  List<CreateTableField> fields = [];

  CreateTableMigration({required this.tableName, required this.fields});

  @override
  String sqlCommand() {
    String command = 'CREATE TABLE $tableName (';

    for (CreateTableField field in fields) {
      command += field.sqlCommand();
      command += ', ';
    }

    if (command.endsWith(', ')) {
      command = command.substring(0, command.length - 2);
    }

    command += ')';
    return command;
  }
}

class DropColumnMigration extends Migration {
  static DropColumnMigration fromMap(Map migrationMap) {
    if (!migrationMap.containsKey('tableName')) {
      throw MigrationError(
          'A drop column migration needs the field \'tableName\'');
    }
    if (!migrationMap.containsKey('columnName')) {
      throw MigrationError(
          'A drop column migration needs the field \'columnName\'');
    }

    String tableName = migrationMap['tableName'];
    String columnName = migrationMap['columnName'];

    return DropColumnMigration(tableName: tableName, columnName: columnName);
  }

  String tableName;
  String columnName;

  DropColumnMigration({required this.tableName, required this.columnName});

  @override
  String sqlCommand() {
    return 'ALTER TABLE $tableName DROP COLUMN $columnName';
  }
}

class DropTableMigration extends Migration {
  static DropTableMigration fromMap(Map migrationMap) {
    if (!migrationMap.containsKey('tableName')) {
      throw MigrationError(
          'A drop table migration needs the field \'tableName\'');
    }

    String tableName = migrationMap['tableName'];

    return DropTableMigration(tableName: tableName);
  }

  String tableName;

  DropTableMigration({required this.tableName});

  @override
  String sqlCommand() {
    return 'DROP TABLE $tableName';
  }
}

class RenameColumnMigration extends Migration {
  static RenameColumnMigration fromMap(Map migrationMap) {
    if (!migrationMap.containsKey('tableName')) {
      throw MigrationError(
          'A drop column migration needs the field \'tableName\'');
    }
    if (!migrationMap.containsKey('oldColumnName')) {
      throw MigrationError(
          'A drop column migration needs the field \'oldColumnName\'');
    }
    if (!migrationMap.containsKey('newColumnName')) {
      throw MigrationError(
          'A drop column migration needs the field \'newColumnName\'');
    }

    return RenameColumnMigration(
        tableName: migrationMap['tableName'],
        oldColumnName: migrationMap['oldColumnName'],
        newColumnName: migrationMap['newColumnName']
    );
  }

  String tableName;
  String oldColumnName;
  String newColumnName;

  RenameColumnMigration({required this.tableName, required this.oldColumnName, required this.newColumnName});

  @override
  String sqlCommand() {
    return 'ALTER TABLE $tableName RENAME COLUMN $oldColumnName TO $newColumnName';
  }

}
