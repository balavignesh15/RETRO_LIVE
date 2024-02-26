import 'dart:async';

import 'package:flutter/material.dart';

import 'bottom.dart';



class spalsh1 extends StatefulWidget {
  const spalsh1({super.key});

  @override
  State<spalsh1> createState() => _spalshState();
}

class _spalshState extends State<spalsh1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_)=> bottomsample()));

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/turfs.png",height: 200,),
            Text("Retro station",style: TextStyle(fontSize: 40,
                color:Colors.white60,fontFamily: "Outfit",
              fontWeight: FontWeight.w100
                ),),
            SizedBox(height: 20,),
            // CircularProgressIndicator(
            //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
            // )

          ],
        ),
      ),
    );
  }
}