// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// class InfoScreen extends StatefulWidget{
//   @override
//   State<InfoScreen> createState() => _InfoScreenState();
// }
//
// class _InfoScreenState extends State<InfoScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//    return Container(
//        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
//        decoration: BoxDecoration(
//
//            borderRadius: BorderRadius.only(
//              topRight: Radius.circular(15),
//              topLeft:  Radius.circular(15),
//            )
//        ),
//        height: 520.h,
//        width: double.infinity,
//
//        alignment: Alignment.center,
//        child: ListView(
//          children: [
//            Row(
//
//              children: [
//
//
//                Text("وصف الإعلان",style: TextStyle(
//                    color: Color(0xff7B217E),
//                    fontSize: 16.sp,
//                    fontWeight: FontWeight.w600
//                ),),
//                Spacer(),
//
//                IconButton(onPressed: (){
//                  Navigator.pop(context);
//                }, icon: SvgPicture.asset("images/close.svg"),),
//
//              ],
//            ),
//            SizedBox(height: 10.h,),
//            ad.details!=null?
//            Text(  ad.details!,style: TextStyle(
//                fontSize: 14.sp,
//                fontWeight: FontWeight.w400
//            ),):Container(),
//            SizedBox(height: 12.h,),
//            Row(
//              children: [
//                IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
//                Text(" السعودية-   ${ad.city}",style: TextStyle(
//                    color: Color(0xff7B217E),
//                    fontSize: 16.sp,
//                    fontWeight: FontWeight.w400
//                ),),
//
//              ],
//            ),
//            SizedBox(height: 26.h,),
//
//            Container(
//              width: 343.w,
//              height: 100.h
//              ,
//              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(5),
//                color: Colors.purple.shade50,
//              ),
//              child: Container(
//                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//                child: Column(
//                  children: [
//                    ad.store_url==null?Container():
//                    Detatlies(name:ad.store_url!,image: "images/earth.svg"),
//                    SizedBox(height: 20.h,),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        ad.twitter==null?Container():
//                        SvgPicture.asset("images/twitter.svg"),
//                        SizedBox(width: 26.w,),
//                        ad.instagram==null?Container():
//                        SvgPicture.asset("images/instegram.svg"),
//                        SizedBox(width: 26.w,),
//                        ad.whatsapp==null?Container():
//                        SvgPicture.asset("images/whatsapp.svg"),
//                        SizedBox(width: 26.w,),
//                        ad.facebook==null?Container():
//                        SvgPicture.asset("images/facebook.svg"),
//
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//
//
//            )
//
//
//
//
//
//
//          ],
//        )
//    );
//   }
//
//
//   Widget Detatlies({required String name, required String image}){
//     return  Row(
//       children: [
//
//         SvgPicture.asset(image),
//         SizedBox(width: 10.w,),
//         Text(
//           name,
//           style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }
// }
