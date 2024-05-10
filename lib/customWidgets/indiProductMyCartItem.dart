import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../const.dart';
import '../controllers/products_controller.dart';

class ProductItem extends StatefulWidget {
  final int index;

  ProductItem({Key? key, required this.index}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int _quantity = 0;
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    final product = productsController.savedProducts[widget.index];

    return Card(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              productsController.savedProducts.removeAt(widget.index);
            },
          ),
          CachedNetworkImage(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            imageUrl: product.images[0],
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
                      product.title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                  ),
                  Text("Rs. ${product.price}"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        color: baseColor,
                        icon: const Icon(Icons.remove, size: 12),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 0) _quantity--;
                          });
                        },
                      ),
                      Text('$_quantity',
                          style: const TextStyle(fontSize: 20)),
                      IconButton(
                        color: baseColor,
                        icon: const Icon(Icons.add, size: 12),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}