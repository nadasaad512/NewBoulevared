import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/User_Controller.dart';
import '../../component/main_bac.dart';
import '../../models/Folllowers_Advertiser.dart';

class AllFollower extends StatelessWidget{
  List<MyFollowers> _folow = [];
 late int id ;
  AllFollower({required this.id});

  @override
  Widget build(BuildContext context) {
   return Back_Ground(
     Bar: true,
     backRout: '',
     eror: true,
     childTab: "المتابعين    ",
     back: true,
     child: FutureBuilder<List<MyFollowers>>(
       future: UserApiController().Followers_Advertiser(id),
       builder: (context, snapshot) {
         if (snapshot.connectionState ==
             ConnectionState.waiting) {
           return Center(child: CircularProgressIndicator(color: Colors.purple,));
         } else if (snapshot.hasData &&
             snapshot.data!.isNotEmpty) {
           _folow = snapshot.data ?? [];
           return ListView.builder(
             shrinkWrap: true,
             itemCount: _folow.length,
             itemBuilder: (context, index) {
               return Container(
                 height: 71.h,
                 width: 343.w,
                 margin: EdgeInsets.symmetric(horizontal: 10.w),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),


                 ),
                 child: Card(

                   child: Container(
                     margin: EdgeInsets.symmetric(horizontal: 10.w),
                     child: Row(
                       children: [
                         Container(
                           width: 55.w,
                           height: 51.h,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                               image: DecorationImage(
                                   fit: BoxFit.cover,
                                   image: NetworkImage(_folow[index].imageProfile.toString())
                               )
                           ),
                         ),
                         SizedBox(width:19.w ,),
                         Text(_folow[index].name.toString(),style: TextStyle(
                             fontSize: 18.sp,
                             fontWeight: FontWeight.w400
                         ),)
                       ],
                     ),
                   ),
                 )
               );
             },
           );
         } else {
           return Center(
             child:  Text(
               'لا يوجد متابعين   ',
               style: TextStyle(fontSize: 26),
             ),
           );
         }
       },
     ),

   );
  }

}