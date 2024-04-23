import 'dart:async';

import 'package:flutter/material.dart';
import 'package:preetprab/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:       Center(
        child: Image.asset('assets/images/p&p.png'),
      ),
    );

  }
}
