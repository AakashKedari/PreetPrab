import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.home))
              ],
              centerTitle: true,
              title: Text(
                'Checkout',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.w300, fontSize: 20),
              ),
              leading: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  Get.back();
                },
              ),
              bottom: const TabBar(
                tabAlignment: TabAlignment.center,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      'ADDRESS',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Tab(
                    child: Text('SHIPPING',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                  Tab(
                    child: Text('REVIEW',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                  Tab(
                    child: Text('PAYMENT',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                child: infoTextFields(),
              ),
            )));
  }

  Column infoTextFields() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(label: Text('First Name'),),
        ),
        TextFormField(
          decoration: const InputDecoration(label: Text('Last Name')),
        ),
        TextFormField(
          decoration: const InputDecoration(label: Text('Email')),
        ),
        TextFormField(
          decoration: const InputDecoration(label: Text('Street Name')),
        ),
        TextFormField(
          decoration: const InputDecoration(label: Text('City')),
        ),
        TextFormField(
          decoration: const InputDecoration(label: Text('State/Province')),
        ),
        DropdownButtonFormField<String>(
            iconSize: 38,
            hint: const Text('Country'),
            items: <String>['India', 'Nepal', 'Sri Lanka']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {}),
        TextFormField(
          decoration: const InputDecoration(label: Text('Pin-Code')),
        ),
        TextFormField(
          decoration: const InputDecoration(label: Text('Phone Number')),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: const Center(
                child: Text(
                  'CONTINUE TO SHOPPING',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}
