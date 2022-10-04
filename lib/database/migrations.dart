import 'utils.dart';

const migrations = [
  {
    'action': MigrationType.createTable,
    'tableName': 'light_strip',
    'fields': [
      {
        'type': FieldType.integer,
        'name': 'id',
        'flags': [FieldFlag.primaryKey, FieldFlag.autoIncrement]
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
  },
  {
    'action': MigrationType.createTable,
    'tableName': 'subtopics',
    'fields': [
      {
        'type': FieldType.integer,
        'name': 'id',
        'flags': [FieldFlag.primaryKey, FieldFlag.autoIncrement]
      },
      {
        'type': FieldType.foreignKey,
        'name': 'light_strip_id',
        'referencedTable': 'light_strip',
        'referencedColumn': 'id',
        'onDelete': Action.cascade,
        'onUpdate': Action.cascade,
      },
      {'type': FieldType.text, 'name': 'subtopic', 'flags': []},
      {'type': FieldType.integer, 'name': 'color', 'flags': []}
    ]
  }
];
