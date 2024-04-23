import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:preetprab/screens/indiProductInfo.dart';

enum CategoryEnum {
  CLOTHING,
  DRESSES,
  GOWN,
  KURTIS,
  LONG_DRESSES,
  SHORT_DRESSES,
  WOMAN
}

class FirstTab extends StatelessWidget {
  FirstTab({super.key});

  final ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    log("ProductsTab Rebuild");

    final TextEditingController searchTextEditingController =
        TextEditingController();

    TextFormField searchFormField() {
      return TextFormField(
        controller: searchTextEditingController,
        onFieldSubmitted: (value) {
          if (value.isEmpty) {
            productsController.filteredList.value = [];
          } else {
            productsController.filteredList.value = productsController
                .allShopProductDetails.value!.products!
                .where((element) => element.title!
                    .toLowerCase()
                    .contains(value.toString().toLowerCase()))
                .toList();
            if (productsController.filteredList.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                  content: Text('Sorry!!! No such Product found')));
            }
          }
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.brown, width: 2.0),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.brown, width: 2.0),
              borderRadius: BorderRadius.circular(50),
            ),
            suffixIcon: searchTextEditingController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      searchTextEditingController.clear();
                      productsController.filteredList.clear();
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search for Kurtis,Lehengas...',
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w100,
                )),
      );
    }

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
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (productsController.allShopProductDetails.value == null &&
                      productsController.dscProducts.isEmpty &&
                      productsController.ascProducts.isEmpty) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            kBottomNavigationBarHeight,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else {
                    List<Product>? fetchedProduct =
                        productsController.filteredList.isEmpty
                            ? productsController
                                .allShopProductDetails.value!.products
                            : productsController.filteredList;
                    return Column(
                      children: [
                        Gap(10),
                        searchFormField(),
                        Gap(10),
                        if (productsController.filterName.value != '')
                          Chip(
                            label: Text(productsController.filterName.value),
                            onDeleted: () {
                              productsController.ascProducts.clear();
                              productsController.dscProducts.clear();
                              productsController.filterName.value = '';
                            },
                          ),
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
                              return Card(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ProductInfo(
                                                product: productsController
                                                            .filterName.value ==
                                                        'Low to High'
                                                    ? productsController
                                                        .ascProducts[index]
                                                    : productsController
                                                                .filterName
                                                                .value ==
                                                            'High to Low'
                                                        ? productsController
                                                            .dscProducts[index]
                                                        : fetchedProduct?[
                                                            index])));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                                  .filterName
                                                                  .value ==
                                                              'Low to High'
                                                          ? productsController
                                                              .ascProducts[
                                                                  index]
                                                              .images![0]
                                                          : productsController
                                                                      .filterName
                                                                      .value ==
                                                                  'High to Low'
                                                              ? productsController
                                                                  .dscProducts[
                                                                      index]
                                                                  .images![0]
                                                              : fetchedProduct![
                                                                          index]
                                                                      .images!
                                                                      .isNotEmpty
                                                                  ? fetchedProduct[
                                                                          index]
                                                                      .images![0]
                                                                  : 'https://preetprab.com/wp-content/uploads/2024/04/IMG-20240401-WA0107.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          productsController.filterName.value ==
                                                  'Low to High'
                                              ? productsController
                                                  .ascProducts[index].title!
                                              : productsController
                                                          .filterName.value ==
                                                      'High to Low'
                                                  ? productsController
                                                      .dscProducts[index].title!
                                                  : fetchedProduct![index]
                                                      .title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Text(
                                        "Rs. ${productsController.filterName.value == 'Low to High' ? productsController.ascProducts[index].price : productsController.filterName.value == 'High to Low' ? productsController.dscProducts[index].price : fetchedProduct![index].price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        overflow: TextOverflow.fade,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    );
                  }
                })
              ],
            )),
      ),
    );
  }
}
