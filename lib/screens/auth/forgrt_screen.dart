import 'package:new_boulevard/screens/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../api/User_Controller.dart';

import '../../component/TextField.dart';
import '../../component/background.dart';


class  ForgetPasswordScreen extends StatefulWidget{
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailTextController;
  bool progss =false;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return BackGround(
     back: true,
     rout:  '/logain_screen',
     child:  SingleChildScrollView(
       child: Container(
         margin: EdgeInsets.only(
             left: 16.w,
             right: 16.w,
             top: 100.h
         ),
         child: Column(

           children: [
             Center(
               child: Text("نسيت كلمة المرور ؟",style: TextStyle(
                 fontWeight: FontWeight.w700,
                 fontSize: 22.sp,
               ),),
             ),
             SizedBox(height: 32.h,),
             Container(
               margin: EdgeInsets.only(
                   right: 5.w
               ),
               child: Text(

                 " أدخل بريدك الإلكتروني المسجل أدناه لتلقي تعليمات إعادة تعيين كلمة المرور",

                 maxLines:2,
                 style: TextStyle(
                   overflow:  TextOverflow.ellipsis,


                 fontWeight: FontWeight.w500,
                 fontSize: 16.sp,
               ),),
             ),
             SizedBox(height: 30.h,),
             FieldScreen(title: "البريد الالكتروني",controller: _emailTextController,),
             SizedBox(height: 40.h,),
             ElevatedButton(
               onPressed: ()  async{
                 setState(() {
                   progss=true;
                 });
                 await  forgetPassword();
               },
               child:progss?CircularProgressIndicator(color: Colors.white,): Text('ارسال',style: TextStyle(
                   fontWeight: FontWeight.w700,
                   fontSize: 18.sp
               ),),
               style: ElevatedButton.styleFrom(
                 primary: Color(0xff7B217E),

                 minimumSize: Size(double.infinity, 50.h),
               ),
             ),
             SizedBox(height: 300.h,),





           ],
         )




       ),
     ),
   );
  }

  Future forgetPassword() async {
    bool loggedIn = await UserApiController().forgetPassword(context, email: _emailTextController.text,);
    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
            email:_emailTextController.text,
          ),
        ),
      );
     // _emailTextController.clear();

    }else{
      setState(() {
        progss=false;
      });
    }


  }


}