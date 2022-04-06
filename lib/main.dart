import 'package:flutter/material.dart';
import 'package:smart_home_control/views/components/navigation_drawer.dart';
import 'package:smart_home_control/views/pages/light_add_page.dart';
import 'package:smart_home_control/views/pages/light_edit_page.dart';

import 'package:smart_home_control/views/pages/about_page.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';
import 'package:smart_home_control/views/pages/settings_page.dart';
import 'package:smart_home_control/views/pages/smart_hub_list_page.dart';
import 'package:smart_home_control/interfaces/tab_page.dart';

import 'routes/routes.dart';

void main() {
  runApp(const SmartHomeControlApp());
}

class SmartHomeControlApp extends StatefulWidget {
  const SmartHomeControlApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmartHomeControlAppState();
}

class _SmartHomeControlAppState extends State<SmartHomeControlApp>
    with TickerProviderStateMixin {
  static const List<Widget> _widgetOptions = <Widget>[
    LightListPage(),
    SmartHubListPage()
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _widgetOptions.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              centerTitle: true,
              title: const Text('Smart Home Control'),
            ),
            body: TabBarView(
              controller: _tabController,
              children: _widgetOptions.map((e) => Container(child: e)).toList(),
            ),
            drawer: const NavigationDrawer(),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 50,
                child: _buildTabBar(),
              ),
            )),
        routes: {
          Routes.lightsNew: (context) => const LightAddPage(),
          Routes.lightsEdit: (context) => const LightEditPage(),
          Routes.settings: (context) => const SettingsPage(),
          Routes.about: (context) => const AboutPage()
        });
  }

  TabBar _buildTabBar() {
    return TabBar(
        controller: _tabController,
        tabs: _widgetOptions
            .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon((e as TabPage).tabBarIcon),
                    Text((e as TabPage).tabBarText)
                  ],
                ))
            .toList());
  }
}
