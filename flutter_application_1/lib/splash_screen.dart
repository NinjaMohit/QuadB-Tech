import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for left-to-right slide animation
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start from left (off-screen)
      end: const Offset(0.0, 0.0), // End at original position (center)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation
    _animationController.forward();

    // Navigate to home screen after splash screen duration
    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: SizedBox(
            width: screenWidth *
                0.9, // Image width will be 60% of the screen width
            height: screenHeight *
                0.7, // Image height will be 40% of the screen height
            child: Image.asset('assets/image.png', fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
