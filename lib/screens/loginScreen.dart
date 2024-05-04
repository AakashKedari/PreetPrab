import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/authController.dart';
import 'package:preetprab/screens/registerScreen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

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
              'Welcome back',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800, color: baseColor),
              textAlign: TextAlign.start,
            ),
            const Gap(10),
            SizedBox(
              height: 50,
              child: Center(
                child: CommonDesignTextField('Username/Email'),
              ),
            ),
            const Gap(10),
            Obx(
              () => SizedBox(
                height: 50,
                child: CommonDesignTextField('Password'),
              ),
            ),
            const Gap(10),
            Obx(() {
              return !authController.isLoading.value
                  ? MaterialButton(
                      shape: const StadiumBorder(),
                      minWidth: double.infinity,
                      color: baseColor,
                      onPressed: authController.logIn,
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ))
                  : const Center(
                      child: CupertinoActivityIndicator(
                      color: baseColor,
                      radius: 15,
                    ));
            }),
            const Gap(5),
            const Center(child: Text('Or Login with')),
            const Gap(5),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.facebook,
                      color: baseColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: baseColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.instagram,
                      color: baseColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User? '),
                  InkWell(
                      onTap: () {
                        Get.offAll(() => RegisterPage());
                      },
                      child: const Text('Register',
                          style: TextStyle(
                              color: baseColor,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField CommonDesignTextField(
    String hintText,
  ) {
    return TextFormField(
      enableSuggestions: hintText != 'Password' ? true : false,
      autocorrect: hintText != 'Password' ? true : false,
      textAlignVertical:
          TextAlignVertical.center, // Centers the text vertically
      controller: hintText != 'Password'
          ? authController.loginEmailController
          : authController.loginPasswordController,
      decoration: InputDecoration(
          prefixIcon: hintText != 'Password'
              ? const Icon(Icons.email)
              : const Icon(Icons.password),
          hintText: hintText,
          hintTextDirection: TextDirection.ltr,
          contentPadding: EdgeInsets.zero,
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
          suffixIcon: hintText == "Password"
              ? IconButton(
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
                )
              : null),
      obscureText: hintText == 'Password'
          ? authController.obscure.value
              ? true
              : false
          : false,
    );
  }
}
