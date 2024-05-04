import 'package:get/get.dart';
import 'package:preetprab/controllers/splashController.dart';

class SplashBinding implements Bindings{

  @override
  void dependencies(){
    Get.lazyPut<SplashController>(() => SplashController());
  }
}