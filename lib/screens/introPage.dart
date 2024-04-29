import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/screens/loginScreen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/transparent.png',width:120 ,),),
      body: Column(
        children: [
          Expanded(child: Image.asset('assets/images/loginPhoto.png')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              minWidth: double.infinity,
              shape: const RoundedRectangleBorder(),
              onPressed: (){
                Get.offAll(()=> LoginPage());
              },color: Colors.black,child: const ListTile(leading: Text('Login/SignUp',style: TextStyle(color: Colors.white,fontSize: 12),),trailing: Icon(Icons.arrow_forward,color: Colors.white),),),
          )
        ],
      ),
    );
  }
}
