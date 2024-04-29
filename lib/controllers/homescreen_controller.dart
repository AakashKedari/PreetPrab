import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/models/shopProductsDetails.dart';

class HomeScreenController extends GetxController {

  RxInt currentIndex = 0.obs;

  ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 2));

  StreamController<String> hintStreamController = StreamController<String>.broadcast();

  String couponCode = List.generate(6, (_) => Random().nextInt(10)).join().toString();

  int hintIndex = 0;

  Timer? timer;

  RxString currentHint = CategoryEnum.values[0].name.obs;

   Rx<Widget?> label = null.obs;

   RxBool couponReveal = false.obs;

  @override
  void onInit() {
    super.onInit();
    final random = Random();
    print('Coupn Code : $couponCode');
    currentHint = CategoryEnum.values[0].name.obs;
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (hintIndex == 5) {
        hintIndex = 0;

      }
      hintIndex = (hintIndex + 1);
      hintStreamController.add(CategoryEnum.values[hintIndex].name);
      currentHint = CategoryEnum.values[hintIndex].name.obs;
    });
  }

  @override
  void onClose() {
    hintStreamController.close();
    confettiController.dispose();

    super.onClose();
  }
}
