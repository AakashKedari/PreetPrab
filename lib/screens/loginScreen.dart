import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/signController.dart';
import 'package:preetprab/screens/home.dart';
import 'package:preetprab/screens/registerScreen.dart';
import '../utils/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignController signController = Get.put(SignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/images/transparent.png',
          width: 120,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(

              controller: usernameController,
              decoration: InputDecoration(
                filled: true,fillColor: Colors.brown.shade50,
                prefixIcon: const Icon(Icons.email),
                hintText: 'Username or Email',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const Gap(10),
            Obx(
              ()=> TextFormField(

                controller: passwordController,
                obscureText: signController.obscure.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){
                        signController.obscure.value = !signController.obscure.value;
                      },
                      icon: signController.obscure.value ? const Icon( Icons.visibility) : const Icon(Icons.visibility_off),
                    ),

                  filled: true,fillColor: Colors.brown.shade50,
                  prefixIcon: const Icon(Icons.password),
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Center(child: Obx(() {
              return !signController.isLoading.value
                  ? MaterialButton(
                      color: Colors.brown,
                      onPressed: () async {
                        signController.isLoading.value = true;
                        bool isValid = await AuthService().authenticate(
                            usernameController.text, passwordController.text);
                        log("The User validation is ${isValid.toString()}");
                        isValid
                            ? Get.offAll(() => HomeScreen())
                            : null;
                        signController.isLoading.value = false;
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ))
                  : const CircularProgressIndicator();
            })),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New User?'),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => RegisterPage());
                    },
                    child: const Text('Register',style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
