import 'package:flutter/material.dart';

abstract class TabPage {
  String get title;
  String get tabBarText;
  IconData get tabBarIcon;
}
