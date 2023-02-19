

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


mixin Helpers {

  void showSnackBar(BuildContext context, {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),



        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 200.h,
            right: 20,
            top: 40.h,
            left: 20),


        backgroundColor: error ? Colors.red : Colors.green  ,
      ),
    );
  }


  showMassageBar(BuildContext context,{required String massage}){
    return   Flushbar(


      message: massage,
      backgroundGradient: LinearGradient(
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.centerEnd,
        colors: [
          Color(0xff7B217E),
          Color(0xff7B217E),
          Color(0xff18499A),
        ],
      ),
      icon: Icon(
        Icons.notifications_active_outlined,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: Colors.purple[300],
      margin: EdgeInsets.symmetric(horizontal: 5.w),
    )..show(context);
  }





}
