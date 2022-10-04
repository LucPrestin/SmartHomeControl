import 'package:smart_home_control/database/utils.dart';
import 'package:smart_home_control/database/helpers/errors.dart';

abstract class Field {
  String sqlCommand();
}

class CreateTableField extends Field {
  static CreateTableField fromMap(Map fieldMap) {
    if (!fieldMap.containsKey('type')) {
      throw MigrationError('A create table fields needs the field \'type\'');
    }
    if (!fieldMap.containsKey('name')) {
      throw MigrationError('A create table fields needs the field \'name\'');
    }
    if (!fieldMap.containsKey('flags')) {
      throw MigrationError('A create table fields needs the field \'flags\'');
    }

    FieldType type = fieldMap['type'];
    String name = fieldMap['name'];
    List<Flag> flags = fieldMap['flags'];

    return CreateTableField(type: type, name: name, flags: flags);
  }

  FieldType type;
  String name;
  List<Flag> flags;

  CreateTableField(
      {required this.type, required this.name, required this.flags});

  @override
  String sqlCommand() {
    String command = '$name $type ';

    for (Flag flag in flags) {
      command += flag.value;
      command += ' ';
    }

    command = command.substring(0, command.length - 1);

    return command;
  }
}
