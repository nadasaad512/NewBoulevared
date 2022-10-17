import 'package:new_boulevard/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/background.dart';

class ResetPasswordScreen extends StatefulWidget{
  final String email;

  ResetPasswordScreen({required this.email});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>with Helpers {
  bool progss =false;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;


  late TextEditingController _newPasswordTextController;
  late TextEditingController _newPasswordConfirmationTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  @override
  void initState() {
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _newPasswordTextController = TextEditingController();
    _newPasswordConfirmationTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _newPasswordTextController.dispose();
    _newPasswordConfirmationTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

  return BackGround(
    back: true,
    rout:  '/forget_password_screen',
    child:  SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 100.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text("تأكيد البريد الالكتروني",style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22.sp,
              ),),
            ),
            SizedBox(height: 32.h,),


            Container(
              margin: EdgeInsets.only(
                  right: 20.w
              ),
              child: Text("أدخل الرمز المكون من 4 أرقام الذي تم ارساله الى ",style: TextStyle(

                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),),
            ),
            Text(widget.email,style: TextStyle(
              color: Color(0xff7B217E),
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),),

            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                Expanded(
                  child: SizedBox(
                    height:60.h ,
                    width: 55.w,
                    child: TextField(
                      textDirection:  TextDirection.rtl,
                      controller: _fourthCodeTextController,
                      cursorColor: Colors.purple,
                      focusNode: _fourthFocusNode,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {
                        if (value.isEmpty) _thirdFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: _border,
                        focusedBorder: _border,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16.w),
                Expanded(
                  child: SizedBox(
                    height:60.h ,
                    width: 55.w,
                    child: TextField(
                      textDirection:  TextDirection.rtl,
                      cursorColor: Colors.purple,
                      controller: _thirdCodeTextController,
                      focusNode: _thirdFocusNode,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {
                        if (value.isNotEmpty)
                          _fourthFocusNode.requestFocus();
                        else
                          _secondFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: _border,
                        focusedBorder: _border,
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 16.w),
                Expanded(
                  child: SizedBox(
                    height:60.h ,
                    width: 55.w,
                    child: TextField(
                      textDirection:  TextDirection.rtl,

                      controller: _secondCodeTextController,
                      focusNode: _secondFocusNode,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.purple,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {
                        if (value.isNotEmpty)
                          _thirdFocusNode.requestFocus();
                        else
                          _firstFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: _border,
                        focusedBorder: _border,
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 16.w),
                Expanded(

                  child: SizedBox(
                    height:60.h ,
                    width: 55.w,
                    child: TextField(
                      textDirection:  TextDirection.rtl,
                      controller: _firstCodeTextController,
                      focusNode: _firstFocusNode,
                      maxLength: 1,
                      cursorColor: Colors.purple,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {
                        if (value.isNotEmpty) _secondFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: _border,
                        focusedBorder: _border,
                      ),
                    ),
                  ),
                ),


              ],
            ),

            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("لم يصلك الرمز ؟",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,

                ),),
                TextButton(onPressed: ()async{
                  await ReSendCode();
                }, child: Text("أرسل مرة أخرى",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,

                    color: Color(0xff18499A)
                ),)),

              ],
            ),
            SizedBox(height: 20.h,),

            FieldScreen(title: "كلمة المرور",controller: _newPasswordTextController,),
            SizedBox(height: 16.h,),
            FieldScreen(title: "تأكيد كلمة المرور",security: true,controller: _newPasswordConfirmationTextController,),




            SizedBox(height: 20.h,),
            ElevatedButton  (
              onPressed: () async {
                setState(() {
                  progss=true;
                });
                await performChangePassword();
              },
              child:progss?CircularProgressIndicator(color: Colors.white,): Text('تأكيد البريد الالكتروني',style: TextStyle(
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
        ),
      ),
    ),
  );
  }
  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: Colors.grey.shade500,
      ),
    );
  }


  Future performChangePassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    var verificationCode = code;
    if (verificationCode.isNotEmpty &&
        verificationCode.length == 4 &&
        _newPasswordTextController.text.isNotEmpty &&
        _newPasswordConfirmationTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'أدخل البيانات المطلوبة !', error: true);
    setState(() {
      progss=false;
    });
    return false;
  }

  String get code {
    return _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
  }

  Future resetPassword() async {
   bool status = await UserApiController().createNewPassword(context,
       password: _newPasswordTextController.text,
       confirm_password: _newPasswordConfirmationTextController.text,
       email: widget.email,
       code: code
   );
    if (status) {
      Navigator.pushNamed(context, '/logain_screen');
    }else{
      setState(() {
        progss=false;
      });
    }
  }



  ReSendCode() async {
     await UserApiController().ReSendCode(context, email: widget.email,);


  }
}