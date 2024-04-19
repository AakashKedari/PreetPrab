import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:preetprab/screens/indiProductInfo.dart';
import '../const.dart';
import '../models/shopProductsDetails.dart';

class FirstTab extends StatefulWidget{


  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab>  with AutomaticKeepAliveClientMixin<FirstTab>  {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
  Future _productAPICall() async {
    log('APIMethod');
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> decoded = jsonDecode(response.body);
    ShopProductsDetails temp = ShopProductsDetails.fromJson(decoded);
    log(temp.products.toString());

    setState(() {
      allProducts = temp;
    });
  }

  // Function to sort products by price in ascending order
  void sortProductsByPriceAsc() {
    allProducts!.products.sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    setState(() {
      for(int i=0;i<allProducts!.products.length;i++){
        log(allProducts!.products[i].price);
      }
    });
  }

// Function to sort products by price in descending order
  void sortProductsByPriceDesc() {
    allProducts!.products.sort((a, b) => double.parse(b.price).compareTo(double.parse(a.price)));

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if(allProducts == null)   WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _productAPICall());
    log('INIT Method called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("BuillllllldDdd");
    super.build(context);
    return Scaffold(

      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.token_outlined,
              color: Colors.blue,
            ),
            Text('PreetPrab'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_rounded),
            onSelected: (value){
              value == 'Price ASC' ? sortProductsByPriceAsc() : sortProductsByPriceDesc();
            },
            itemBuilder: (BuildContext context) {
              return {'Price ASC', 'Price DESC'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: allProducts == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.5),
                  itemCount: allProducts!.products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (_) => ProductInfo(product: allProducts!.products[index])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: Stack(
                              children: [
                                const Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(), // Add CircularProgressIndicator here
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        allProducts!.products[index].image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          // ClipRRect(
                          //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                          //   child:
                          //   Container(
                          //     height: 250,
                          //     decoration: BoxDecoration(
                          //         borderRadius: const BorderRadius.all(Radius.circular(20)),
                          //         image: DecorationImage(
                          //         image: CachedNetworkImageProvider(
                          //           allProducts!.products[index].image,
                          //
                          //         )
                          //       )
                          //     ),
                          //
                          //   )
                          //
                          // ),
                          Flexible(
                            child: Text(
                              allProducts!.products[index].title,
                              style: Theme.of(context).textTheme.labelLarge,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Text(
                            "Rs. ${allProducts!.products[index].price}",
                            style: Theme.of(context).textTheme.labelSmall,
                            overflow: TextOverflow.fade,
                          )
                        ],
                      ),
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
            ),
          ),
    );
  }


}
