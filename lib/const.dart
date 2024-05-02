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

const String imageErrorHandler = 'https://images.unsplash.com/photo-1528731708534-816fe59f90cb?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';



