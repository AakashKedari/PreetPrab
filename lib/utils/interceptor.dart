// import 'package:dio/dio.dart';
//
// class RetryInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // You can configure retries here
//     options. = BaseOptions(
//       maxAttempts: 3, // Maximum number of retries
//       retryInterval: Duration(seconds: 1), // Delay between retries
//       retryOnConnectivityError: true, // Retry on network error
//       // Add more options as needed
//     );
//
//     super.onRequest(options, handler);
//   }
// }