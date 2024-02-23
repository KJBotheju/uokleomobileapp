import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uokleo/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
    _animationController!.forward();
    Timer(Duration(seconds: 3), () {
      // Navigate to the home screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation!,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Replace this Container with your animated Image widget
              AnimatedOpacity(
                opacity: 1,
                duration: Duration(seconds: 1),
                child: Image.asset(
                  'assets/images/download.jpeg', // replace with your image path
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'UOK LEO',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
