import 'package:flutter/material.dart';
import 'package:safe_guard/screens/alerts_chat_screen.dart';
import 'package:safe_guard/screens/emergency_map_screen.dart';
import 'package:safe_guard/screens/home_screen.dart';
import 'package:safe_guard/screens/medical_id_screen_screen.dart';
import 'package:safe_guard/screens/settings_screen.dart';
import 'package:safe_guard/theme/theme.dart';

void main() {
  runApp(const SafeGuardApp());
}

class SafeGuardApp extends StatelessWidget {
  const SafeGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeGuard',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const EmergencyMapScreen(),
    const AlertsChatScreen(),
    const MedicalIDScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'แผนที่ฉุกเฉิน',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'การแจ้งเตือน',
          ),
          NavigationDestination(
              icon: Icon(Icons.medical_services), label: 'ข้อมูลทางการแพทย์'),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'การตั้งค่า',
          ),
        ],
      ),
    );
  }
}
