import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/products_controller.dart';

  Widget ProfileTab() {
    ProductsController productsController = Get.find<ProductsController>();
    print('Settings Tab Called');
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  'assets/images/settings.png',
                  fit: BoxFit.cover,
                ),
              ),
               ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/men.png'),
                ),
                title: Text(productsController.allShopProductDetails.value?.users![0].username ?? '',style: const TextStyle(fontSize: 15),),
              ),
              ListTile(
                horizontalTitleGap: 30,
                leading: const Icon(
                  Icons.email,
                  size: 30,
                ),
                title: Text(productsController.allShopProductDetails.value?.users![0].email ?? '',style: const TextStyle(fontSize: 15),),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'General Settings',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                ),
              ),
               ListTile(
                leading: const Icon(Icons.favorite_outline_sharp, color: Colors.grey,),
                title: const Text('My Cart',style: TextStyle(fontWeight: FontWeight.w200,fontSize: 15),),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${productsController.savedProducts.length} items',
                      style: const TextStyle(color: Colors.cyan),
                    ),
                    const Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.notifications_active, color: Colors.grey,),
                title: const Text('Get Notification',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 15),),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: true,
                    onChanged: (bool value) {},
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Order Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const ListTile(
                horizontalTitleGap: 30,
                leading: Icon(
                  color: Colors.grey,
                  Icons.delivery_dining_sharp,
                  size: 30,
                ),
                title: Text('Order History',style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const ListTile(
                horizontalTitleGap: 30,
                leading: Icon( color: Colors.grey,
                  Icons.star_rate_outlined,
                  size: 30,
                ),
                title: Text('Rate the App',style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const ListTile(
                horizontalTitleGap: 30,
                leading: Icon( color: Colors.grey,
                  Icons.logout,
                  size: 30,
                ),
                title: Text('Logout',style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
      ),
    );
  }

