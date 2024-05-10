import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:get/get.dart';
import 'package:preetprab/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService{

  static String? currentUser;
  static String? currentUserEmail;

  //   ..interceptors.add( RetryInterceptor(
  //
  //     dio: dio,
  //     options: RetryOptions(
  //       retries: 3, // Number of retries before a failure
  //       retryInterval: const Duration(seconds: 1), // Interval between each retry
  //       retryEvaluator: (error) => error.type != DioErrorType.CANCEL && error.type != DioErrorType.RESPONSE, // Evaluating if a request should be retried
  //     ),
  //   ));

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
      currentUser = jsonData['user_nicename'];
      currentUserEmail = jsonData['user_email'];
      return true;
    }
    else{
      String error = jsonData['code'];
      if(error.contains('incorrect_password')){
        error = 'Incorrect Password!!! Try Again';
      }
      else if(error.contains('invalid_email')){
        error = 'Invalid Email!!! Re-check';
      }
      else{
        error = 'Some Error Occurred!!! Try Again';
      }
      Get.showSnackbar(GetSnackBar(message: error,duration: const Duration(seconds: 3),));
      return false;
    }

 }catch(e){
   Get.showSnackbar(const GetSnackBar(message: 'Check Internet Connectivity',duration: Duration(seconds: 2),));

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
