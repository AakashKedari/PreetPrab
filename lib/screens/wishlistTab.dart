import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../const.dart';
import '../controllers/products_controller.dart';
import 'indiProductInfo.dart';

class WishListTab extends StatefulWidget {
  const WishListTab({super.key});

  @override
  State<WishListTab> createState() => _WishListTabState();
}

class _WishListTabState extends State<WishListTab> with AutomaticKeepAliveClientMixin{
  final ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Obx(
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
                      'WishList',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    trailing: MaterialButton(
                      color: Colors.black,
                      /// Here, on press, we add all the wishlist Items to My Cart
                      onPressed: (){
                        for(int i=0;i<productsController.wishlistProducts.length;i++){
                          productsController.savedProducts.add(productsController.wishlistProducts[i]);
                        }
                        productsController.wishlistProducts.clear();
                      },
                      child: const Text('ADD TO BAG',style: TextStyle(color: Colors.white),),
                    )),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productsController.wishlistProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductInfo(
                              product: productsController
                                  .wishlistProducts[index]));
                        },
                        child: Card(
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  productsController.wishlistProducts
                                      .removeAt(index);
                                },
                              ),
                              CachedNetworkImage(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                                imageUrl: productsController
                                    .wishlistProducts[index].images[0],
                                filterQuality: FilterQuality.high,
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
                                              .wishlistProducts[index].title,
                                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                          maxLines: 3,
                                        ),
                                      ),
                                      Text(
                                          "Rs. ${productsController.wishlistProducts[index].price}"),
                                   ElevatedButton(
                                       style: ElevatedButton.styleFrom(
                                         backgroundColor: baseColor
                                       ),
                                       onPressed: (){
                                         productsController.savedProducts.add(productsController.wishlistProducts[index]);
                                         productsController.wishlistProducts.remove(productsController.wishlistProducts[index]);

                                       }, child: Text('Add to Bag',style: TextStyle(color: Colors.white),))
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
                            productsController.wishlistProducts.length.toString(),
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
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          productsController.wishlistProducts.clear();
                        },
                        child: Container(
                          height: 40,
                          color: baseColor,
                          child: const Center(
                              child: Text(
                                'CLEAR WISHLIST',
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
