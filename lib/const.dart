import 'package:flutter/material.dart';

abstract class APIUrls{
  static String allProducts =  'https://preetprab.com/wp-json/custom/v1/data';

  static String registerUser = 'https://preetprab.com/wp-json/custom/v1/user-registration';

  static String authenticateUser = 'http://preetprab.com/wp-json/jwt-auth/v1/token';
}

const Color baseColor = Color(0xffC23602);

const predefinedColors = {
  'Red': Colors.red,
  'Blue': Colors.blue,
  'Pink' : Colors.pink,
  'Green' : Colors.green,
  'Orange' : Colors.orange,
  'White' : Colors.white,
  'Yellow' : Colors.yellow
// Add more colors as needed
};



