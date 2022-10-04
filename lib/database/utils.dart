enum MigrationType { createTable, dropColumn, renameColumn, dropTable }

enum FieldType { integer, text }

enum Flag { primaryKey, autoIncrement }

extension FlagName on Flag {
  String get value {
    switch (this) {
      case Flag.autoIncrement:
        return 'AUTOINCREMENT';
      case Flag.primaryKey:
        return 'PRIMARY KEY';
      default:
        return '';
    }
  }
}
