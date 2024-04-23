
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';

class ProductInfo extends StatelessWidget {
  final Product? product;
  ProductInfo({super.key, required this.product});

  final ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.add_shopping_cart_outlined),
          Gap(10)
        ],
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
                    // Gap(10),
                    // ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text("back")),
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 12 / 16,
                          child: PageView.builder(
                              pageSnapping: true,
                              itemCount: product!.images!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover,
                                        imageUrl: product!.images![index],
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
                                    Positioned(
                                        top: 10,
                                        right: 20,
                                        child: IconButton(
                                            icon: const Icon(
                                              Icons.fullscreen,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return Scaffold(
                                                    body: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
              
                                                        /// Exit full screen when tapped
                                                      },
                                                      child: Center(
                                                        child: CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          imageUrl:
                                                              product!.images![0],
                                                          progressIndicatorBuilder:
                                                              (context, string,
                                                                  downloadProgress) {
                                                            return const Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          },
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                fullscreenDialog: true,
                                              ));
                                            })),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product!.title!,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                  decorationThickness: 2.0),
                            ),
                            const Gap(10),
                            Text(
                              "Rs. ${product!.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                            const Gap(5),
                            const Text(
                              'Inclusive of All Taxes',
                              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const Text('Description : ',style: TextStyle(fontWeight: FontWeight.bold),),
                            const Divider(),
                            Text(product!.shortDescription!)
                          ],
                        ),
                      ),
                    ),const Gap(50)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: MaterialButton(
                  color: Colors.cyan,
                  onPressed: () {
                    productsController.savedProducts.contains(product)
                        ? null
                        : productsController.savedProducts.add(product!);
                  },
                  child: Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_shopping_cart_outlined),
                        Text(
                          productsController.savedProducts.contains(product)
                              ? 'Already in Cart'
                              : 'ADD TO CART',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.black),
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
