import 'package:flutter/material.dart';
import 'package:smart_home_control/models/light_strip.dart';

class LightListItem extends StatefulWidget {
  final LightStrip strip;

  const LightListItem(this.strip, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightListItemState();
}

class _LightListItemState extends State<LightListItem> {
  @override
  Widget build(BuildContext context) {
    return const ListTile(title: Text('list tile'));
  }
}
