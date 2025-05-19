import 'package:doflow/Utils/color_contstants.dart';

import 'package:doflow/View/Splash%20Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).apply(bodyColor: ColorConstants.MainWhite),
          useMaterial3: true,
          scaffoldBackgroundColor: ColorConstants.MainBlack),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
