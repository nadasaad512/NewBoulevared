// import 'package:new_boulevard/api/User_Controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../component/main_bac.dart';
// import '../../../models/Follower_user.dart';
// import '../../../models/ads.dart';
// import '../../../models/user.dart';
// import '../allFollower.dart';
//
//
//
// class UserShowAdmain extends StatefulWidget {
//   int id;
//
//   UserShowAdmain({required this.id});
//
//   @override
//   State<UserShowAdmain> createState() => _UserShowAdmainState();
// }
//
// class _UserShowAdmainState extends State<UserShowAdmain> {
//   @override
//   List<AdvertiserADs> _ads = [];
//
//   Widget build(BuildContext context) {
//     return FutureBuilder<Advertiser>(
//         future: UserApiController().info_Admain(userid: widget.id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.purple,
//                 ));
//           } else if (snapshot.hasData) {
//             return Back_Ground(
//                 Bar: true,
//                 back: true,
//                 eror: true,
//                 EditAdmain: true,
//                 childTab: snapshot.data!.name!,
//                 child: DefaultTabController(
//                   length: 2,
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 24.h,
//                             ),
//                             CircleAvatar(
//                                 radius: 44.sp,
//                                 backgroundColor: Colors.purple,
//                                 backgroundImage: snapshot.data!.imageProfile !=
//                                     null
//                                     ? NetworkImage(snapshot.data!.imageProfile!)
//                                     : null),
//                             SizedBox(
//                               height: 14.h,
//                             ),
//                             Text(
//                               snapshot.data!.name!,
//                               style: TextStyle(
//                                   fontSize: 16.sp, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => AllFollower(
//                                             id: widget.id,
//                                           )));
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: 38.h,
//                                       width: 90.w,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xff969696),
//                                           borderRadius:
//                                           BorderRadius.circular(37)),
//                                       child: Center(
//                                         child: Text(
//                                           " ${snapshot.data!.followMeCount} متابع",
//                                           style: TextStyle(
//                                               fontSize: 16.sp,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 35.w,
//                                     ),
//                                     FutureBuilder<User?>(
//                                         future:
//                                         UserApiController().getProfile(),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.hasData) {
//                                             return snapshot.data!.id !=
//                                                 widget.id
//                                                 ? FutureBuilder<
//                                                 List<MyFollowings>>(
//                                               future: UserApiController()
//                                                   .Followers_User(),
//                                               builder:
//                                                   (context, snapshot) {
//                                                 if (snapshot
//                                                     .connectionState ==
//                                                     ConnectionState
//                                                         .waiting) {
//                                                   return Center(
//                                                       child:
//                                                       CircularProgressIndicator(
//                                                         color: Colors.purple,
//                                                       ));
//                                                 } else if (snapshot
//                                                     .hasData &&
//                                                     snapshot.data!
//                                                         .isNotEmpty) {
//                                                   List f = snapshot
//                                                       .data!
//                                                       .map((e) => e.id)
//                                                       .toList();
//                                                   return f.contains(
//                                                       widget.id)
//                                                       ? InkWell(
//                                                     onTap:
//                                                         () async {
//                                                       await UserApiController().Follow_One(
//                                                           followed_id:
//                                                           widget
//                                                               .id
//                                                               .toString(),
//                                                           action:
//                                                           "unfollow");
//                                                       setState(
//                                                               () {});
//                                                     },
//                                                     child:
//                                                     Container(
//                                                       height: 38.h,
//                                                       width: 90.w,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                           BorderRadius.circular(
//                                                               37),
//                                                           color: Color(
//                                                               0xff18499A)),
//                                                       child:
//                                                       Container(
//                                                         margin: EdgeInsets.symmetric(
//                                                             horizontal:
//                                                             5.w),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                           children: [
//                                                             Text(
//                                                               "إلغاء متابعة",
//                                                               style: TextStyle(
//                                                                   color: Colors.white,
//                                                                   fontSize: 14.sp,
//                                                                   fontWeight: FontWeight.w600),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )
//                                                       : InkWell(
//                                                     onTap:
//                                                         () async {
//                                                       await UserApiController().Follow_One(
//                                                           followed_id:
//                                                           widget
//                                                               .id
//                                                               .toString(),
//                                                           action:
//                                                           "follow");
//                                                       setState(
//                                                               () {});
//                                                     },
//                                                     child:
//                                                     Container(
//                                                       height: 38.h,
//                                                       width: 90.w,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                           BorderRadius.circular(
//                                                               37),
//                                                           color: Color(
//                                                               0xff18499A)),
//                                                       child:
//                                                       Container(
//                                                         margin: EdgeInsets.symmetric(
//                                                             horizontal:
//                                                             5.w),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                           children: [
//                                                             Icon(
//                                                               Icons
//                                                                   .add_sharp,
//                                                               color:
//                                                               Colors.white,
//                                                               size:
//                                                               20,
//                                                             ),
//                                                             SizedBox(
//                                                               width:
//                                                               10.w,
//                                                             ),
//                                                             Text(
//                                                               "متابعة",
//                                                               style: TextStyle(
//                                                                   color: Colors.white,
//                                                                   fontSize: 14.sp,
//                                                                   fontWeight: FontWeight.w600),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   return InkWell(
//                                                     onTap: () async {
//                                                       await UserApiController()
//                                                           .Follow_One(
//                                                           followed_id:
//                                                           widget
//                                                               .id
//                                                               .toString(),
//                                                           action:
//                                                           "follow");
//                                                       setState(() {});
//                                                     },
//                                                     child: Container(
//                                                       height: 38.h,
//                                                       width: 90.w,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                           BorderRadius
//                                                               .circular(
//                                                               37),
//                                                           color: Color(
//                                                               0xff18499A)),
//                                                       child: Container(
//                                                         margin: EdgeInsets
//                                                             .symmetric(
//                                                             horizontal:
//                                                             5.w),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                           children: [
//                                                             Icon(
//                                                               Icons
//                                                                   .add_sharp,
//                                                               color: Colors
//                                                                   .white,
//                                                               size: 20,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 10.w,
//                                                             ),
//                                                             Text(
//                                                               "متابعة",
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 14
//                                                                       .sp,
//                                                                   fontWeight:
//                                                                   FontWeight.w600),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }
//                                               },
//                                             )
//                                                 : Container();
//                                           }
//                                           return Center(
//                                             child: Column(
//                                               children: [
//                                                 Text(
//                                                   '',
//                                                   style:
//                                                   TextStyle(fontSize: 26),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         }),
//                                   ],
//                                 )),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 22.h,
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 16.w),
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.purple.shade50,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: TabBar(
//                           indicator: BoxDecoration(
//                               color: Color(0xff7B217E),
//                               borderRadius: BorderRadius.circular(5)),
//                           labelColor: Colors.white,
//                           unselectedLabelColor: Color(0xff7B217E),
//                           tabs: [
//                             Tab(
//                               text: "تواصل معنا",
//                             ),
//                             Tab(
//                               text: "الإعلانات",
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                           child: TabBarView(
//                             //controller: tabController,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                         width: 343.w,
//                                         margin: EdgeInsets.symmetric(
//                                             horizontal: 16.w, vertical: 10.h),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           color: Colors.purple.shade50,
//                                         ),
//                                         child: Container(
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: 20.w, vertical: 20.h),
//                                           child: Column(
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   launch(
//                                                       "whatsapp://send?phone=${snapshot.data!.mobile}&text=${"Hi"}");
//                                                 },
//                                                 child: Detatlies(
//                                                     name: snapshot.data!.mobile!
//                                                         .toString(),
//                                                     image: "images/phone.svg"),
//                                               ),
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   launch(
//                                                       "mailto:${snapshot.data!.email}");
//                                                 },
//                                                 child: Detatlies(
//                                                     name: snapshot.data!.email!,
//                                                     image: "images/gmail.svg"),
//                                               ),
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               snapshot.data!.website != null
//                                                   ? Detatlies(
//                                                   name: snapshot.data!.website!,
//                                                   image: "images/earth.svg")
//                                                   : Text(""),
//                                               SizedBox(
//                                                 height: 26.h,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 26.w,
//                                                   ),
//                                                   snapshot.data!.instagram != null
//                                                       ? InkWell(
//                                                     onTap: () {
//                                                       //url_launcher: ^6.0.18
//
//                                                       launch(snapshot
//                                                           .data!.instagram!);
//                                                     },
//                                                     child: SvgPicture.asset(
//                                                         "images/insnapshot.data!.instagram!stegram.svg"),
//                                                   )
//                                                       : Text(""),
//                                                   SizedBox(
//                                                     width: 26.w,
//                                                   ),
//                                                   snapshot.data!.whatsapp != null
//                                                       ? InkWell(
//                                                     onTap: () {
//                                                       launch(snapshot
//                                                           .data!.whatsapp!);
//                                                     },
//                                                     child: SvgPicture.asset(
//                                                         "images/whatsapp.svg"),
//                                                   )
//                                                       : Text(""),
//                                                   SizedBox(
//                                                     width: 26.w,
//                                                   ),
//                                                   snapshot.data!.facebook != null
//                                                       ? InkWell(
//                                                     onTap: () {
//                                                       launch(snapshot
//                                                           .data!.facebook!);
//                                                     },
//                                                     child: SvgPicture.asset(
//                                                         "images/facebook.svg"),
//                                                   )
//                                                       : Text(""),
//                                                   SizedBox(
//                                                     width: 26.w,
//                                                   ),
//                                                   snapshot.data!.website != null
//                                                       ? InkWell(
//                                                     onTap: () {
//                                                       launch(snapshot
//                                                           .data!.website!);
//                                                     },
//                                                     child: SvgPicture.asset(
//                                                       "images/earth.svg",
//                                                       height: 20.h,
//                                                     ),
//                                                   )
//                                                       : Text(""),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 26.h,
//                                               ),
//                                             ],
//                                           ),
//                                         )),
//                                     SizedBox(
//                                       height: 30.h,
//                                     ),
//                                   ],
//                                 ),
//                                 FutureBuilder<List<AdvertiserADs>>(
//                                   future: UserApiController()
//                                       .ADS_Admain(userid: widget.id),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Center(
//                                           child: CircularProgressIndicator());
//                                     } else if (snapshot.hasData &&
//                                         snapshot.data!.isNotEmpty) {
//                                       _ads = snapshot.data ?? [];
//                                       return SingleChildScrollView(
//                                         child: SizedBox(
//                                           width: 350.w,
//                                           child: GridView.builder(
//                                               scrollDirection: Axis.vertical,
//                                               itemCount: _ads.length,
//                                               gridDelegate:
//                                               SliverGridDelegateWithFixedCrossAxisCount(
//                                                   childAspectRatio:
//                                                   165.w / 170.h,
//                                                   crossAxisCount: 2,
//                                                   mainAxisSpacing: 14.h),
//                                               shrinkWrap: true,
//                                               physics: ScrollPhysics(),
//                                               itemBuilder: (BuildContext, index) {
//                                                 return _ads[index].adType!.type ==
//                                                     "special"
//                                                     ? InkWell(
//                                                   onTap: () {
//                                                     // Navigator.push(
//                                                     //   context,
//                                                     //   MaterialPageRoute(
//                                                     //       builder: (context) =>
//                                                     //           StoryPage1(
//                                                     //             data:_ads[index].id!,
//                                                     //
//                                                     //           )
//                                                     //   ),
//                                                     //
//                                                     //
//                                                     //
//                                                     // );
//                                                   },
//                                                   child: Container(
//                                                     margin: EdgeInsets.only(
//                                                         right: 5.w,
//                                                         left: 5.w),
//                                                     width: 130.w,
//                                                     decoration: BoxDecoration(
//                                                         color:
//                                                         Color(0xff7B217E),
//                                                         borderRadius:
//                                                         BorderRadius
//                                                             .circular(5),
//                                                         image: DecorationImage(
//                                                             fit: BoxFit.cover,
//                                                             image: NetworkImage(
//                                                                 _ads[index]
//                                                                     .image!
//                                                                     .toString()))),
//                                                     child: Stack(
//                                                       children: [
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .topLeft,
//                                                           child: IconButton(
//                                                             onPressed: () {},
//                                                             icon: Icon(
//                                                               Icons
//                                                                   .star_rounded,
//                                                               color: Color(
//                                                                   0xffFFCC46),
//                                                               size: 25.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )
//                                                     : InkWell(
//                                                   onTap: () {
//                                                     // Navigator.push(
//                                                     //   context,
//                                                     //   MaterialPageRoute(
//                                                     //       builder: (context) =>
//                                                     //           StoryPage1(
//                                                     //             data:_ads[index].id!,
//                                                     //
//                                                     //           )
//                                                     //   ),
//                                                     //
//                                                     //
//                                                     //
//                                                     // );
//                                                   },
//                                                   child: Container(
//                                                     margin:
//                                                     EdgeInsets.symmetric(
//                                                         horizontal: 5.w),
//                                                     width: 165.w,
//                                                     height: 170.h,
//                                                     decoration: BoxDecoration(
//                                                         color:
//                                                         Color(0xff7B217E),
//                                                         borderRadius:
//                                                         BorderRadius
//                                                             .circular(5),
//                                                         image: DecorationImage(
//                                                             fit: BoxFit.cover,
//                                                             image: NetworkImage(
//                                                                 _ads[index]
//                                                                     .image
//                                                                     .toString()))),
//                                                   ),
//                                                 );
//                                               }),
//                                         ),
//                                       );
//                                     } else {
//                                       return Column(
//                                         children: [
//                                           SizedBox(
//                                             height: 80.h,
//                                           ),
//                                           Container(
//                                               height: 150.h,
//                                               width: 150.w,
//                                               child: SvgPicture.asset(
//                                                   "images/ads.svg")),
//                                           SizedBox(
//                                             height: 50.h,
//                                           ),
//                                           Text(
//                                             "لا يوجد اعلانات في الوقت الحالي",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 16.sp),
//                                           )
//                                         ],
//                                       );
//                                     }
//                                   },
//                                 )
//                               ]))
//                     ],
//                   ),
//                 ));
//           }
//           return Center(
//             child: Icon(
//               Icons.wifi_off_rounded,
//               size: 80,
//               color: Colors.purple,
//             ),
//           );
//         });
//   }
//
//   Widget Detatlies({required String name, required String image}) {
//     return Row(
//       children: [
//         SvgPicture.asset(image),
//         SizedBox(
//           width: 10.w,
//         ),
//         Text(
//           name,
//           style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }
// }