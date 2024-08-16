import 'package:al_dalel/layers/view/screens/bus_stop/bus_stop_screen.dart';
import 'package:al_dalel/layers/view/screens/chatbot_screen/chatbot_screen.dart';
import 'package:al_dalel/layers/view/screens/nearest_government_building_screen/nearest_government_building_screen.dart';
import 'package:al_dalel/layers/view/screens/profile/profile_screen.dart';
import 'package:al_dalel/layers/view/screens/services_screen/services_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ServicesScreen(),
    ChatBotScreen(),
    NearestGovernmentBuildingScreen(),
    BusStopScreen(),
    ProfileScreen(),
  ];

  final Map<String, IconData> _icons = {
    "Home": Icons.home,
    "Chat bot": Icons.rocket_launch,
    "Building": Icons.account_balance_sharp,
    "Bus": Icons.directions_bus,
    "Settings": Icons.settings
  };

  final Map<String, String> _titles = {
    "Home": "الرئيسية",
    "Chat bot": "المساعد",
    "Building": "معاملاتي",
    "Bus": "النقل",
    "Settings": "الإعدادات"
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: _icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30,
                  ),
                  label: _titles[title],
                )))
            .values
            .toList(),
        selectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        currentIndex: _currentIndex,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
