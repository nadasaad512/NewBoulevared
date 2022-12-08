

import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


 bool looading =false;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
     Navigator.pushReplacementNamed(context,'/MainScreen');

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body: Center(
       child: Image.asset("images/logo.png",),
     )
   );
  }
}