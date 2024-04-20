import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class ProductsController extends GetxController {
  var allShopProductDetails = Rx<ShopProductsDetails?>(null);
  var ascProducts = RxList<Product>();
  var dscProducts = RxList<Product>();
  var filterName = ''.obs;

  // Function to sort products by price in ascending order
  void sortProductsByPriceAsc() {
    List<Product> temp = List.from(allProducts!.products);
    allProducts!.products
        .sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));

    ascProducts.value = allProducts!.products;
    allProducts!.products = temp;

    filterName.value = 'Price ASC';
  }

// Function to sort products by price in descending order
  void sortProductsByPriceDesc() {

    List<Product> temp = List.from(allShopProductDetails.value!.products);
    allShopProductDetails.value!.products
        .sort((a, b) => double.parse(b.price).compareTo(double.parse(a.price)));
    dscProducts.value = allShopProductDetails.value!.products;
    allShopProductDetails.value!.products = temp;
    filterName.value = 'Price DSC';
    update();
  }

  Future _productAPICall() async {
    log('APIMethod');
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> decoded = jsonDecode(response.body);
    ShopProductsDetails temp = ShopProductsDetails.fromJson(decoded);
    allShopProductDetails.value = temp;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _productAPICall();
  }
}
