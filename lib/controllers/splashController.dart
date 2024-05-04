import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home.dart';
import '../screens/introPage.dart';

class SplashController extends GetxController{

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () async {
      bool isAlreadyLogged =  await checkAlreadyLoggedIn();

      (isAlreadyLogged == false )
          ? Get.offAll(() => const IntroPage())
          : Get.offAll(() => HomeScreen());
    });
  }

  Future<bool> checkAlreadyLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return  prefs.getBool('isLoggedIn') ?? false;
    } catch (e) {
      return  false;
    }
  }
}