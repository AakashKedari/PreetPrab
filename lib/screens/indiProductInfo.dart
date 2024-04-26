import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';

class ProductInfo extends StatelessWidget {
  final Product? product;
  ProductInfo({super.key, required this.product});

  final ProductsController productsController = Get.find<ProductsController>();
  int currentSlidedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 25,
        title: Image.asset(
          'assets/images/transparent.png',
          width: 120,
        ),
        actions: const [Icon(Icons.add_shopping_cart_outlined), Gap(10)],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                            allowImplicitScrolling: true, ///Setting it to true ensures that the images are preloaded
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
                                            imageUrl: product!.images![index],
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                      "${product!.title} ${productsController.selectedSizeIndex.value > -1 ? "(${product?.variations[productsController.selectedSizeIndex.value].attributes.attributeSize.name})" : ''}",
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const Gap(5),
                            const Text('Select Size',style: TextStyle(fontWeight: FontWeight.bold),),
                          Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                height: 40.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: product?.variations.length,
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          productsController
                                              .selectedSizeIndex.value = index;
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  product!.variations.length,
                                          decoration: BoxDecoration(
                                            color: productsController
                                                        .selectedSizeIndex
                                                        .value ==
                                                    index
                                                ? Colors.brown
                                                : Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Text(
                                            product!.variations[index].attributes
                                                .attributeSize.name,
                                            style:  TextStyle(
                                              color: productsController
                                                  .selectedSizeIndex
                                                  .value ==
                                                  index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            // SizedBox(
                            //   height: 40,
                            //   width: double.infinity,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     shrinkWrap: false,
                            //       itemCount: product?.variations.length,
                            //       itemBuilder: (context,index){
                            //     return Chip(label: Text(product!.variations[index].attributes.attributeSize.name));
                            //   }),
                            // )
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            Text(product!.shortDescription)
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                })
                          ],
                        ),
                      ),
                    ),
                    const Gap(50)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: MaterialButton(
                  elevation: 10,
                  color: Colors.brown,
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
                        Gap(5),
                        Text(
                          productsController.savedProducts.contains(product)
                              ? 'Already in Cart'
                              : 'ADD TO CART',
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
            ),
          ],
        ),
      ),
    );
  }
}
