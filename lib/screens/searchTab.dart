import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/screens/indiProductInfo.dart';
import '../models/shopProductsDetails.dart';

class SearchCategory extends StatefulWidget {
  @override
  _SearchCategoryState createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory>
    with AutomaticKeepAliveClientMixin<SearchCategory> {

  ScrollController scrollController = ScrollController();

  ProductsController productsController = Get.find<ProductsController>();

  Widget products = ListView(
    physics: const NeverScrollableScrollPhysics(),
    children: const [
      ListTile(
        leading: Text('Bags'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
      ListTile(
        leading: Text('Jeans'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
      ListTile(
        leading: Text('Shirts'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
      ListTile(
        leading: Text('Shoes'),
        trailing: Icon(Icons.arrow_forward_ios),
      )
    ],
  );

  List<Product> filteredList = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    log('Search Catgory Tab Built');
    return SafeArea(
      child: (filteredList.isEmpty && _textEditingController.text.isNotEmpty)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          searchFormField(),
          const Text('No Products found')
        ],
      ) : filteredList.isEmpty
          ? Center(
              child: searchFormField(),
            )
              : SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        searchFormField(),
                        filteredList.isNotEmpty
                            ? Column(
                                children: [
                                  Text(
                                      'We found ${filteredList.length} products'),
                                  const Gap(10),
                                  GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 0.5),
                                      itemCount: filteredList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => ProductInfo(
                                                        product: filteredList[
                                                            index])));
                                          },
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            filteredList[index]
                                                                .image,
                                                        progressIndicatorBuilder:
                                                            (context, string,
                                                                downloadProgress) {
                                                          return const SizedBox(
                                                              height: 200,
                                                              width: 200,
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator()));
                                                        },
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        filteredList
                                                            [index]
                                                            .title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Rs. ${filteredList![index].price}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: IconButton(
                                                    icon: Icon(productsController.savedProducts
                                                            .contains(
                                                                filteredList[
                                                                    index])
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_outline_sharp),
                                                    onPressed: () {
                                                      productsController.savedProducts.contains(
                                                              filteredList[
                                                                  index])
                                                          ? productsController.savedProducts
                                                              .remove(
                                                                  filteredList[
                                                                      index])
                                                          : productsController.savedProducts.add(
                                                              filteredList[
                                                                  index]);
                                                      setState(() {});
                                                    },
                                                    color:
                                                        productsController.savedProducts.contains(
                                                                filteredList[
                                                                    index])
                                                            ? Colors.red
                                                            : Colors.black,
                                                  ))
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              )
                            : const SizedBox()

                        // ListView.builder(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: imagePath.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Column(
                        //       children: <Widget>[
                        //         GestureDetector(
                        //           onTap: () {
                        //             setState(() {
                        //               _isExpanded[index] = !_isExpanded[index];
                        //             });
                        //             Future.delayed(Duration(milliseconds: 200)).then((value) {
                        //               if (index == 3) {
                        //                 print(scrollController.offset);
                        //                 scrollController.animateTo(
                        //                   scrollController.position.maxScrollExtent,
                        //                   duration: const Duration(milliseconds: 200), // Adjust duration as needed
                        //                   curve: Curves.easeInOut,
                        //                 );
                        //               }
                        //             });
                        //           },
                        //           child: Image.asset(imagePath[
                        //               index]), // Replace with your asset image paths
                        //         ),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         AnimatedContainer(
                        //           duration: const Duration(milliseconds: 200),
                        //           curve: Curves.easeInOut,
                        //           height: _isExpanded[index] ? 250 : 0.0,
                        //           child: _isExpanded[index] ? products : null,
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // )
                      ]),
                ),
    );
  }

  TextFormField searchFormField() {
    return TextFormField(
      controller: _textEditingController,
      onFieldSubmitted: (value) {
        if (value.isEmpty) {
          filteredList = [];
          setState(() {});
        } else {
          filteredList = productsController.allShopProductDetails.value!.products
              .where((element) => element.title
                  .toLowerCase()
                  .contains(value.toString().toLowerCase()))
              .toList();
          setState(() {});
        }
      },
      decoration: InputDecoration(
          suffixIcon: _textEditingController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      _textEditingController.clear();
                      filteredList.clear();
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          hintText: 'Search for Kurtis,Lehengas,...'),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
