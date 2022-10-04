enum MigrationType { createTable, dropColumn, renameColumn, dropTable }

enum FieldType { integer, text, foreignKey }

enum FieldFlag { primaryKey, autoIncrement }

extension FlagName on FieldFlag {
  String get value {
    switch (this) {
      case FieldFlag.autoIncrement:
        return 'AUTOINCREMENT';
      case FieldFlag.primaryKey:
        return 'PRIMARY KEY';
      default:
        return '';
    }
  }
}

enum Action { noAction, restrict, setNull, setDefault, cascade }

extension ActionName on Action {
  String get value {
    switch (this) {
      case Action.noAction:
        return 'NO ACTION';
      case Action.restrict:
        return 'RESTRICT';
      case Action.setNull:
        return 'SET NULL';
      case Action.setDefault:
        return 'SET DEFAULT';
      case Action.cascade:
        return 'CASCADE';
      default:
        return '';
    }
  }
}
