import 'package:doflow/Utils/color_contstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: Icon(Icons.filter_list, color: ColorConstants.MainWhite),
        ),
        title: Text("Home"),
        titleTextStyle: TextStyle(
          color: ColorConstants.MainWhite,
          fontSize: 20,
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.MainBlack,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: CircleAvatar(
              radius: 21,
              backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/2128807/pexels-photo-2128807.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
              ),
              backgroundColor: ColorConstants.MainWhite,
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 110.h),

            Image.asset('assets/images/no_tasks_home.png'),
            Text(
              "What do you want to do today?",

              style: TextStyle(
                fontSize: 20.sp,
                // ignore: deprecated_member_use
                color: ColorConstants.MainWhite.withOpacity(0.87),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Tap + to add your tasks",

              style: TextStyle(
                fontSize: 16.sp,
                // ignore: deprecated_member_use
                color: ColorConstants.MainWhite.withOpacity(0.87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
