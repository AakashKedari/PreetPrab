import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/screens/indiProductInfo.dart';
import 'checkout.dart';

class CartTab extends StatefulWidget {
  CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> with AutomaticKeepAliveClientMixin {
  final ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    log('Cart Build Method Called');
    super.build(context);

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
                        .headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  trailing: MaterialButton(
                    color: Colors.black,
                    onPressed: (){    Get.to(() => const CheckOut()) ;},
                    child: const Text('CHECKOUT',style: TextStyle(color: Colors.white),),
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
                            const Gap(10),
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
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.grey,
                                )),
                        Text(
                          productsController.savedProducts.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
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
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Rs. ${totalCost.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
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
                        color: baseColor,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
