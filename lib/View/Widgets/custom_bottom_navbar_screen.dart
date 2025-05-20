import 'dart:developer';

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
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime() async {
    // Pick Date
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: ColorConstants.BlueButton, // Header background
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.white, // Body text color
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.grey[900],
            ), // Dialog background
          ),
          child: child!,
        );
      },
    );

    if (date == null) return; // user canceled

    // Pick Time
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              secondary: ColorConstants.BlueButton,
              primary: ColorConstants.BlueButton,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.grey[900]),
          ),
          child: child!,
        );
      },
    );

    if (time == null) return; // user canceled

    // Combine Date and Time into DateTime
    final DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _selectedDateTime = dateTime;
      log(_selectedDateTime.toString());
    });
  }

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
      'unselectedIcon': 'assets/icons/profile.png',
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
          final TextEditingController _titleController =
              TextEditingController();
          final TextEditingController _descriptionController =
              TextEditingController();
          final FocusNode _focusNode = FocusNode();
          bool hasFocused = false; // <-- NEW FLAG

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            backgroundColor: ColorConstants.BottomSheetBg,
            builder: (context) {
              // Delay focus ONLY ONCE when sheet is built first time
              if (!hasFocused) {
                hasFocused = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).requestFocus(_focusNode);
                });
              }

              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20.w,
                  right: 20.w,
                  top: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // ignore: deprecated_member_use
                        color: ColorConstants.MainWhite.withOpacity(0.87),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    TextField(
                      controller: _titleController,
                      focusNode: _focusNode,

                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: ColorConstants.HintText2),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.TextfieldBorder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: _descriptionController,

                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(color: ColorConstants.HintText2),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstants.TextfieldBorder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        // Image.asset(
                        //   color: ColorConstants.MainWhite,
                        //   'assets/icons/timer.png',
                        // ),
                        InkWell(
                          // implement the date and time picking in
                          onTap: () async {
                            FocusScope.of(
                              context,
                            ).unfocus(); // prevent keyboard reopen
                            await Future.delayed(Duration(milliseconds: 300));

                            _pickDateTime();
                          },
                          child: Icon(
                            Icons.timer_outlined,
                            color: ColorConstants.MainWhite,
                          ),
                        ),
                        SizedBox(width: 32.w),
                        // Image.asset(
                        //   color: ColorConstants.MainWhite,
                        //   'assets/icons/tag.png',
                        // ),
                        Icon(
                          Icons.sell_outlined,
                          color: ColorConstants.MainWhite,
                        ),
                        SizedBox(width: 32.w),
                        // Image.asset(
                        //   color: ColorConstants.MainWhite,
                        //   'assets/icons/flag.png',
                        // ),
                        Icon(
                          Icons.flag_outlined,
                          color: ColorConstants.MainWhite,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.send_outlined,
                            color: ColorConstants.BlueButton,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              );
            },
          );
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
