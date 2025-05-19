import 'package:doflow/Utils/color_contstants.dart';
import 'package:doflow/View/Login%20Screen/login_screen.dart';
import 'package:doflow/View/Widgets/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _CpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _CpasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final cPassword = _CpasswordController.text;

    final isValid =
        username.isNotEmpty && password.length >= 6 && password == cPassword;

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
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: ColorConstants.MainWhite),
        ),
        backgroundColor: ColorConstants.MainBlack,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Register",
                style: TextStyle(
                  color: ColorConstants.MainWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(height: 53.h),
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
                      // ignore: deprecated_member_use
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
                obscureText: !_isPasswordVisible,
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
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
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
              SizedBox(height: 25.h),
              Text(
                "Confirm Password",
                style: TextStyle(
                  color: ColorConstants.MainWhite,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                obscureText: !_isPasswordVisible,
                controller: _CpasswordController,
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
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 69.h),
              CustomLoginButton(
                isEnabled: isButtonEnabled,
                name: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Your login logic here
                  }
                },
              ),

              Spacer(),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'login',
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
              SizedBox(height: 65.w),
            ],
          ),
        ),
      ),
    );
  }
}
