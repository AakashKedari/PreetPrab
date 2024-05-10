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

   Rx<Widget?> label = null.obs;

   RxBool couponReveal = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('Coupon Code : $couponCode');
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (hintIndex == 5) {
        hintIndex = 0;
      }
      hintIndex = (hintIndex + 1);
      hintStreamController.add(CategoryEnum.values[hintIndex].name);
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    hintStreamController.close();
    confettiController.dispose();
    super.onClose();
  }
}
