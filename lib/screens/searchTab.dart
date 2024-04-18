// import 'package:ecommerce//models/shopProductsDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:preetprab/const.dart';

import '../models/shopProductsDetails.dart';

class SearchCategory extends StatefulWidget {
  @override
  _SearchCategoryState createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  List<bool> _isExpanded = List.generate(4, (index) => false);
  ScrollController scrollController = ScrollController();
  List<String> imagePath = [
    'assets/images/clothing.png',
    'assets/images/men.png',
    'assets/images/women.png',
    'assets/images/music.png',
  ];

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
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _textEditingController,
              onFieldSubmitted: (value) {
                if (value.isEmpty) {
                  filteredList = [];
                  setState(() {});
                } else {
                  filteredList = allProducts!.products
                      .where((element) => element.title
                          .toLowerCase()
                          .contains(value.toString().toLowerCase()))
                      .toList();
                  setState(() {});
                }
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search for Kurtis,Lehengas,...'),
            ),
            filteredList.isNotEmpty
                ? GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.5),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: filteredList[index].image,
                                progressIndicatorBuilder:
                                    (context, string, downloadProgress) {
                                  return const SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                },
                              ),
                              Text(
                                allProducts!.products[index].title,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                "Rs. ${allProducts!.products[index].price}",
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(
                                    savedProducts.contains(filteredList[index])
                                        ? Icons.favorite
                                        : Icons.favorite_outline_sharp),
                                onPressed: () {
                                  savedProducts.contains(filteredList[index])
                                      ? savedProducts
                                          .remove(filteredList[index])
                                      : savedProducts.add(filteredList[index]);
                                  setState(() {});
                                },
                                color: savedProducts.contains(filteredList[index]) ? Colors.red : Colors.black,
                              ))
                        ],
                      );
                    })
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
    );
  }
}
