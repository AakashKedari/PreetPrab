
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:preetprab/screens/productsTab.dart';
import 'package:preetprab/screens/searchTab.dart';
import 'package:preetprab/screens/settingsTab.dart';
import '../controllers/products_controller.dart';
import 'cartTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 50,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            currentIndex = index++;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items:  const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon :  Icon(Icons.shopping_bag,size: 30,),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
              // Stack(
              //   children: [
              //     const Icon(Icons.shopping_bag,size: 30,),
              //    if(savedProducts.isNotEmpty)
              //      Positioned( // Position the badge on top right of the icon
              //       top: 0,
              //       right: 0,
              //       child: Container(
              //         padding: const EdgeInsets.all(1),
              //         decoration: BoxDecoration(
              //           color: Colors.red,
              //           borderRadius: BorderRadius.circular(6),
              //         ),
              //         constraints: const BoxConstraints(
              //           minWidth: 12,
              //           minHeight: 12,
              //         ),
              //         child:  Text(
              //           savedProducts.length.toString(), // Replace with the dynamic number of items in the cart
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontSize: 8,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //   ],
              // ), label: 'Cart'),

        ],
      ),
      body:
      IndexedStack(
        index: currentIndex,
        children: [
            FirstTab(),SearchCategory(),  CartTab(), ProfileTab(),
        ],
      )
      // currentIndex == 0 ? const FirstTab() : currentIndex == 1 ? SearchCategory() : currentIndex == 2 ? CartTab() : ProfileTab()
    );
  }
}


