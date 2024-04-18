import 'package:flutter/material.dart';
import 'package:preetprab/screens/productsTab.dart';
import 'package:preetprab/screens/searchTab.dart';
import 'package:preetprab/screens/settingsTab.dart';
import 'cartTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.token_outlined,
                color: Colors.blue,
              ),
              Text('PreetPrab'),
            ],
          ),),
          // bottom: currentIndex != 3 ?  const PreferredSize(
          //   preferredSize: Size(double.infinity, 100),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Column(
          //         children: [
          //           Icon(
          //             Icons.man,
          //             size: 40,
          //             color: Colors.cyan,
          //           ),
          //           Text('Men')
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Icon(
          //             Icons.woman_2_rounded,
          //             size: 40,
          //             color: Colors.lightBlue,
          //           ),
          //           Text('Women')
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Icon(
          //             Icons.checkroom,
          //             size: 40,
          //             color: Colors.blue,
          //           ),
          //           Text('Clothing')
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Icon(
          //             Icons.shopping_basket,
          //             size: 40,
          //             color: Colors.blueGrey,
          //           ),
          //           Text('Posters')
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Icon(
          //             Icons.headphones,
          //             size: 40,
          //             color: Colors.black45,
          //           ),
          //           Text('Music')
          //         ],
          //       )
          //     ],
          //   ),
          // ) : null),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 40,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Settings')
        ],
      ),
      body: currentIndex == 0 ? const FirstTab() : currentIndex == 1 ? body2() : currentIndex == 2 ? body3(context) : body4(),
    );
  }
}

Widget body1(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(children: [
      SizedBox(height: 15,),
      Image.asset('assets/images/summer.png'),
      Image.asset('assets/images/tshirts.png'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text('Features Products',style: TextStyle(fontWeight: FontWeight.bold),),TextButton(onPressed: (){}, child: const Text("See All"))],)
    ],),
  );
}
Widget body2(){

  return SearchCategory();
        // SizedBox(
        //   width: double.infinity,
        //   height: 150,
        //   child: Image.asset('assets/images/clothing.png'),
        // ),
        //  ExpansionPanelList(
        //   expansionCallback: (int index,bool isExpanded) {
        //
        //   },
        // )
        // ExpansionPanel(headerBuilder: (BuildContext context,bool isExpanded){
        //   return SizedBox(
        //     width: double.infinity,
        //     height: 150,
        //     child: Image.asset('assets/images/men.png'),
        //   ),
        // }, body: Text('Hii'));
        // SizedBox(
        //   width: double.infinity,
        //   height: 150,
        //   child: Image.asset('assets/images/men.png'),
        // ),
        // SizedBox(
        //   width: double.infinity,
        //   height: 150,
        //   child: Image.asset('assets/images/women.png'),
        // ), SizedBox(
        //   width: double.infinity,
        //   height: 150,
        //   child: Image.asset('assets/images/music.png'),
        // ),
  //     ],
  //   ),
  // );
}
Widget body3(BuildContext context){
  return cart(context);
}
Widget body4(){
  return settings();
}