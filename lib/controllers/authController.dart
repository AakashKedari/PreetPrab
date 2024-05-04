import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home.dart';
import '../utils/auth.dart';

class AuthController extends GetxController {
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  RxBool isLoading = false.obs;

  RxBool obscure = true.obs;

  Future<void> logIn() async {
    /// To make the keyboard disappear if using decides to click login button
    FocusScope.of(Get.context!).unfocus();
    isLoading.value = true;
    bool isValid = await AuthService()
        .authenticate(loginEmailController.text, loginPasswordController.text);
    log("The User validation is ${isValid.toString()}");
    if (!isValid) {
      isLoading.value = false;
    } else{
      registerNameController.dispose();
      registerEmailController.dispose();
      registerPasswordController.dispose();
      loginPasswordController.dispose();
      loginEmailController.dispose();
    }
    isValid ? Get.offAll(() => HomeScreen()) : null;
  }

  Future<void> registerNewUser() async {
    /// To make the keyboard disappear if using decides to click login button
    FocusScope.of(Get.context!).unfocus();
    isLoading.value = true;
    bool isRegistered = await AuthService().registerUser(
        registerNameController.text, registerEmailController.text, registerPasswordController.text);
    log('isRegisted : $isRegistered');
    if (isRegistered) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      registerNameController.dispose();
      registerEmailController.dispose();
      registerPasswordController.dispose();
      loginPasswordController.dispose();
      loginEmailController.dispose();
    }
    isLoading.value = false;
    isRegistered ? Get.to(() => HomeScreen()) : null;
  }
  //
  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   loginPasswordController.dispose();
  //   loginEmailController.dispose();
  //   registerPasswordController.dispose();
  //   registerEmailController.dispose();
  //   registerNameController.dispose();
  //   print('Text Fields disposed');
  // }
}
