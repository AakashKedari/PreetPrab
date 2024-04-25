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
                            onTap: (index){
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    body: GestureDetector(
                                      onTap: () {
                                        /// Exit full screen when tapped
                                        Get.back();
                                      },
                                      child: InteractiveViewer(
                                        boundaryMargin: const EdgeInsets.all(20.0),
                                        minScale: 0.1,
                                        maxScale: 3.0,
                                        child: Center(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                            product!.images![index],
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
                            itemCount: product!.images!.length,
                            itemBuilder: (context, currentSlidedIndex) {
                              return Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                      imageUrl: product!.images![currentSlidedIndex],
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
                                      child:   Icon(
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
                      elevation: 5,
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
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 1.0, // This is the thickness of the underline.
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.only(bottom: 5.0), // This is the gap you want.
                                    child: Text(
                                      product!.title!,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: (){}, icon: const  Icon(Icons.share_rounded))
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
                      surfaceTintColor: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Gap(5),
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
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Gap(5),
                            Center(child: Text('Reviews : ',style: TextStyle(fontWeight: FontWeight.bold),),),
                            const Divider(
                              thickness: 1.0,
                              color: Colors.black54,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: product?.reviews.length,
                                itemBuilder: (context,index){
                              String formattedDate = DateFormat('dd/MM/yyyy').format(product!.reviews[index].date);
                              return Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      child: Text(product!.reviews[index].author[0].toUpperCase()),
                                    ),
                                    title:Text(product!.reviews[index].author) ,
                                    trailing: Text(formattedDate),

                                  ),
                                  Gap(10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text("\"${product!.reviews[index].content}\""),
                                  ),
                                  Gap(10),
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
