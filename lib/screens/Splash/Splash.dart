import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacementNamed(context,'/MainScreen');
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xff231f20),
     body: Center(
       child: Image.asset("images/logoboulvard.png",fit: BoxFit.cover),
     )
   );
  }
}