import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:preetprab/screens/indiProductInfo.dart';

class FirstTab extends StatelessWidget {
  FirstTab({super.key});

  ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    log("ProductsTab Rebuild");

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.token_outlined,
              color: Colors.blue,
            ),
            Text('PreetPrab'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_rounded),
            onSelected: (value) {
              value == 'Price ASC'
                  ? productsController.sortProductsByPriceAsc()
                  : productsController.sortProductsByPriceDesc();
            },
            itemBuilder: (BuildContext context) {
              return {'Price ASC', 'Price DESC'}.map((String choice) {
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
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              children: [

                Obx(() {
                  if (productsController.allShopProductDetails.value == null && productsController.dscProducts.isEmpty && productsController.ascProducts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<Product>? fetchedProduct = productsController
                        .allShopProductDetails.value!.products;
                    return Column(
                      children: [
                        if(productsController.filterName.value != '')
                          Chip(label: Text(productsController.filterName.value),onDeleted: (){
                            productsController.ascProducts.clear();
                            productsController.dscProducts.clear();
                            productsController.filterName.value = '';
                          },),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.5),
                            itemCount: fetchedProduct?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductInfo(
                                              product: productsController
                                                  .filterName.value ==
                                                  'Price ASC'
                                                  ? productsController
                                                  .ascProducts[index]
                                                  : productsController
                                                  .filterName.value ==
                                                  'Price DSC'
                                                  ? productsController
                                                  .dscProducts[index]
                                                  : fetchedProduct?[index])));
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
                                                      .filterName.value ==
                                                      'Price ASC'
                                                      ? productsController
                                                      .ascProducts[index].images![0]
                                                      : productsController
                                                      .filterName
                                                      .value ==
                                                      'Price DSC'
                                                      ? productsController
                                                      .dscProducts[index]
                                                      .images![0]
                                                      : fetchedProduct![index].images!.isNotEmpty ?
                                                    fetchedProduct[index].images![0] : 'https://preetprab.com/wp-content/uploads/2024/04/IMG-20240401-WA0107.jpg'
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        productsController.filterName.value == 'Price ASC' ? productsController.ascProducts[index].title! :
                                        productsController.filterName.value == 'Price DSC' ? productsController.dscProducts[index].title! :
                                            fetchedProduct![index].title!
                                        // productsController.filterName.value ==
                                        //     'Price ASC'
                                        //     ? productsController
                                        //     .ascProducts[index].title
                                        //     : productsController.filterName.value ==
                                        //     'Price DSC'
                                        //     ? productsController
                                        //     .dscProducts[index].title
                                        //     : fetchedProduct[index].title,
                                        ,style:
                                        Theme.of(context).textTheme.labelLarge,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    Text(
                                      "Rs. ${productsController.filterName.value == 'Price ASC' ? productsController.ascProducts[index]!.price : productsController.filterName.value == 'Price DSC' ? productsController.dscProducts[index]!.price : fetchedProduct![index].price}",
                                      style: Theme.of(context).textTheme.labelMedium,
                                      overflow: TextOverflow.fade,
                                    )
                                  ],
                                ),
                              );
                            })

                      ],
                    );
                  }
                })
                // GridView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2,
                //             crossAxisSpacing: 10,
                //             mainAxisSpacing: 10,
                //             childAspectRatio: 0.5),
                //     itemCount: allProducts!.products.length,
                //     itemBuilder: (context, index) {
                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (_) => ProductInfo(
                //                       product: filterName == 'Price ASC'
                //                           ? ascProducts[index]
                //                           : filterName == 'Price DSC'
                //                               ? dscProducts[index]
                //                               : allProducts!
                //                                   .products[index])));
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             ClipRRect(
                //               borderRadius: const BorderRadius.all(
                //                   Radius.circular(20)),
                //               child: Stack(
                //                 children: [
                //                   const Positioned.fill(
                //                     child: Align(
                //                       alignment: Alignment.center,
                //                       child:
                //                           CircularProgressIndicator(), // Add CircularProgressIndicator here
                //                     ),
                //                   ),
                //                   Container(
                //                     height: MediaQuery.of(context)
                //                             .size
                //                             .height *
                //                         0.3,
                //                     decoration: BoxDecoration(
                //                       borderRadius:
                //                           const BorderRadius.all(
                //                               Radius.circular(20)),
                //                       image: DecorationImage(
                //                         image: CachedNetworkImageProvider(
                //                           filterName == 'Price ASC'
                //                               ? ascProducts[index].image
                //                               : filterName == 'Price DSC'
                //                                   ? dscProducts[index]
                //                                       .image
                //                                   : allProducts!
                //                                       .products[index]
                //                                       .image,
                //                         ),
                //                         fit: BoxFit.cover,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Flexible(
                //               child: Text(
                //                 filterName == 'Price ASC'
                //                     ? ascProducts[index].title
                //                     : filterName == 'Price DSC'
                //                         ? dscProducts[index].title
                //                         : allProducts!
                //                             .products[index].title,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .labelLarge,
                //                 overflow: TextOverflow.fade,
                //               ),
                //             ),
                //             Text(
                //               "Rs. ${filterName == 'Price ASC' ? ascProducts[index].price : filterName == 'Price DSC' ? dscProducts[index].price : allProducts!.products[index].price}",
                //               style:
                //                   Theme.of(context).textTheme.labelSmall,
                //               overflow: TextOverflow.fade,
                //             )
                //           ],
                //         ),
                //       );
                //     }),
              ],
            )),
      ),
    );
  }
}
