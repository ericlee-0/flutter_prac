import './screens/screens.dart';
import './widgets/widgets.dart';
import 'package:flutter/material.dart';

class WebHomeNav extends StatefulWidget {
  @override
  _WebHomeNavState createState() => _WebHomeNavState();
}

class _WebHomeNavState extends State<WebHomeNav> {
  final List<Widget> _screens = [
    WebHome(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.contact_phone,
    Icons.location_on,
    Icons.restaurant_menu,
    Icons.add_business
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: TabBarView(children: _screens,) ,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom:12.0),
          child: CustomTabBar(
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
