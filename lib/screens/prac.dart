import 'package:flutter/material.dart';

class SwipeUpScreen extends StatefulWidget {
  @override
  _SwipeUpScreenState createState() => _SwipeUpScreenState();
}

class _SwipeUpScreenState extends State<SwipeUpScreen> {
  bool _isSwipedUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/men.png', // Replace with your top image asset
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1), // Adjust the speed of the animation
            curve: Curves.easeInOut,
            bottom: _isSwipedUp ? MediaQuery.of(context).size.height : 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0) { // Swipe up detected
                  setState(() {
                    _isSwipedUp = true;
                  });
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white, // Background color for the bottom content
                child: Center(
                  child: Text('Swipe up content'), // Replace with your bottom content
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }}