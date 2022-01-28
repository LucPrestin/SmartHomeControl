import 'package:flutter/material.dart';

class LightListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightListItemState();
}

class _LightListItemState extends State<LightListItem> {
  @override
  Widget build(BuildContext context) {
    return const ListTile(title: Text('list tile'));
  }
}
