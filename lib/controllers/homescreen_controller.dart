import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/models/shopProductsDetails.dart';

class HomeScreenController extends GetxController {

  RxInt currentIndex = 0.obs;

  StreamController<String> hintStreamController = StreamController<String>.broadcast();

  int hintIndex = 0;

  Timer? timer;

  RxString currentHint = CategoryEnum.values[0].name.obs;

   Rx<Widget?> label = null.obs;

  @override
  void onInit() {
    super.onInit();
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
    log("Stream Closed");
    super.onClose();
  }
}
