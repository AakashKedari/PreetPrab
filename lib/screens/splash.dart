import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/splashController.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController _splashController = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/p&p.png' ,filterQuality: FilterQuality.high,),
      ),
    );
  }
}
