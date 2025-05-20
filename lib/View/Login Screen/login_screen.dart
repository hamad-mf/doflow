import 'dart:developer';

import 'package:doflow/Utils/color_contstants.dart';
import 'package:doflow/View/Home%20Screen/home_screen.dart';
import 'package:doflow/View/Register%20Screen/register_screen.dart';
import 'package:doflow/View/Widgets/custom_bottom_navbar_screen.dart';
import 'package:doflow/View/Widgets/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final isValid = username.isNotEmpty && password.length >= 6;

    if (isButtonEnabled != isValid) {
      setState(() {
        isButtonEnabled = isValid;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set resizeToAvoidBottomInset to true (it's true by default, but explicitly setting it)
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: ColorConstants.MainWhite),
        ),
        backgroundColor: ColorConstants.MainBlack,
      ),
      body: SafeArea(
        // Wrap with SafeArea to avoid system UI overlaps
        child: GestureDetector(
          // Add GestureDetector to dismiss keyboard when tapping outside
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            // Replace Column with SingleChildScrollView for keyboard handling
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                  // Constrain the content to ensure it takes at least full screen height
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 
                              AppBar().preferredSize.height - 
                              MediaQuery.of(context).padding.top,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: ColorConstants.MainWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.sp,
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Text(
                          "Username",
                          style: TextStyle(
                            color: ColorConstants.MainWhite,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _usernameController,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Enter your Username",
                            hintStyle: TextStyle(color: ColorConstants.HintText),
                            filled: true,
                            fillColor: ColorConstants.TextfieldFill,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorConstants.TextfieldBorder,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          "Password",
                          style: TextStyle(
                            color: ColorConstants.MainWhite,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "• • • • • • • • •",
                            hintStyle: TextStyle(color: ColorConstants.HintText),
                            filled: true,
                            fillColor: ColorConstants.TextfieldFill,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ColorConstants.TextfieldBorder,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40.h),
                        CustomLoginButton(
                          isEnabled: isButtonEnabled,
                          name: "Login",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Your login logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomBottomNavbarScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey, thickness: 1.h)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Text("or", style: TextStyle(color: Colors.grey)),
                            ),
                            Expanded(child: Divider(color: Colors.grey, thickness: 1.h)),
                          ],
                        ),
                        SizedBox(height: 29.h),
                        InkWell(
                          onTap: () {
                            log("implement later");
                          },
                          child: Container(
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: ColorConstants.BlueButton,
                                width: 1.5.w,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google_logo.png',
                                    scale: 0.9,
                                  ),
                                  Text(
                                    "Login with Google",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 29.h),
                        InkWell(
                          onTap: () {
                            log("implement later");
                          },
                          child: Container(
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: ColorConstants.BlueButton,
                                width: 1.5.w,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/apple_logo.png', scale: 0.4),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Login with Apple",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Use Spacer with FlexFit.loose to allow compression
                        Spacer(flex: 1),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              // Add bottom padding that adjusts when keyboard appears
                              bottom: 20.h + MediaQuery.of(context).viewInsets.bottom * 0.1,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Don\'t have an account? ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: 'Register',
                                      style: TextStyle(
                                        color: ColorConstants.MainWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Remove fixed bottom padding so it can adapt
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}