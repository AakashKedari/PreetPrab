import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/homescreen_controller.dart';

import 'package:preetprab/screens/productsTab.dart';
import 'package:preetprab/screens/categoryTab.dart';
import 'package:preetprab/screens/settingsTab.dart';
import '../controllers/products_controller.dart';
import 'cartTab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductsController productsController = Get.find<ProductsController>();
  final HomeScreenController homeScreenController = HomeScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            elevation: 50,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              homeScreenController.currentIndex.value = index;
            },
            currentIndex: homeScreenController.currentIndex.value,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Shop'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Obx(
                    () => Stack(
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          size: 30,
                        ),
                        if (productsController.savedProducts.isNotEmpty)
                          Positioned(
                            // Position the badge on top right of the icon
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child:  Text(
                                  productsController.savedProducts.length
                                      .toString(), // Replace with the dynamic number of items in the cart
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                            ),
                          ),
                      ],
                    ),
                  ),
                  label: 'Cart'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          ),
        ),
        body:
        Obx(
          () => IndexedStack(
            index: homeScreenController.currentIndex.value,
            children: [
              FirstTab(),
              CategoryTab(),
              CartTab(),
              ProfileTab(),
            ],
          ),
        )
        // Obx(() => homeScreenController.currentIndex.value == 0 ?  FirstTab() : homeScreenController.currentIndex.value == 1 ? CategoryTab() : homeScreenController.currentIndex.value == 2 ? CartTab() : ProfileTab()),
        );
  }
}
