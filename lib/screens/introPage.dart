import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preetprab/customWidgets/tncWidget.dart';
import 'package:preetprab/screens/loginScreen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Image.asset('assets/images/transparent.png',width:120 ,
            filterQuality: FilterQuality.high,
          ),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Image.asset('assets/images/loginPhoto.png',
              filterQuality: FilterQuality.high,)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
              child: MaterialButton(
                minWidth: double.infinity,
                shape: const RoundedRectangleBorder(),
                onPressed: (){
                  Get.offAll(()=> LoginPage());
                },color: Colors.white,child: const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text('Login/Register',style: TextStyle(
                    color: Colors.black,fontSize: 12),),trailing: Icon(Icons.arrow_forward,color: Colors.black),),),
            ),
           const Padding(
             padding: EdgeInsets.symmetric(horizontal: 20),
             child: TnCWidget(termsUrl: 'termsUrl', privacyUrl: 'privacyUrl'),
           )
          ],
        ),
      ),
    );
  }
}
