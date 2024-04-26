import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/signController.dart';
import 'package:preetprab/screens/home.dart';
import 'package:preetprab/screens/loginScreen.dart';
import 'package:preetprab/utils/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  SignController signController = Get.put(SignController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            SizedBox(
              height: 50,
              child: TextFormField(

                controller: usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  filled: true,fillColor: Colors.brown.shade50,
                  prefixIcon: const Icon(Icons.perm_identity),
                  hintText: 'Username',
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
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  filled: true,fillColor: Colors.brown.shade50,
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Email',
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
            Obx(
              () => SizedBox(
                height: 50,
                child: TextFormField(
                  obscureText: signController.obscure.value,
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: true,fillColor: Colors.brown.shade50,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: (){
                        signController.obscure.value = !signController.obscure.value;
                      },
                      icon: signController.obscure.value ? const Icon( Icons.visibility) : const Icon(Icons.visibility_off),
                    ),
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
            ),
            const Gap(10),
            Obx(() {
              return !signController.isLoading.value
                  ? MaterialButton(
                minWidth: double.infinity,
                shape: StadiumBorder(),
                      color: Colors.brown,
                      onPressed: () async {
                        signController.isLoading.value = true;
                        bool isRegistered = await AuthService().registerUser(
                            usernameController.text,
                            emailController.text,
                            passwordController.text);
                        log('isRegisted : $isRegistered');
                        if (isRegistered) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', true);
                        }
                        signController.isLoading.value = false;
                        isRegistered
                            ? Get.to(() => HomeScreen())
                            : null;
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : const CircularProgressIndicator(color: Colors.brown,);
            }),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Registered?'),
                TextButton(
                    onPressed: () {
                      Get.offAll(LoginPage());
                    },
                    child: const Text('Login',style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
