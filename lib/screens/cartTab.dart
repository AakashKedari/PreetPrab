import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/screens/indiProductInfo.dart';
import 'checkout.dart';

class CartTab extends StatelessWidget {
  CartTab({super.key});

  final ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    log('Cart Build Method Called');

    num totalCost = productsController.savedProducts
        .fold(0, (sum, item) => sum + int.parse(item.price!));

    return Obx(
      () => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ListTile(
                  leading: const Icon(Icons.arrow_downward_sharp),
                  title: Text(
                    'CART',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  trailing: InkWell(
                    onTap: () {
                     Get.to(() => const CheckOut()) ;
                    },
                    child: Material(
                      elevation: 5,
                      child: Container(
                        height: 50,
                        width: 100,
                        color: Colors.cyan,
                        child: const Center(
                            child: Text(
                          'CHECKOUT',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                      ),
                    ),
                  )),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productsController.savedProducts.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ProductInfo(
                            product: productsController
                                .savedProducts[index]));
                      },
                      child: Card(
                        child: Row(

                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                productsController.savedProducts
                                    .removeAt(index);
                              },
                            ),
                            CachedNetworkImage(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.3,
                              imageUrl: productsController
                                  .savedProducts[index].images![0],
                            ),
                            Gap(10),
                            Expanded(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.2,

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        productsController
                                            .savedProducts[index].title!,
                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                        maxLines: 3,
                                      ),
                                    ),
                                    Text(
                                        "Rs. ${productsController.savedProducts[index].price}"),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        // ListTile(
                        //   trailing: Text("Rs. ${productsController.savedProducts[index].price}"),
                        //   leading: IconButton(
                        //     icon: const Icon(Icons.remove_circle_outline),
                        //     onPressed: () {
                        //         productsController.savedProducts.removeAt(index);
                        //     },
                        //   ),
                        //   title: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       CachedNetworkImage(
                        //         height:MediaQuery.of(context).size.height * 0.3,
                        //         width: MediaQuery.of(context).size.width * 0.3,
                        //         imageUrl: productsController.savedProducts[index].images![0],
                        //       ),
                        //       Flexible(
                        //           child: Text(
                        //         productsController.savedProducts[index].title!,
                        //         style: const TextStyle(fontSize: 10),
                        //         maxLines: 3,
                        //       ))
                        //     ],
                        //   ),
                        // ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Products : ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.grey,
                                )),
                        Text(
                          productsController.savedProducts.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w100,
                                color: Colors.grey,
                              ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total : ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Rs. ${totalCost.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        productsController.savedProducts.clear();
                      },
                      child: Container(
                        height: 40,
                        color: Colors.black,
                        child: const Center(
                            child: Text(
                          'CLEAR CART',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
