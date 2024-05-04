import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class TnCWidget extends StatelessWidget {
  final String termsUrl;
  final String privacyUrl;

  const TnCWidget({super.key,
    required this.termsUrl,
    required this.privacyUrl,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: const TextStyle(color: Colors.white),
        children: <TextSpan>[
          const TextSpan(text: 'By using this app, I agree to the '),
          TextSpan(
            text: 'Terms & Conditions',
            style: const TextStyle(color: Colors.white,decoration: TextDecoration.underline,fontWeight: FontWeight.w900),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              // TODO: adding a URl to the privacy policy of App
              // launch(termsUrl);
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(color: Colors.white,
                decoration: TextDecoration.underline,fontWeight: FontWeight.bold,
            decorationThickness: 0.5

            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: adding a URl to the privacy policy of App
              // launch(privacyUrl);
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}