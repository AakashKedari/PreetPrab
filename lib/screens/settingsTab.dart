import 'package:flutter/material.dart';

  Widget settings() {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                'assets/images/settings.png',
                fit: BoxFit.cover,
              ),
            ),
            const ListTile(
              leading: CircleAvatar(),
              title: Text('Minh Pam'),
            ),
            const ListTile(
              horizontalTitleGap: 30,
              leading: Icon(
                Icons.email,
                size: 30,
              ),
              title: Text('minhcasi@yahoo.com'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'General Settings',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.favorite_outline_sharp, color: Colors.grey,),
              title: Text('My Wishlist',style: TextStyle(fontWeight: FontWeight.w200),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '4 items',
                    style: TextStyle(color: Colors.cyan),
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active, color: Colors.grey,),
              title: const Text('Get Notification',style: TextStyle(fontWeight: FontWeight.w100),),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: true,
                  onChanged: (bool value) {},
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Order Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const ListTile(
              horizontalTitleGap: 30,
              leading: Icon(
                color: Colors.grey,
                Icons.delivery_dining_sharp,
                size: 30,
              ),
              title: Text('Order History',style: TextStyle(fontWeight: FontWeight.w100),),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const ListTile(
              horizontalTitleGap: 30,
              leading: Icon( color: Colors.grey,
                Icons.star_rate_outlined,
                size: 30,
              ),
              title: Text('Rate the App',style: TextStyle(fontWeight: FontWeight.w100),),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const ListTile(
              horizontalTitleGap: 30,
              leading: Icon( color: Colors.grey,
                Icons.logout,
                size: 30,
              ),
              title: Text('Logout',style: TextStyle(fontWeight: FontWeight.w100),),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
    );
  }

