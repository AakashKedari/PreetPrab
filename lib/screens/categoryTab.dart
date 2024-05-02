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

class CategoryTab extends StatefulWidget {
  final String bannerProductName;

  CategoryTab({super.key, this.bannerProductName = ''});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> with AutomaticKeepAliveClientMixin {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.bannerProductName !='') {
      productsController.categorisedList.value = productsController
          .allShopProductDetails.value!.products
          .where((product) {
        return product.categories.contains(bannertoProduct[widget.bannerProductName]);
      }).toList();

      Future.delayed(const Duration(milliseconds: 500),(){
        scrollController.animateTo(MediaQuery.of(context).size.height - kBottomNavigationBarHeight - AppBar().preferredSize.height, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

      });
    }
  }

  Map bannertoProduct = {
    'Kurtis' : CategoryEnum.KURTIS,
    'Gowns' : CategoryEnum.GOWN,
    'Short Dress' : CategoryEnum.SHORT_DRESSES,
    'Long Dress' : CategoryEnum.LONG_DRESSES
  };

  final GlobalKey _imageKey = GlobalKey();

  final ProductsController productsController = Get.find<ProductsController>();

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

    super.build(context);

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
          const Gap(15),
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
                        ),

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
                                          image:  CachedNetworkImageProvider(

                                              productsController
                                                  .categorisedList[index]
                                                  .images.isNotEmpty ? productsController.categorisedList[index].images[0] :
                                              imageErrorHandler),
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
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "Rs. ${productsController.categorisedList[index].price}",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                    overflow: TextOverflow.fade,
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
                                                    productsController.categorisedList[
                                                    index])
                                                    ? productsController
                                                    .wishlistProducts
                                                    .remove(productsController.categorisedList[
                                                index])
                                                    : productsController
                                                    .wishlistProducts
                                                    .add(productsController.categorisedList[
                                                index]);
                                              },
                                              icon: Icon(
                                                productsController.wishlistProducts.contains(productsController.categorisedList[index]) ? Icons.favorite :
                                                Icons.favorite_outline_sharp,
                                                color: baseColor,
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            !productsController
                                                .savedProducts
                                                .contains(
                                                productsController.categorisedList[index])
                                                ? productsController
                                                .savedProducts
                                                .add(
                                                productsController.categorisedList[index])
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
                                                    productsController.categorisedList[
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
                          )
                        : const SizedBox();
                  }))
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
