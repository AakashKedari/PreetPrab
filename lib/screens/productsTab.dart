import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../const.dart';
import '../models/shopProductsDetails.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {



  Future _productAPICall() async{
    http.Response response = await  http.get(Uri.parse(apiUrl));
    Map<String,dynamic> decoded = jsonDecode(response.body);
    ShopProductsDetails temp = ShopProductsDetails.fromJson(decoded);
    log(temp.products.toString());

    setState(() {
      allProducts = temp;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    _productAPICall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allProducts == null ? const Center(child: CircularProgressIndicator() ):  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.5
      ),
          itemCount: allProducts!.products.length,
          itemBuilder: (context,index){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: allProducts!.products[index].image,
            progressIndicatorBuilder: (context,string,downloadProgress){
              return SizedBox(
                height: 200,
                  width: 200,
                  child: Center(child: CircularProgressIndicator()));
            },
            ),
            Text(allProducts!.products[index].title,style: Theme.of(context).textTheme.labelLarge,overflow: TextOverflow.fade,),
            Text("Rs. ${allProducts!.products[index].price}",style: Theme.of(context).textTheme.labelSmall,overflow: TextOverflow.fade,)
          ],
        );
            // Image.network(shopProductsDetails!.products[index].image,
            // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            //   if (loadingProgress == null) return child;
            //   return Center(
            //     child: CircularProgressIndicator(
            //       value: loadingProgress.expectedTotalBytes != null
            //           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            //           : null,
            //     ),
            //   );
            // },
            // );

      }),
    );
  }
}
