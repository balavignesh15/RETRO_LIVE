
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'bottom.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        ),
        child: AnimatedSplashScreen(
          backgroundColor:Colors.transparent,
          splash: Column(
            children: [
              Center(
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/turfs.png"),
                          fit: BoxFit.fill)
                  ),),
              ),
              Text("Retro Station",style: TextStyle(fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),)
            ],
          ),
          splashIconSize: 600,
          nextScreen: bottomsample(),
          splashTransition: SplashTransition.sizeTransition,
        ),
      ),
    );
  }
}
