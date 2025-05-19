import 'package:doflow/Utils/color_contstants.dart';
import 'package:doflow/View/Welcome%20Screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                image: 'assets/images/manage_tasks.png',
                title: "Manage your tasks",
                subtitle:
                    "You can easily manage all of your daily tasks in DoMe for free",
              ),
              buildPage(
                image: 'assets/images/persanolize.png',
                title: "Persanolize your tasks",
                subtitle:
                    "In DoFlow you can create your personalized routine to stay productive",
              ),
              buildPage(
                image: 'assets/images/organize.png',
                title: "Organize your tasks",
                subtitle:
                    "You can organize your daily tasks by adding your tasks into separate categories",
              ),
            ],
          ),

          // SmoothPageIndicator
          Positioned(
            bottom: 450.h,
            left: -12,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 4.h,
                  dotWidth: 15.w,
                  activeDotColor: ColorConstants.MainWhite,
                ),
              ),
            ),
          ),

          // Buttons
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    "BACK",
                    style: TextStyle(color: ColorConstants.MainWhite),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (onLastPage) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(onLastPage ? "Get Started" : "Next"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConstants.MainWhite,
                    backgroundColor: ColorConstants.BlueButton,
                    minimumSize: Size(90.h, 48.w),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 80.h),
      child: Column(
        children: [
          Image.asset(image, height: 250.h),
          SizedBox(height: 105.h),
          Text(
            title,
            style: TextStyle(
              color: ColorConstants.MainWhite,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.MainWhite,
            ),
          ),
        ],
      ),
    );
  }
}
