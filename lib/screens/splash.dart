import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/screens/home.dart';
import 'package:preetprab/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override

  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLogged;
  void checkLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLogged = prefs.getBool('isLoggedIn');
    } catch (e) {
      isLogged = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLoggedIn();

    Timer(const Duration(seconds: 3), () {
      (isLogged == false || isLogged == null)
          ? Get.offAll(() => LoginPage())
          : Get.offAll(() => HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/p&p.png'),
      ),
    );
  }
}
