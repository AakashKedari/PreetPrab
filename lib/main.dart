
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/screens/splash.dart';

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();
    // Set your image cache size
    imageCache.maximumSizeBytes = 1024 * 1024 * 100; // 100 MB
    return imageCache;
  }
}

void main() {

  CustomImageCache();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.put(ProductsController());
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}
