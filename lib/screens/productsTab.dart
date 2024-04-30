import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/homescreen_controller.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:preetprab/screens/categoryTab.dart';
import 'package:preetprab/screens/indiProductInfo.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab>
    with AutomaticKeepAliveClientMixin {
  final ProductsController productsController = Get.find<ProductsController>();

  final ScrollController _scrollController = ScrollController();

  TextEditingController searchTextEditingController = TextEditingController();

  final HomeScreenController homeScreenController2 =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    log("ProductsTab Rebuild");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        elevation: 8,
        centerTitle: false,
        title: Image.asset(
          'assets/images/transparent.png',
          width: 120,
        ),
        actions: [
          const Icon(
            Icons.favorite_outline_sharp,
            color: baseColor,
          ),
          const Gap(15),
          const Icon(
            Icons.notifications,
            color: baseColor,
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: baseColor,
            ),
            onSelected: (value) {
              value == 'Low to High'
                  ? productsController.sortProductsByPriceAsc()
                  : productsController.sortProductsByPriceDesc();
              _scrollController.animateTo(0.0,
                  duration: const Duration(seconds: 1), curve: Curves.easeOut);
            },
            itemBuilder: (BuildContext context) {
              return {'High to Low', 'Low to High'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(choice == "Low to High"
                          ? Icons.moving_outlined
                          : Icons.trending_down),
                      const Gap(5),
                      Text(choice),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: searchField(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: baseColor,
                        )));
                  } else if (productsController
                      .allShopProductDetails.value!.users.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Text('Check Connectivity & try again')),
                        MaterialButton(
                          color: baseColor,
                          onPressed: () {
                            productsController.allShopProductDetails.value =
                                null;
                            log(productsController.ascProducts.length
                                .toString());
                            log(productsController.dscProducts.length
                                .toString());
                            productsController.productAPICall();
                          },
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    );
                  } else {
                    List<Product>? fetchedProduct =
                        productsController.filteredList.isEmpty
                            ? productsController
                                .allShopProductDetails.value!.products
                            : productsController.filteredList;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () => Get.to(() => CategoryTab(
                                              bannerProductName: index == 0
                                                  ? 'Kurtis'
                                                  : index == 1
                                                      ? 'Gowns'
                                                      : index == 2
                                                          ? 'Short Dress'
                                                          : 'Long Dress',
                                            )),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.purple.shade50,
                                          foregroundImage: AssetImage(
                                              'assets/images/banner_${index + 1}.png'),
                                        ),
                                      ),
                                      const Gap(5),
                                      Flexible(
                                          child: Text(
                                        index == 0
                                            ? 'Kurtis'
                                            : index == 1
                                                ? 'Gowns'
                                                : index == 2
                                                    ? 'Short Dress'
                                                    : 'Long Dress',
                                        maxLines: 2,
                                        style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                      ))
                                    ],
                                  );
                                }),
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Swiper(
                            physics: const NeverScrollableScrollPhysics(),
                            autoplay: true,
                            loop: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: Image.asset(
                                      'assets/images/${index + 1}.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Positioned(
                                      left: 20,
                                      top: 50,
                                      child: Column(
                                        children: [
                                          Text("NEW FASHION"),
                                          Gap(10),
                                          Material(
                                            shape: RoundedRectangleBorder(),
                                            type: MaterialType.button,
                                            color: Colors.pink,
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                'SHOP NOW',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              );
                            },
                          ),
                        ),
                        const Gap(10),
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
                            itemCount: fetchedProduct.length,
                            itemBuilder: (context, index) {
                              final List<Product> gridProducts =
                                  productsController.filterName.value ==
                                          'Low to High'
                                      ? productsController.ascProducts
                                      : productsController.filterName.value ==
                                              'High to Low'
                                          ? productsController.dscProducts
                                          : fetchedProduct;

                              /// Here the fetchedProduct will be the list of
                              /// Original API fetched Products or Filtered
                              /// Products that we search for

                              return Card(
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                shadowColor: Colors.white,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProductInfo(
                                        product: gridProducts[index]));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Stack(
                                          children: [
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
                                                      gridProducts[index]
                                                              .images
                                                              .isNotEmpty
                                                          ? gridProducts[index]
                                                              .images[0]
                                                          : 'https://preetprab.com/wp-content/uploads/2024/04/IMG-20240401-WA0107.jpg'),

                                                  /// Incase the images array from API is empty
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 2, 0),
                                          child: Text(
                                            gridProducts[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 2, 0),
                                        child: Text(
                                          "\u20B9 ${productsController.filterName.value == 'Low to High' ? productsController.ascProducts[index].price : productsController.filterName.value == 'High to Low' ? productsController.dscProducts[index].price : fetchedProduct[index].price}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => IconButton(
                                                  onPressed: () {
                                                    productsController
                                                            .wishlistProducts
                                                            .contains(
                                                                gridProducts[
                                                                    index])
                                                        ? productsController
                                                            .wishlistProducts
                                                            .remove(
                                                                gridProducts[
                                                                    index])
                                                        : productsController
                                                            .wishlistProducts
                                                            .add(gridProducts[
                                                                index]);
                                                  },
                                                  icon: Icon(
                                                    productsController
                                                            .wishlistProducts
                                                            .contains(
                                                                gridProducts[
                                                                    index])
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_outline_sharp,
                                                    color: baseColor,
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                !productsController
                                                        .savedProducts
                                                        .contains(
                                                            gridProducts[index])
                                                    ? productsController
                                                        .savedProducts
                                                        .add(
                                                            gridProducts[index])
                                                    : null;
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: baseColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 25,
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    productsController
                                                            .savedProducts
                                                            .contains(
                                                                gridProducts[
                                                                    index])
                                                        ? 'In Bag'
                                                        : 'ADD TO BAG',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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

  TextFormField searchField(BuildContext context) {
    return TextFormField(
        controller: searchTextEditingController,
        onFieldSubmitted: (value) {
          productsController.filterName.value = '';
          if (value.isEmpty) {
            productsController.filteredList.value = [];
          } else {
            productsController.filteredList.value = productsController
                .allShopProductDetails.value!.products
                .where((element) => element.title
                    .toLowerCase()
                    .contains(value.toString().toLowerCase()))
                .toList();
            if (productsController.filteredList.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Sorry!!! No such Product found')));
            }
          }
          log('TextField Value : ${searchTextEditingController.value.text}');
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
            suffixIcon: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                searchTextEditingController.clear();
                productsController.filteredList.clear();
              },
            ),
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            label: Center(
              child: StreamBuilder<String>(
                stream: homeScreenController2.hintStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: const Offset(0, 0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: Text(
                        snapshot.data!,
                        key: ValueKey<String>(snapshot.data!),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return Container(); // Placeholder widget
                  }
                },
              ),
            )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
