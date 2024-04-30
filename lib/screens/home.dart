import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/homescreen_controller.dart';
import 'package:preetprab/screens/productsTab.dart';
import 'package:preetprab/screens/settingsTab.dart';
import 'package:preetprab/screens/wishlistTab.dart';
import '../controllers/products_controller.dart';
import 'cartTab.dart';
import 'categoryTab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductsController productsController = Get.find<ProductsController>();
  final HomeScreenController homeScreenController = HomeScreenController();

  final PageController controller = PageController();

  final tabPages =  [
      FirstTab(),
      CategoryTab(),
      WishListTab(),
      CartTab(),
      ProfileTab(),
    ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show modal bottom sheet as soon as the screen builds
      Future.delayed(const Duration(seconds: 1), () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          elevation: 10,
          shape: const CircleBorder(),
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          builder: (BuildContext context) {
            return Obx(() => Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ConfettiWidget(
                                emissionFrequency: 0.3,
                                confettiController:
                                    homeScreenController.confettiController,
                                blastDirectionality:
                                    BlastDirectionality.explosive,
                                shouldLoop: false,
                              ),
                              if (homeScreenController.couponReveal.value ==
                                  false)
                                Icon(
                                  MdiIcons.gift,
                                  opticalSize: 10.0,
                                  size: 200,
                                  color: Colors.deepPurpleAccent,
                                ),

                              if (homeScreenController.couponReveal.value)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              shape: BoxShape.rectangle,
                                              color: Colors.purple),
                                          child: const Row(
                                            children: [
                                              Gap(5),
                                              Text(
                                                'Coupon Code',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Gap(5),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              shape: BoxShape.rectangle,
                                              color: Colors.blue),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Gap(10),
                                              Text(
                                                homeScreenController.couponCode,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 5.0,
                                                color: Colors.black,
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(
                                                      text: homeScreenController
                                                          .couponCode));
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Coupon code copied to clipboard!'),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '10% Off on First Purchase!!!',
                                      style: TextStyle(
                                          color: Colors.purple.shade300),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (!homeScreenController.couponReveal.value)
                            const Center(
                              child: Text(
                                'Welcome to Preet & Prab',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 15),
                              ),
                            ),
                          if (!homeScreenController.couponReveal.value)
                            const Text(
                              'A Surprise awaits you',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 10),
                            ),
                        ],
                      ),
                    ),
                    if (homeScreenController.couponReveal.value == false)
                      MaterialButton(
                        shape: const StadiumBorder(),
                        color: Colors.white.withOpacity(0.8),
                        onPressed: () {
                          homeScreenController.confettiController.play();
                          homeScreenController.couponReveal.value = true;
                          // Future.delayed(
                          //     const Duration(seconds: 5),
                          //     () => homeScreenController.confettiController
                          //         .dispose()); },
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text('Tap to Unlock'),
                        ),
                      )
                  ],
                ));
          },
        );
      });
    });

    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              controller.jumpToPage(index);
              homeScreenController.currentIndex.value = index;
            },
            currentIndex: homeScreenController.currentIndex.value,
            selectedItemColor: baseColor,
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
                          Icons.favorite,
                          size: 30,
                        ),
                        if (productsController.wishlistProducts.isNotEmpty)
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
                              child: Text(
                                productsController.wishlistProducts.length
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
                  ), label: 'Wishlist'),
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
                              child: Text(
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
        body: PageView(
            controller: controller,
            children: tabPages,
            onPageChanged: (index){
              homeScreenController.currentIndex.value = index;
            },
          )
          //     IndexedStack(
          //   index: homeScreenController.currentIndex.value,
          //   children: [
          //     FirstTab(),
          //     CategoryTab(),
          //     WishListTab(),
          //     CartTab(),
          //     ProfileTab(),
          //   ],
          // ),

        // Obx(() => homeScreenController.currentIndex.value == 0 ?  FirstTab() : homeScreenController.currentIndex.value == 1 ? CategoryTab() : homeScreenController.currentIndex.value == 2 ? CartTab() : ProfileTab()),
        );
  }
}
