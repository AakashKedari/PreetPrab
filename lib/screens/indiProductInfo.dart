import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/productInfoController.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';

class ProductInfo extends StatelessWidget {
  final Product? product;
  ProductInfo({super.key, required this.product});

  final ProductsController productsController = Get.find<ProductsController>();
  int currentSlidedIndex = 0;
  final ProductInfoController _productInfoController =
      Get.put(ProductInfoController());

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final List<String?>? uniqueColors = product?.variations
        .map((variation) => variation.attributes.attributeColor)
        .toSet()
        .toList();
    for (int i = 0; i < uniqueColors!.length; i++) {
      log('$i th color is : ${uniqueColors[i]}');
      log('The length of color is ${uniqueColors.length}');
    }
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 25,
        title: Image.asset(
          'assets/images/transparent.png',
          width: 120,
        ),
        actions: const [Icon(CupertinoIcons.cart), Gap(10)],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 12 / 16,
                          child: Swiper(
                            allowImplicitScrolling: true,

                            ///Setting it to true ensures that the images are preloaded
                            onTap: (index) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    body: GestureDetector(
                                      onTap: () {
                                        /// Exit full screen when tapped
                                        Get.back();
                                      },
                                      child: InteractiveViewer(
                                        boundaryMargin:
                                            const EdgeInsets.all(20.0),
                                        minScale: 0.1,
                                        maxScale: 3.0,
                                        child: Center(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product!.images[index],
                                            progressIndicatorBuilder: (context,
                                                string, downloadProgress) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                fullscreenDialog: true,
                              ));
                            },
                            autoplayDelay: 4000,
                            pagination: const SwiperPagination(),
                            autoplay: true,
                            loop: true,
                            itemCount: product!.images.length,
                            itemBuilder: (context, currentSlidedIndex) {
                              return Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          product!.images[currentSlidedIndex],
                                      progressIndicatorBuilder:
                                          (context, string, downloadProgress) {
                                        return const SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      },
                                    ),
                                  ),
                                  const Positioned(
                                    top: 10,
                                    right: 20,
                                    child: Icon(
                                      Icons.fullscreen,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Obx(
                                    () => Text(
                                      "${product!.title} ${productsController.selectedSizeIndex.value > -1 ? "(${product?.variations[productsController.selectedSizeIndex.value].attributes.attributeSize.name}) ${_productInfoController.selectedColorIndex.value != -1 ? '(${uniqueColors[_productInfoController.selectedColorIndex.value]})' : ''}" : ''}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.share_rounded))
                              ],
                            ),
                            const Gap(10),
                            Text(
                              "\u20B9 ${product!.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                            const Gap(5),
                            const Text(
                              'Inclusive of All Taxes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100, fontSize: 12),
                            ),
                            const Gap(5)
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),
                    Card(
                      elevation: 2,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (uniqueColors[0] != null) const Gap(10),
                            if (uniqueColors[0] != null)
                              const Text(
                                'Select Colour',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            if (uniqueColors[0] != null) const Gap(10),
                            if (uniqueColors[0] != null)
                              SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  itemCount: uniqueColors.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Obx(() => GestureDetector(
                                          onTap: () {
                                            _productInfoController
                                                .selectedColorIndex
                                                .value = index;
                                          },
                                          child: Chip(
                                            backgroundColor:
                                                _productInfoController
                                                            .selectedColorIndex
                                                            .value ==
                                                        index
                                                    ? predefinedColors[
                                                        uniqueColors[index]]
                                                    : Colors.white,
                                            shape: const StadiumBorder(),
                                            label:
                                                Text(uniqueColors[index] ?? ''),
                                          ),
                                        ));
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                ),
                              ),
                            const Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Select Size',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Size Chart',
                                      style: TextStyle(color: baseColor),
                                    ))
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              height: 40.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => GestureDetector(
                                        onTap: () {
                                          productsController
                                              .selectedSizeIndex.value = index;
                                        },
                                        child: Chip(
                                          shape: const StadiumBorder(),
                                          backgroundColor: productsController
                                                      .selectedSizeIndex
                                                      .value ==
                                                  index
                                              ? baseColor
                                              : Colors.white,
                                          label: Text(product!.variations[index]
                                              .attributes.attributeSize.name),
                                        )),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),

                    /// Description Card
                    DescriptionCard(),
                    const Gap(15),

                    /// Reviews Card
                    ReviewCard(),
                    const Gap(15),
                    DeliveryCard(context),
                    const Gap(50)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Material(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            productsController.wishlistProducts.add(product!);
                          },
                          icon: Icon(
                            MdiIcons.heartPlus,
                            size: 30,
                            color: baseColor,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width - 100,
                      height: 40,
                      child: MaterialButton(
                        elevation: 10,
                        color: Colors.black,
                        onPressed: () {
                          productsController.savedProducts.contains(product)
                              ? null
                              : productsController.savedProducts.add(product!);
                        },
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              const Gap(5),
                              Text(
                                productsController.savedProducts
                                        .contains(product)
                                    ? 'In Bag'
                                    : 'ADD TO BAG',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card DescriptionCard() {
    return Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Gap(5),
                          const Text(
                            'Description : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 1.0,
                            color: Colors.black54,
                          ),
                          Text(product!.shortDescription),
                          const Gap(5)
                        ],
                      ),
                    ),
                  );
  }

  Card DeliveryCard(BuildContext context) {
    return Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(5),
                          const Center(
                            child: Text(
                              'Check Delivery ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Enter pincode to know exact delivery status',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Gap(5),
                          TextField(
                            onTap: () {
                              Future.delayed(Duration(milliseconds: 600), () {
                                _scrollController.animateTo(
                                    _scrollController
                                        .position.maxScrollExtent,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeOut);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        8.0), // Adjust the padding as needed
                                child: Chip(
                                  label: Text('Check'),
                                ),
                              ),
// suffixStyle: TextStyle(color: Colors.black),
                              hintText: 'PinCode',
                              contentPadding:
                                  const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                            ),
                          ),
                          Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.delivery_dining_rounded,
                                    size: 40,
                                    color: Colors.pink.shade100,
                                  ),
                                  Text(
                                    'Free Delivery',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.compare_arrows,
                                    size: 40,
                                    color: Colors.pink.shade100,
                                  ),
                                  Text(
                                    '7-Day Exchange',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    MdiIcons.cashPlus,
                                    size: 40,
                                    color: Colors.pink.shade100,
                                  ),
                                  Text(
                                    'COD',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                    maxLines: 2,
                                  )
                                ],
                              )
                            ],
                          ),
                          Gap(5)
                        ],
                      ),
                    ),
                  );
  }

  Card ReviewCard() {
    return Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Gap(5),
                          const Center(
                            child: Text(
                              'Reviews : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            thickness: 1.0,
                            color: Colors.black54,
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: product?.reviews.length,
                              itemBuilder: (context, index) {
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy')
                                        .format(product!.reviews[index].date);
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Text(product!
                                            .reviews[index].author[0]
                                            .toUpperCase()),
                                      ),
                                      title: Text(
                                          product!.reviews[index].author),
                                      trailing: Text(formattedDate),
                                    ),
                                    const Gap(10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                          "\"${product!.reviews[index].content}\""),
                                    ),
                                    const Gap(10),
                                  ],
                                );
                              }),
                          const Gap(5)
                        ],
                      ),
                    ),
                  );
  }
}
