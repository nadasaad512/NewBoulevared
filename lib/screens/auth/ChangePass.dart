


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/main_bac.dart';


class ChangePassword extends StatefulWidget{
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController ChpasswordTextController=TextEditingController();
  TextEditingController ChCopasswordTextController=TextEditingController();
  TextEditingController OldpasswordTextController=TextEditingController();
  bool progss =false;


  @override
  void initState() {
    super.initState();
    ChpasswordTextController = TextEditingController();
    ChCopasswordTextController = TextEditingController();
    OldpasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    ChpasswordTextController.dispose();
    ChCopasswordTextController.dispose();
    OldpasswordTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Back_Ground(
      back: true,
      Bar: true,
      eror: true,

      childTab: "تغيير كلمة المرور",
      child: SingleChildScrollView(


        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(

            children: [
              SizedBox(height: 41.h,),
              Center(child: SvgPicture.asset("images/010---Secure-Password.svg",)),
              SizedBox(height: 42.h,),
              Align(
                alignment: Alignment.topRight,
                child: Text("كلمة المرور الجديدة يجب ان تكون مختلفة ",style: TextStyle(
                    color: Color(0xff7B217E),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp
                ),),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text("عن الكلمة الحالية  ",style: TextStyle(
                    color: Color(0xff7B217E),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp
                ),),
              ),
              SizedBox(height: 30.h,),
              FieldScreen(title: "كلمة المرور القديمة",security: true,controller: OldpasswordTextController),
              SizedBox(height: 16.h,),
              FieldScreen(title: "كلمة المرور الجديدة",security: true,controller: ChpasswordTextController),
              SizedBox(height: 16.h,),
              FieldScreen(title: "تأكيد كلمة المرور الجديدة",security: true,controller: ChCopasswordTextController),
              SizedBox(height: 45.h,),
              ElevatedButton  (
                onPressed: () async {
                  setState(() {
                    progss=true;
                  });
                  await  ChangePass();
                },
                child: progss?CircularProgressIndicator(color: Colors.white,): Text('تغيير كلمة المرور',style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp
                ),),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff7B217E),

                  minimumSize: Size(double.infinity, 50.h),
                ),
              ),

              SizedBox(height: 500.h,),


            ],
          ),
        ),
      ),



    );
  }

  Future ChangePass() async {
    bool loggedIn = await UserApiController().Change_Password(context,
        password: ChpasswordTextController.text,
        confirm_password: ChCopasswordTextController.text,
        old_password: OldpasswordTextController.text
    );
    if(loggedIn){
      Navigator.pop(context);
      ChpasswordTextController.clear();
      ChCopasswordTextController.clear();
      OldpasswordTextController.clear();
    }else{
      setState(() {
        progss=false;
      });
    }



  }
}


