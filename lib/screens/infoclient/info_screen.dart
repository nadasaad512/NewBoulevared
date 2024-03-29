import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api/User_Controller.dart';
import '../../loed/loed.dart';
import '../../models/setting.dart';

class InfoScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Back_Ground(
      eror: true,
      childTab: "عن التطبيق",
        child:Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
             // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                SizedBox(height: 24.h,),
                Center(
                  child: CircleAvatar(
                    radius:77.sp,
                    //  backgroundColor: Colors.white,
                      backgroundImage: AssetImage("images/basicLogo.png")

                  ),
                ),
                SizedBox(height: 20.h,),
                Center(child: Text("بوليڤارد "   ,style: TextStyle(
                 fontWeight: FontWeight.w600,
                  fontSize: 20.sp

                ),)),

                SizedBox(height: 10.h,),
            FutureBuilder<Settings>(
                future: UserApiController().Setting(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoedWidget();
                  } else if (snapshot.hasData) {

                    return Text(snapshot.data!.description.toString()
                      ,style: TextStyle(
                      overflow: TextOverflow.ellipsis,

                    ),
                      maxLines:80,
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