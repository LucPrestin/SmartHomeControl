import 'package:flutter/material.dart';
import 'package:smart_home_control/views/pages/light_add_page.dart';
import 'package:smart_home_control/views/pages/light_edit_page.dart';

import 'package:smart_home_control/views/pages/page.dart';
import 'package:smart_home_control/views/pages/about_page.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';
import 'package:smart_home_control/views/pages/settings_page.dart';
import 'package:smart_home_control/views/pages/smart_hub_list_page.dart';

import 'routes/routes.dart';

void main() {
  runApp(const SmartHomeControlApp());
}

class SmartHomeControlApp extends StatefulWidget {
  const SmartHomeControlApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmartHomeControlAppState();
}

class _SmartHomeControlAppState extends State<SmartHomeControlApp> {
  static const List<Widget> _widgetOptions = <Widget>[
    LightListPage(),
    SmartHubListPage(),
    SettingsPage(),
    AboutPage()
  ];

  static final List<BottomNavigationBarItem> _tabButtons = _widgetOptions
      .map((e) => BottomNavigationBarItem(
          icon: Icon((e as TabPage).navigationIcon),
          label: (e as TabPage).title))
      .toList();

  int _selectedIndex = 0;

  void _onNavigationTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TabPage _getCurrentPage() {
    return _widgetOptions.elementAt(_selectedIndex) as TabPage;
  }

  FloatingActionButton? _getFloatingActionButton() {
    TabPage currentPage = _getCurrentPage();

    IconData? icon = currentPage.floatingActionButtonIcon;
    Function()? tapCallback = currentPage.floatingActionButtonPressedCallback;

    if (icon != null && tapCallback != null) {
      return FloatingActionButton(
        onPressed: tapCallback,
        child: Icon(icon),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Smart Home Control',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
                (_widgetOptions.elementAt(_selectedIndex) as TabPage).title),
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: _tabButtons,
            currentIndex: _selectedIndex,
            onTap: _onNavigationTabTapped,
          ),
          floatingActionButton: _getFloatingActionButton(),
        ),
        routes: {
          Routes.lightsNew: (context) => const LightAddPage(),
          Routes.lightsEdit: (context) => const LightEditPage(),
        });
  }
}
