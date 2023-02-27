import 'package:new_boulevard/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/background.dart';

class LOGAIN_SCREEN extends StatefulWidget {
  @override
  State<LOGAIN_SCREEN> createState() => _LOGAIN_SCREENState();
}

class _LOGAIN_SCREENState extends State<LOGAIN_SCREEN> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  bool progss = false;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 100.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "تسجيل الدخول",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              FieldScreen(
                title: "البريد الالكتروني",
                controller: _emailTextController,
              ),
              SizedBox(
                height: 16.h,
              ),
              FieldScreen(
                title: "كلمة المرور",
                security: true,
                controller: _passwordTextController,
              ),

              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context,'/MainScreen');
                  },
                  child: Text(
                    "تصفح الان بدون تسجيل دخول",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xff18499A)),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forget_password_screen');
                  },
                  child: Text(
                    "نسيت كلمة المرور ؟",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                        color: const Color(0xff18499A)),
                  )),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    progss = true;
                  });
                  await login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7B217E),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: progss
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      child: Text(
                        "تسجيل جديد",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: const Color(0xff7B217E)),
                      )),
                  Text(
                    "ليس لديك حساب ؟",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 400.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future login() async {
    bool loggedIn = await UserApiController().login(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);

    if (loggedIn) {
      Navigator.pushReplacementNamed(context, '/MainScreen');
      _emailTextController.clear();
      _passwordTextController.clear();
    } else {
      setState(() {
        progss = false;
      });
    }
  }
}
