import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.purple.shade500),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 2.0)),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        labelPadding: EdgeInsets.all(4.0)),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Colors.purple.shade500,
        primaryVariant: Colors.purple.shade700,
        secondary: Colors.teal.shade200,
        secondaryVariant: Colors.teal.shade900,
        background: Colors.white,
        surface: Colors.white,
        error: const Color(0xb00020ff),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onBackground: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white));

ThemeData darkTheme = ThemeData(
    backgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 2.0)),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        labelPadding: EdgeInsets.all(4.0)),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        primary: Colors.purple.shade200,
        primaryVariant: Colors.purple.shade700,
        secondary: Colors.teal.shade200,
        background: const Color(0x121212ff),
        surface: const Color(0x121212ff),
        error: const Color(0xcf6679ff),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onBackground: Colors.white,
        onSurface: Colors.white,
        onError: Colors.black));
