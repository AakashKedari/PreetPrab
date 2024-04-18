
import 'package:flutter/material.dart';

import '../const.dart';
import 'checkout.dart';

Widget cart(BuildContext context) {
  int totalCost = savedProducts.fold(0, (sum, item) => sum + int.parse(item.price));
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(height: 15,),
        ListTile(
            leading: const Icon(Icons.arrow_downward_sharp),
            title: const Text('CART  3ITEMS'),
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const CheckOut()));
              },
              child: Material(
                elevation: 5,
                child: Container(
                  height: 40,
                  width: 100,
                  color: Colors.cyan,
                  child: const Center(
                      child: Text(
                    'CHECKOUT',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )),
                ),
              ),
            )),
        ListView.builder(
            shrinkWrap: true,
            itemCount: savedProducts.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 80,
                child: ListTile(
                  trailing: Text("Rs. ${savedProducts[index].price}"),
                  leading: const Icon(Icons.remove_circle_outline),
                  title: Text(savedProducts[index].title),
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
                  const Text(
                    'Products : ',
                    style: TextStyle(
                        fontWeight: FontWeight.w100, color: Colors.grey),
                  ),
                  Text(
                    savedProducts.length.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w100, color: Colors.grey),
                  )
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rs. ${totalCost.toString()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  color: Colors.black,
                  child: const Center(
                      child: Text(
                    'CLEAR CART',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
