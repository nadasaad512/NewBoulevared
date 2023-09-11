import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../api/User_Controller.dart';
import '../../../models/setting.dart';
import '../../loed/loed.dart';

class ConditionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Back_Ground(
        eror: true,
        childTab: "سياسات الاعلان",
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Center(
                  child: CircleAvatar(
                      radius: 77.sp,
                     // backgroundColor: Colors.white,
                      backgroundImage: const AssetImage("images/basicLogo.png")),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                    child: Text(
                  "بوليڤارد ",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
                )),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder<Settings>(
                    future: UserApiController().Setting(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoedWidget();
                      } else if (snapshot.hasData) {
                        return  Html(data:snapshot.data!.advertisingPolicies.toString(), style: {
                          "p": Style(
                              fontSize: FontSize(16.0),
                              color: Colors.black
                            // Add more styling properties as needed
                          ),
                          "strong": Style(
                              fontSize: FontSize(16.0),
                              color: Colors.black
                          ),
                        });



                      }
                      return const Center(
                        child: Icon(
                          Icons.wifi_off_rounded,
                          size: 80,
                          color: Colors.purple,
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
