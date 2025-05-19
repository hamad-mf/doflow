import 'package:doflow/Utils/color_contstants.dart';
import 'package:doflow/View/Calendar%20Screen/calendar_screEn.dart';
import 'package:doflow/View/Focus%20Screen/focus_screen.dart';
import 'package:doflow/View/Home%20Screen/home_screen.dart';
import 'package:doflow/View/Profile%20Screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavbarScreen extends StatefulWidget {
  const CustomBottomNavbarScreen({super.key});

  @override
  State<CustomBottomNavbarScreen> createState() =>
      _CustomBottomNavbarScreenState();
}

class _CustomBottomNavbarScreenState extends State<CustomBottomNavbarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CalendarScreen(),
    FocusScreen(),
    ProfileScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {
      'selectedIcon': 'assets/icons/home_filled.png',
      'unselectedIcon': 'assets/icons/home.png',
      'label': 'Home',
    },
    {
      'selectedIcon': 'assets/icons/calendar_filled.png',
      'unselectedIcon': 'assets/icons/calendar.png',
      'label': 'Calendar',
    },
    {
      'selectedIcon': 'assets/icons/focus_filled.png',
      'unselectedIcon': 'assets/icons/focus.png',
      'label': 'Focus',
    },
    {
      'selectedIcon': 'assets/icons/profile_filled.png',
      'unselectedIcon': 'assets//icons/profile.png',
      'label': 'Profile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          // Handle your FAB action here
        },
        backgroundColor: ColorConstants.BlueButton,
        child: Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.grey[900],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left nav items
              Row(children: [_buildNavItem(0), _buildNavItem(1)]),
              // Right nav items
              Row(children: [_buildNavItem(2), _buildNavItem(3)]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    bool isSelected = _currentIndex == index;

    return MaterialButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSelected
                ? _navItems[index]['selectedIcon']
                : _navItems[index]['unselectedIcon'],
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(height: 4.h),
          Text(
            _navItems[index]['label'],
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
