import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w800,color: const Color(0xffC23602)),textAlign: TextAlign.start,),
            const Gap(10),
            SizedBox(
              height: 50,
              child: Center(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center, // Centers the text vertically
                  controller: usernameController,
                  decoration: const InputDecoration(

                    prefixIcon: Icon(Icons.email),
                    hintText: 'Username/Email',
                    hintTextDirection: TextDirection.ltr,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Color of the underline
                        width: 1.0,
                      ),),
                    focusedBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Color of the underline
                        width: 1.0,
                      ),),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Obx(
              ()=> SizedBox(
                height: 50,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: passwordController,
                  obscureText: signController.obscure.value,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: IconButton(
                        onPressed: (){
                          signController.obscure.value = !signController.obscure.value;
                        },
                        icon: signController.obscure.value ? const Icon( Icons.visibility,color: baseColor,) : const Icon(Icons.visibility_off,color: baseColor,),
                      ),

                    // filled: true,fillColor: Colors.brown.shade50,
                    prefixIcon: const Icon(Icons.password),
                    hintText: 'Password',
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey, // Color of the underline
                          width: 1.0,
                        ),),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Color of the underline
                        width: 1.0,
                      ),),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Obx(() {
              return !signController.isLoading.value
                  ? MaterialButton(

                  shape: const StadiumBorder(),
                  minWidth: double.infinity,
                      color: baseColor,
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
                  : const Center(child: CircularProgressIndicator(color: Color(0xffC23602),));
            }),
            const Gap(10),
            const Center(child: Text('Or Login With')),
            const Gap(10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(FontAwesomeIcons.facebook,color: baseColor,), onPressed: () {  },),

                  IconButton(icon: const Icon(FontAwesomeIcons.google,color: baseColor,), onPressed: () {  },),
                  IconButton(icon: const Icon(FontAwesomeIcons.instagram,color:baseColor,), onPressed: () {  },),

                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New User?'),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => RegisterPage());
                    },
                    child: const Text('Register',style: TextStyle(color: Color(0xffC23602),fontWeight: FontWeight.bold)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
