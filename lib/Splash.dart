
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Shared_Preferences/User_Preferences.dart';



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
     print(UserPreferences().token) ;

      setState(() {
        looading=true;
      });


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
     body:  looading?

         Container(
           alignment: Alignment.center,
           width: double.infinity,
           height: double.infinity,

           decoration: BoxDecoration(
             image: DecorationImage(
               fit: BoxFit.cover,
               image: AssetImage('images/WhatsApp Image 2022-07-02 at 8.25.04 AM.png',)
             ),
           ),
           child:  Padding(
             padding: EdgeInsets.symmetric(
               horizontal: 60.w,
               vertical: 50.h
             ),

             child:Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(height: 30.h,),

                 LinearPercentIndicator(
                   width: 250.0.w,
                   animation: true,
                   animationDuration: 2000,
                   lineHeight: 10.h,
                   percent:1.0,
                   linearStrokeCap: LinearStrokeCap.butt,
                   backgroundColor: Colors.grey,
                   progressColor: Colors.white,
                   onAnimationEnd: (){
                     Navigator.pushReplacementNamed(context,'/MainScreen');
                   },

                 ),
                 SizedBox(height: 10.h,),
                 Text("...L O A D I N G ",style: TextStyle(
                     color: Colors.white,
                     fontSize: 20,


                 ),),
               ],
             )



           )


         )
    :
     Center(
       child: Image.asset("images/logo.png"),
     )
   );
  }
}