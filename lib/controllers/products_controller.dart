import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:http/http.dart' as http;
import '../const.dart';
import '../main.dart';

class ProductsController extends GetxController {
  var allShopProductDetails = Rx<ShopProductsDetails?>(null);
  var ascProducts = <Product>[].obs;
  var dscProducts = <Product>[].obs;
  var filterName = ''.obs;
  var savedProducts = <Product>[].obs;
  var filteredList = <Product>[].obs;
  var categorisedList = <Product>[].obs;

  // Function to sort products by price in ascending order
  void sortProductsByPriceAsc() {
    List<Product> temp = List.from(allShopProductDetails.value!.products!);
    allShopProductDetails.value!.products
        ?.sort((a, b) => double.parse(a.price!).compareTo(double.parse(b.price!)));

    ascProducts.value = allShopProductDetails.value!.products!;
    allShopProductDetails.value!.products = temp;

    filterName.value = 'Low to High';
  }
// Function to sort products by price in descending order
  void sortProductsByPriceDesc() {

    List<Product> temp = List.from(allShopProductDetails.value!.products!);
    allShopProductDetails.value!.products
        ?.sort((a, b) => double.parse(b.price!).compareTo(double.parse(a.price!)));
    dscProducts.value = allShopProductDetails.value!.products!;
    allShopProductDetails.value!.products = temp;
    filterName.value = 'High to Low';
    update();
  }

  Future _productAPICall() async {
    log('APIMethod');
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> decoded = jsonDecode(response.body);
    ShopProductsDetails temp = ShopProductsDetails.fromJson(decoded);
    allShopProductDetails.value = temp;
  }

  void fetchCategoryWiseProducts(CategoryEnum categoryEnum) {
   categorisedList.value =
        allShopProductDetails.value!.products!
        .where((product) {
      log(product.categories.toString());
      return product.categories!.contains(categoryEnum);
    }).toList();

  }

  @override
  void onInit() {
    super.onInit();
    _productAPICall();
  }
}
