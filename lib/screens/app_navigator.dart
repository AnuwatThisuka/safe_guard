import 'package:flutter/material.dart';
import 'package:safe_guard/screens/alerts_chat_screen.dart';
import 'package:safe_guard/screens/emergency_map_screen.dart';
import 'package:safe_guard/screens/home_screen.dart';
import 'package:safe_guard/screens/medical_id_screen_screen.dart';
import 'package:safe_guard/screens/settings_screen.dart';
import 'package:safe_guard/theme/theme.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          _buildNavItem(0, Icons.home, Icons.home_outlined, 'หน้าหลัก'),
          _buildNavItem(
              1, Icons.explore, Icons.explore_outlined, 'แผนที่ฉุกเฉิน'),
          _buildNavItemWithBadge(2, Icons.notifications,
              Icons.notifications_outlined, 'การแจ้งเตือนและแชท', '3'),
          _buildNavItem(3, Icons.medical_services,
              Icons.medical_services_outlined, 'ข้อมูลทางการแพทย์'),
          _buildProfileNavItem(4, 'การตั้งค่า'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      int index, IconData selectedIcon, IconData unselectedIcon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(_selectedIndex == index ? selectedIcon : unselectedIcon,
          size: 28),
      label: label,
    );
  }

  BottomNavigationBarItem _buildNavItemWithBadge(
      int index,
      IconData selectedIcon,
      IconData unselectedIcon,
      String label,
      String badgeCount) {
    return BottomNavigationBarItem(
      icon: _selectedIndex == index
          ? Badge(
              label:
                  Text(badgeCount, style: const TextStyle(color: Colors.white)),
              child: Icon(selectedIcon, size: 28),
            )
          : Icon(unselectedIcon, size: 28),
      label: label,
    );
  }

  BottomNavigationBarItem _buildProfileNavItem(int index, String label) {
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 14,
        backgroundColor: _selectedIndex == index
            ? AppTheme.primaryColor
            : Colors.grey.shade200,
        child: Icon(Icons.person,
            color: _selectedIndex == index ? Colors.white : Colors.grey,
            size: 18),
      ),
      label: label,
    );
  }
}
