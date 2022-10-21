
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/User_Controller.dart';
import '../../../component/main_bac.dart';
import '../../../models/Follower_user.dart';
import '../../../models/user.dart';
import 'User_Show_Admain.dart';

class UserProfileScreen extends StatefulWidget{
  User user ;
  UserProfileScreen({required this.user});
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<MyFollowings> _folow = [];
  @override
  Widget build(BuildContext context) {

   return Back_Ground(
       edit: true,
       Bar: true,
       childTab: "الملف _الشخصي",
       child: SingleChildScrollView(
         child: Column(
           children: [
             Column(
               children: [
                 SizedBox(
                   height: 24.h,
                 ),
                 CircleAvatar(
                   radius: 44.sp,
                   backgroundImage:
                   widget.user.imageProfile == null
                       ? null
                       : NetworkImage(
                       widget.user.imageProfile!),
                 ),
                 SizedBox(
                   height: 14.h,
                 ),
                 Text(
                   widget.user.name,
                   style: TextStyle(
                       fontSize: 16.sp,
                       fontWeight: FontWeight.w600),
                 ),
                 SizedBox(
                   height: 12.h,
                 ),
                 Container(
                   height: 38.h,
                   width: 87.w,
                   decoration: BoxDecoration(
                       color: Color(0xff18499A),
                       borderRadius: BorderRadius.circular(37)),
                   child: Center(
                     child: Text(
                       widget.user.pointsCount == null
                           ? "0"
                           : "${ widget.user.pointsCount!.toString()} نقطة",
                       style: TextStyle(
                           fontSize: 16.sp,
                           color: Colors.white,
                           fontWeight: FontWeight.w600),
                     ),
                   ),
                 )
               ],
             ),
             SizedBox(
               height: 22.h,
             ),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 20.w),
               child: Row(
                 children: [
                   SvgPicture.asset("images/follow.svg"),
                   SizedBox(
                     width: 8.w,
                   ),
                   Text(
                     "المتابع لهم",
                     style: TextStyle(
                         fontSize: 16.sp,
                         color: Color(0xff7B217E),
                         fontWeight: FontWeight.w600),
                   ),
                 ],
               ),
             ),
             FutureBuilder<List<MyFollowings>>(
               future: UserApiController().CountFollowers_User(),
               builder: (context, snapshot) {
                 if (snapshot.connectionState ==
                     ConnectionState.waiting) {
                   return Center(
                       child: CircularProgressIndicator(
                         color: Colors.purple,
                       ));
                 } else if (snapshot.hasData &&
                     snapshot.data!.isNotEmpty) {
                   _folow = snapshot.data ?? [];
                   return ListView.builder(
                     shrinkWrap: true,
                     itemCount: _folow.length,
                     itemBuilder: (context, index) {
                       return InkWell(
                         onTap: () {
                           Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                     UserShowAdmain(
                                         id: _folow[index].id!)),
                           );
                         },
                         child: Container(
                             width: 343.w,
                             margin: EdgeInsets.symmetric(
                                 horizontal: 10.w, vertical: 5.h),
                             decoration: BoxDecoration(
                                 color: Color(0xffD1D1D6),
                                 borderRadius:
                                 BorderRadius.circular(5)),
                             child: Container(
                               margin: EdgeInsets.symmetric(
                                   vertical: 5.h, horizontal: 5.w),
                               child: Card(
                                 child: Container(
                                     margin: EdgeInsets.symmetric(
                                         horizontal: 12.w,
                                         vertical: 10.h),
                                     child: FutureBuilder<
                                         Advertiser>(
                                         future: UserApiController()
                                             .info_Admain(
                                             userid:
                                             _folow[index]
                                                 .id!),
                                         builder:
                                             (context, snapshot) {
                                           if (snapshot
                                               .connectionState ==
                                               ConnectionState
                                                   .waiting) {
                                             return Center(
                                                 child:
                                                 CircularProgressIndicator(
                                                   color:
                                                   Colors.purple,
                                                 ));
                                           } else if (snapshot
                                               .hasData) {
                                             return Row(
                                               children: [
                                                 Container(
                                                     width: 70.w,
                                                     height: 71.h,
                                                     decoration: BoxDecoration(
                                                         borderRadius:
                                                         BorderRadius.circular(
                                                             5),
                                                         image: snapshot.data!.imageProfile !=
                                                             null
                                                             ? DecorationImage(
                                                             fit: BoxFit.cover,
                                                             image: NetworkImage(snapshot.data!.imageProfile!))
                                                             : null)),
                                                 SizedBox(
                                                   width: 15.w,
                                                 ),
                                                 Column(
                                                   children: [
                                                     Text(
                                                       snapshot
                                                           .data!
                                                           .name!,
                                                       style: TextStyle(
                                                           fontWeight:
                                                           FontWeight
                                                               .w400,
                                                           fontSize:
                                                           18.sp),
                                                     ),
                                                     SizedBox(
                                                       height:
                                                       10.h,
                                                     ),
                                                     Container(
                                                       height:
                                                       27.h,
                                                       width: 56.w,
                                                       decoration: BoxDecoration(
                                                           color: Color(
                                                               0xff969696),
                                                           borderRadius:
                                                           BorderRadius.circular(13)),
                                                       child:
                                                       Center(
                                                         child:
                                                         Text(
                                                           "${snapshot.data!.followMeCount.toString()} متابع",
                                                           style: TextStyle(
                                                               fontSize:
                                                               10.sp,
                                                               color: Colors.white,
                                                               fontWeight: FontWeight.w500),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 Spacer(),
                                                 InkWell(
                                                   onTap:
                                                       () async {
                                                     await UserApiController().Follow_One(
                                                         followed_id:
                                                         _folow[index]
                                                             .id
                                                             .toString(),
                                                         action:
                                                         "unfollow");

                                                     setState(
                                                             () {});
                                                   },
                                                   child:
                                                   Container(
                                                     height: 27.h,
                                                     width: 71.w,
                                                     decoration: BoxDecoration(
                                                         color: Color(
                                                             0xff18499A),
                                                         borderRadius:
                                                         BorderRadius.circular(
                                                             40)),
                                                     child: Center(
                                                       child: Text(
                                                         "إلغاء متابعة",
                                                         style: TextStyle(
                                                             fontSize: 10
                                                                 .sp,
                                                             color: Colors
                                                                 .white,
                                                             fontWeight:
                                                             FontWeight.w500),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             );
                                           }
                                           return Center(
                                             child: Column(
                                               children: [
                                                 Icon(
                                                     Icons.warning,
                                                     size: 80),
                                                 Text(
                                                   'NO DATA',
                                                   style: TextStyle(
                                                       fontSize:
                                                       26),
                                                 ),
                                               ],
                                             ),
                                           );
                                         })),
                               ),
                             )),
                       );
                     },
                   );
                 } else {
                   return Center();
                 }
               },
             ),
           ],
         ),
       ));
  }
}