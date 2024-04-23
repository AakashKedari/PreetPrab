import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/main.dart';
import '../models/shopProductsDetails.dart';
import 'indiProductInfo.dart';

class CategoryTab extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  final ProductsController productsController = Get.find<ProductsController>();

  CategoryTab({super.key});

  void fetchCategoryWiseProducts(CategoryEnum categoryEnum) {
    productsController.categorisedList.value = productsController
        .allShopProductDetails.value!.products!
        .where((product) {
      log(product.categories.toString());
      return product.categories!.contains(categoryEnum);
    }).toList();
    double position = MediaQuery.of(navigatorKey.currentContext!).size.height -
        AppBar().preferredSize.height -
        25;
    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    log(' Catgory Tab Built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 8,
        centerTitle: false,
        title: Image.asset(
          'assets/images/transparent.png',
          width: 120,
        ),
        actions: [
          const Icon(Icons.notifications),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_rounded),
            onSelected: (value) {
              value == 'Low to High'
                  ? productsController.sortProductsByPriceAsc()
                  : productsController.sortProductsByPriceDesc();
            },
            itemBuilder: (BuildContext context) {
              return {'High to Low', 'Low to High'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shop',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: CategoryEnum.values.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Gap(10),
                        InkWell(
                          onTap: () {
                            fetchCategoryWiseProducts(
                                CategoryEnum.values[index]);
                          },
                          child: SizedBox(
                            height: 80,
                            child: Card(
                              color: Colors.brown.shade400,
                              child: ListTile(
                                title: Text(
                                  CategoryEnum.values[index].name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  })
              // ListView(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     const Gap(10),
              //     InkWell(
              //       onTap: (){
              //         productsController.categorisedList.value = productsController.allShopProductDetails.value!.products
              //             !.where((product) {
              //               log(product.categories.toString());
              //             return product.categories!.contains(CategoryEnum.KURTIS);
              //             }
              //         ).toList();
              //         double position = 1* 100;
              //         scrollController.animateTo(
              //           position,duration: const Duration(milliseconds: 300), curve: Curves.easeOut,
              //         );
              //       },
              //       child: SizedBox(
              //         height: 80,
              //         child: Card(
              //           color: Colors.brown.shade200,
              //           child: const ListTile(
              //             title: Text('Kurtis',style: TextStyle(color: Colors.white),),
              //           ),
              //         ),
              //       ),
              //     ),const Gap(10),
              //     SizedBox(
              //       height: 80,
              //       child: Card(
              //         color: Colors.brown.shade300,
              //         child: const ListTile(title: Text('Gown',style: TextStyle(color: Colors.white),),),
              //       ),
              //     ),const Gap(10),
              //     SizedBox(
              //       height: 80,
              //       child: Card(
              //         color: Colors.brown.shade100,
              //         child: const ListTile(title: Text('Short Dresses',style: TextStyle(color: Colors.white),),),
              //       ),
              //     ),const Gap(10),
              //     SizedBox(
              //       height: 80,
              //       child: Card(
              //         color: Colors.brown.shade400,
              //         child: const ListTile(title: Text('Long Dresses',style: TextStyle(color: Colors.white),)),
              //       ),
              //     )
              //   ],
              // ),
              ,
              Obx(() => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.5),
                      itemCount: productsController.categorisedList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ProductInfo(
                                  product: productsController
                                      .categorisedList[index]));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Stack(
                                    children: [
                                      const Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child:
                                              CircularProgressIndicator(), // Add CircularProgressIndicator here
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                productsController
                                                    .categorisedList[index]
                                                    .images![0]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    productsController
                                        .categorisedList[index].title!,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                Text(
                                  "Rs. ${productsController.categorisedList[index].price}",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  overflow: TextOverflow.fade,
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  // ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  // itemCount: productsController.categorisedList.length,
                  // itemBuilder: (context, index) {
                  //   final categoryProduct = productsController.categorisedList[index];
                  //   return InkWell(
                  //     child: ListTile(
                  //       title: CachedNetworkImage(imageUrl: categoryProduct.images![0],
                  //
                  //       ),
                  //     ),
                  //   );
                  // }),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
