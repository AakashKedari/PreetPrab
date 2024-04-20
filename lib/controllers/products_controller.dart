import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class ProductsController extends GetxController{
  var allShopProductDetails = Rx<ShopProductsDetails?>(null);

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

  }
}