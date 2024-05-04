import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/authController.dart';
import 'package:preetprab/screens/loginScreen.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final AuthController authController = Get.put(AuthController());

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
          filterQuality: FilterQuality.high,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join P&P Family',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800, color: baseColor),
              textAlign: TextAlign.start,
            ),
            const Gap(10),
            SizedBox(
              height: 50,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: authController.registerNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.perm_identity),
                  hintText: 'Username',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, // Color of the underline
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, // Color of the underline
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            SizedBox(
              height: 50,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: authController.registerEmailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, // Color of the underline
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, // Color of the underline
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Obx(
              () => SizedBox(
                height: 50,
                child: TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: authController.obscure.value,
                  controller: authController.registerPasswordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        authController.obscure.value =
                            !authController.obscure.value;
                      },
                      icon: authController.obscure.value
                          ? const Icon(
                              Icons.visibility,
                              color: baseColor,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: baseColor,
                            ),
                    ),
                    hintText: 'Password',
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Color of the underline
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Color of the underline
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Obx(() {
              return !authController.isLoading.value
                  ? MaterialButton(
                      minWidth: double.infinity,
                      shape: const StadiumBorder(),
                      color: baseColor,
                      onPressed: authController.registerNewUser,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : const Center(
                      child: CupertinoActivityIndicator(
                      color: baseColor,
                    ));
            }),
            // const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Registered?'),
                TextButton(
                    onPressed: () {
                      Get.offAll(() => LoginPage());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: baseColor, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
