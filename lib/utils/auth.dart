import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService{

  static String? currentUser;
  static String? userEmail;

  Future<bool> authenticate(String username,String password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
 try {
   /// Parameters to be passed
   Map<String, String> body = {
     'username': username,
     'password': password,
   };

   var response = await http.post(
       Uri.parse(APIUrls.authenticateUser), body: body);
   log(response.body);
   Map<String, dynamic> jsonData = jsonDecode(response.body);
    if(jsonData['success'] == true){
      prefs.setBool('isLoggedIn', true);
    }
    else{
      Get.showSnackbar(GetSnackBar(message: jsonData['message'],duration: Duration(seconds: 3),));
    }
   return jsonData['success'];
 }catch(e){
   return false;
 }
  }

  Future<bool> registerUser(String username,String email,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      /// Parameters to be passed
      Map<String, String> body = {
        'username': username,
        'email': email,
        'password': password,
      };

      var response = await http.post(
          Uri.parse(APIUrls.registerUser), body: body);
      log(response.body);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if(jsonData['success'] == true){
        prefs.setBool('isLoggedIn', true);
      }
      else{
        Get.showSnackbar(GetSnackBar(message: jsonData['message'],duration: Duration(seconds: 3),));
      }
      return jsonData['success'];
    }
    catch(e){
      return false;
    }

  }

}
