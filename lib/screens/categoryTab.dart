import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/main.dart';
import '../models/shopProductsDetails.dart';
import 'indiProductInfo.dart';

class CategoryTab extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final GlobalKey _imageKey = GlobalKey();

  final ProductsController productsController = Get.find<ProductsController>();

  CategoryTab({super.key});

  void fetchCategoryWiseProducts(CategoryEnum categoryEnum) {
    productsController.categorisedList.value = productsController
        .allShopProductDetails.value!.products
        .where((product) {
      return product.categories.contains(categoryEnum);
    }).toList();

    final context = _imageKey.currentContext;

    /// Below code is to automatically scroll to the categorised products
    Future.delayed(const Duration(milliseconds: 300)).then((value) =>
        Scrollable.ensureVisible(context!,
            duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    log('Category Tab Built');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 8,
        centerTitle: false,
        title: Image.asset(
          'assets/images/transparent.png',
          width: 120,
        ),
        actions: [
          const Icon(Icons.favorite_outline_sharp,color: baseColor,),
          Gap(15),
          const Icon(Icons.notifications,color: baseColor,),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_rounded,color: baseColor,),
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
              // const Text(
              //   'Shop',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              // ),
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
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      baseColor,
                                  Colors.brown.shade300,

                                ])),
                            height: 80,
                            child: ListTile(
                              title: Text(
                                CategoryEnum.values[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
              const Gap(10),
              Obx(() => GridView.builder(
                  key: _imageKey,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.5),
                  itemCount: productsController.categorisedList.isNotEmpty
                      ? productsController.categorisedList.length
                      : 0,
                  itemBuilder: (context, index) {
                    return productsController.categorisedList.isNotEmpty
                        ? Card(
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
                                    child: Container(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.3,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(20)),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              productsController
                                                  .categorisedList[index]
                                                  .images[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      productsController
                                          .categorisedList[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
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
                          )
                        : const SizedBox();
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
