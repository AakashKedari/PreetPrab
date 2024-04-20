import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:preetprab/controllers/products_controller.dart';
import 'package:preetprab/models/shopProductsDetails.dart';

class ProductInfo extends StatefulWidget {
  final Product? product;

  const ProductInfo({super.key, required this.product});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  ProductsController productsController = Get.find<ProductsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gap(10),
              // ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text("back")),
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.product!.image,
                    progressIndicatorBuilder:
                        (context, string, downloadProgress) {
                      return const SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(child: CircularProgressIndicator()));
                    },
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                          icon: const Icon(
                            Icons.fullscreen,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Scaffold(
                                  body: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(
                                          context); /// Exit full screen when tapped
                                    },
                                    child: Center(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: widget.product!.image,
                                        progressIndicatorBuilder: (context,
                                            string, downloadProgress) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fullscreenDialog: true,
                            ));
                          })),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              const Gap(10),
              Text(
                widget.product!.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(10),
              Text(
                "Rs. ${widget.product!.price}",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.start,
              ),
              const Gap(10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Colors.cyan,
                      onPressed: () {
                        productsController.savedProducts.contains(widget.product)
                            ? null
                            : productsController.savedProducts.add(widget.product!);
                        setState(() {
                          for(int i=0;i<productsController.savedProducts.value.length;i++){
                            log(productsController.savedProducts[i].title);
                          }
                        });
                      },
                      child: Text(
                        productsController.savedProducts.contains(widget.product)
                            ? 'Already in Cart'
                            : 'ADD TO CART',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Gap(5),
                  DropdownButton(
                    value: 1,
                    items: [1, 2, 3, 4, 5].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        // _selectedValue = newValue!;
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
