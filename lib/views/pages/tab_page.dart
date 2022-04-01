import 'package:flutter/material.dart';

abstract class TabPage {
  String get title;
  IconData get navigationIcon;
  IconData? get floatingActionButtonIcon;
  Function()? get floatingActionButtonPressedCallback;
}
