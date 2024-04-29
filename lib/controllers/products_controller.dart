import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:preetprab/models/shopProductsDetails.dart';
import 'package:http/http.dart' as http;


class ProductsController extends GetxController {
  var allShopProductDetails = Rx<ShopProductsDetails?>(null);
  var ascProducts = <Product>[].obs;
  var dscProducts = <Product>[].obs;
  var filterName = ''.obs;
  var savedProducts = <Product>[].obs;
  var filteredList = <Product>[].obs;
  var categorisedList = <Product>[].obs;
  var selectedSizeIndex = (-1).obs;
  var wishlistProducts = <Product>[].obs;

  // Function to sort products by price in ascending order
  void sortProductsByPriceAsc() {
    List<Product> temp = List.from(allShopProductDetails.value!.products);
    allShopProductDetails.value!.products
        .sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));

    ascProducts.value = allShopProductDetails.value!.products;
    allShopProductDetails.value!.products = temp;

    filterName.value = 'Low to High';
  }
// Function to sort products by price in descending order
  void sortProductsByPriceDesc() {

    List<Product> temp = List.from(allShopProductDetails.value!.products);
    allShopProductDetails.value!.products
        .sort((a, b) => double.parse(b.price).compareTo(double.parse(a.price)));
    dscProducts.value = allShopProductDetails.value!.products;
    allShopProductDetails.value!.products = temp;
    filterName.value = 'High to Low';
    update();
  }

  Future productAPICall() async {
    final dio = Dio()
      ..options = BaseOptions(
        connectTimeout: const Duration(seconds: 5), // 5 seconds
        receiveTimeout: const Duration(seconds: 5), // 5 seconds
        sendTimeout: const Duration(seconds: 5), // 5 seconds
      );
    log('APIMethod');
    try {
      http.Response response = await http.get(Uri.parse(APIUrls.allProducts));
      // Response response = await dio.get(APIUrls.allProducts);
      log("Response : ${response}");
      Map<String, dynamic> decoded = jsonDecode(response.body);
      ShopProductsDetails temp = ShopProductsDetails.fromJson(decoded);
      allShopProductDetails.value = temp;
    }
    catch(e){
      log('API Call Failed');
      allShopProductDetails.value = ShopProductsDetails(products: [], categories: [], users: []);
    }
  }

  void fetchCategoryWiseProducts(CategoryEnum categoryEnum) {
   categorisedList.value =
        allShopProductDetails.value!.products
        .where((product) {
      log(product.categories.toString());
      return product.categories.contains(categoryEnum);
    }).toList();

  }

  @override
  void onInit() {
    super.onInit();
    productAPICall();
  }
}
