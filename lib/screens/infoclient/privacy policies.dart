import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api/User_Controller.dart';
import '../../component/background.dart';
import '../../loed/loed.dart';
import '../../models/setting.dart';
import '../../models/terms.dart';

class privacypolicies extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BackGround(
      back: true,
        rout: '/LOGAIN_SCREEN',
        child:Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100.h,),
                Center(child: Text("سياسة الخصوصية"   ,style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp

                ),)),

                SizedBox(height: 50.h,),
                FutureBuilder<terms>(
                    future: UserApiController().Security(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoedWidget();
                      } else if (snapshot.hasData) {

                        return 
                          Center(
                            child: Text(snapshot.data!.description.toString().replaceAll(RegExp(
                                r"<[^>]*>",
                                multiLine: true,
                                caseSensitive: true
                            ), "")
                            ,style: TextStyle(
                              overflow: TextOverflow.ellipsis,

                            ),
                            maxLines:80,
                        ),
                          ) ;
                      }
                      return Center(
                        child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                      );
                    })



              ],
            ),
          ),
        )
    );
  }

}