import 'package:doflow/Utils/color_contstants.dart';
import 'package:flutter/material.dart';

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
                'https://i.ibb.co/4ZW5gcpn/image.png',
              ),
              backgroundColor: ColorConstants.MainWhite,
            ),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/no_tasks_home.png')),
          Center(
            child: Text("data"),
          )
        ],
      ),
    );
  }
}
