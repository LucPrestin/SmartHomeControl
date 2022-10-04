import 'package:smart_home_control/database/utils.dart';
import 'package:smart_home_control/database/helpers/errors.dart';

checkMandatoryFields(Map fieldMap, List<String> fieldNames, String fieldType) {
  for (String fieldName in fieldNames) {
    if (!fieldMap.containsKey(fieldName)) {
      throw MigrationError('$fieldType need the field $fieldName');
    }
  }
}

abstract class Field {
  static const List<String> mandatoryFields = ['type'];
  static const String fieldName = 'All fields';

  static Field fromMap(Map fieldMap) {
    checkMandatoryFields(fieldMap, mandatoryFields, fieldName);

    switch (fieldMap['type']) {
      case FieldType.integer:
        return IntegerField.fromMap(fieldMap);
      case FieldType.text:
        return TextField.fromMap(fieldMap);
      case FieldType.foreignKey:
        return ForeignKeyField.fromMap(fieldMap);
      default:
        throw MigrationError(
            'The field type must be one of the known field types ${FieldType.values}');
    }
  }

  String sqlCommand();
}

class TextField extends Field {
  static const List<String> mandatoryFields = ['type', 'name', 'flags'];
  static const String fieldName = 'Text fields';

  static TextField fromMap(Map fieldMap) {
    checkMandatoryFields(fieldMap, mandatoryFields, fieldName);

    return TextField(
        type: fieldMap['type'],
        name: fieldMap['name'],
        flags: fieldMap['flags']);
  }

  FieldType type;
  String name;
  List<FieldFlag> flags;

  TextField({required this.type, required this.name, required this.flags});

  @override
  String sqlCommand() {
    String command = '$name $type ';

    for (FieldFlag flag in flags) {
      command += flag.value;
      command += ' ';
    }

    command = command.substring(0, command.length - 1);

    return command;
  }
}

class IntegerField extends Field {
  static const List<String> mandatoryFields = ['type', 'name', 'flags'];
  static const String fieldName = 'Integer fields';

  static IntegerField fromMap(Map fieldMap) {
    checkMandatoryFields(fieldMap, mandatoryFields, fieldName);

    return IntegerField(
        type: fieldMap['type'],
        name: fieldMap['name'],
        flags: fieldMap['flags']);
  }

  FieldType type;
  String name;
  List<FieldFlag> flags;

  IntegerField({required this.type, required this.name, required this.flags});

  @override
  String sqlCommand() {
    String command = '$name $type ';

    for (FieldFlag flag in flags) {
      command += flag.value;
      command += ' ';
    }

    command = command.substring(0, command.length - 1);

    return command;
  }
}

class ForeignKeyField extends Field {
  static const List<String> mandatoryFields = [
    'type',
    'name',
    'referencedTable',
    'referencedColumn',
    'onDelete',
    'onUpdate'
  ];
  static const String fieldName = 'Text fields';

  static ForeignKeyField fromMap(Map fieldMap) {
    checkMandatoryFields(fieldMap, mandatoryFields, fieldName);

    Action onDelete = fieldMap['onDelete'];
    Action onUpdate = fieldMap['onUpdate'];

    if ((onDelete == Action.setDefault || onUpdate == Action.setDefault) &&
        !fieldMap.containsKey('defaultValue')) {
      throw MigrationError(
          'If "onDelete" or "onUpdate" are set to "setDefault", a default must be provided.');
    }

    return ForeignKeyField(
        name: fieldMap['name'],
        referencedTable: fieldMap['referencedTable'],
        referencedColumn: fieldMap['referencedColumn'],
        onDelete: onDelete,
        onUpdate: onUpdate,
        defaultValue: fieldMap.containsKey('defaultValue')
            ? fieldMap['defaultValue']
            : null);
  }

  String name;
  String referencedTable;
  String referencedColumn;
  Action onDelete;
  Action onUpdate;
  var defaultValue;

  ForeignKeyField(
      {required this.name,
      required this.referencedTable,
      required this.referencedColumn,
      required this.onDelete,
      required this.onUpdate,
      this.defaultValue});

  @override
  String sqlCommand() {
    String command = 'FOREIGN KEY ($name) ';

    if (onDelete == Action.setDefault || onUpdate == Action.setDefault) {
      command += 'DEFAULT $defaultValue ';
    }

    command += 'REFERENCES $referencedTable ($referencedColumn) ';
    command += 'ON DELETE ${onDelete.value} ON UPDATE ${onUpdate.value}';

    return command;
  }
}
