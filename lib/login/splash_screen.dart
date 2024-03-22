import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/login/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? accessToken;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    getValidationData().whenComplete(() {
      Timer(Duration(seconds: 3), () => Get.to(
          accessToken == null ?
          LoginScreen()
              : MainScreen(token: '$accessToken')));
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var ObtainedaccesstToken= sharedPreferences.getString('accessToken');
    setState(() {
      accessToken = ObtainedaccesstToken;
    });
    print('splash Screen : $accessToken');
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        color: Colors.black,
        child: Image.asset("assets/gymsoftLogo.png"),
      ),
    );
  }
}
