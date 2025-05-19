import 'package:doflow/Utils/color_contstants.dart';
import 'package:doflow/View/Login%20Screen/login_screen.dart';
import 'package:doflow/View/Register%20Screen/register_screen.dart';
import 'package:doflow/View/Widgets/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: ColorConstants.MainWhite),
        ),
        backgroundColor: ColorConstants.MainBlack,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Welcome Screen',
              style: TextStyle(
                color: ColorConstants.MainWhite,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.w),
              child: Text(
                textAlign: TextAlign.center,
                'Please login to your account or create new account to continue',
                style: TextStyle(
                  // ignore: deprecated_member_use
                  color: ColorConstants.MainWhite.withOpacity(0.8),
                  fontSize: 16.sp,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  CustomLoginButton(
                    isEnabled: true,
                    name: "LOGIN",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),

                  SizedBox(height: 28.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: ColorConstants.BlueButton,
                          width: 2.w,
                        ),
                      ),

                      child: Center(
                        child: Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 67.h),
          ],
        ),
      ),
    );
  }
}
