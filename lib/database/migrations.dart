import 'utils.dart';

const migrations = [
  {
    'action': MigrationType.createTable,
    'tableName': 'light_strip',
    'fields': [
      {
        'type': FieldType.integer,
        'name': 'id',
        'flags': [Flag.primaryKey, Flag.autoIncrement]
      },
      {'type': FieldType.text, 'name': 'name', 'flags': []},
      {'type': FieldType.text, 'name': 'mqttId', 'flags': []},
      {'type': FieldType.integer, 'name': 'color', 'flags': []},
      {'type': FieldType.integer, 'name': 'isOn', 'flags': []}
    ]
  },
  {
    'action': MigrationType.renameColumn,
    'tableName': 'light_strip',
    'oldColumnName': 'mqttId',
    'newColumnName': 'mqttTopic'
  }
];
