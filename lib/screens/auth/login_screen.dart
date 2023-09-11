import 'package:new_boulevard/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/background.dart';
import '../../provider/app_provider.dart';

class LOGAIN_SCREEN extends StatefulWidget {
  @override
  State<LOGAIN_SCREEN> createState() => _LOGAIN_SCREENState();
}

class _LOGAIN_SCREENState extends State<LOGAIN_SCREEN> with Helpers {


  @override
  Widget build(BuildContext context) {
    return  Consumer<AppProvider>(builder: (context, provider, _) {
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
                  controller: provider.emailTextControllerl,
                ),
                SizedBox(
                  height: 16.h,
                ),
                FieldScreen(
                  title: "كلمة المرور",
                  security: true,
                  controller: provider.passwordTextController,
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

                      provider.isLogin = true;
                      provider.notifyListeners();

                    await provider.login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7B217E),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: provider.isLogin
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18.sp,
                    color: Colors.white),
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
    });


  }


}
