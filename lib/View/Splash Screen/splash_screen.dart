import 'dart:async';
import 'dart:developer';

import 'package:doflow/Utils/color_contstants.dart';
import 'package:doflow/View/OnBoarding%20Screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ Import this

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    log("checking login status");

    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('assets/images/MAIN_LOGO.png'),
              width: 120.w, // ✅ responsive width
              height: 120.h, // ✅ responsive height
            ),
            SizedBox(height: 35.h), // ✅ responsive spacing
            Text(
              "DoFlow",
              style: TextStyle(
                color: ColorConstants.MainWhite,
                fontSize: 40.sp, // ✅ responsive text
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
