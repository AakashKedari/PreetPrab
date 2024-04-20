import '../models/shopProductsDetails.dart';

List<String> cartItems = ['Elephant Print Cami Dress','Ripped Boyfriend Jeans','Red Check Dress'];

List <int> cartPrices = [30,40,50];

const String apiUrl = 'https://preetprab.com/wp-json/custom/v1/data';

ShopProductsDetails? allProducts;

List<Product> savedProducts = [];

List<Product> ascProducts = [];
List <Product> dscProducts = [];

