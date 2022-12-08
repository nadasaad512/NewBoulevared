import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/main_bac.dart';
import '../../models/award.dart';
import '../../models/user.dart';

class AwardScreen extends StatefulWidget {
  @override
  State<AwardScreen> createState() => _AwardScreenState();
}

class _AwardScreenState extends State<AwardScreen> {
  List<Awards> award = [];

  TextEditingController emailTextController=TextEditingController();
  TextEditingController phoneTextController=TextEditingController();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    phoneTextController = TextEditingController();
  }

  @override
  void dispose() {

    emailTextController.dispose();
    phoneTextController.dispose();
    super.dispose();
  }
  bool close =false;
  User user=User();



  @override
  Widget build(BuildContext context) {
    return Back_Ground(
        Bar: true,
        ad: true,
        childTab: "الجوائز    ",
        child: RefreshIndicator(
          color: Colors.purple,
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 1500));
            setState(() {

            });
          },
          child: ListView(
            children: [

              FutureBuilder<User?>(
                  future: UserApiController().getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    }
                    else if (snapshot.hasData) {

                      return   snapshot.data!.type =='user'?
                      Column(
                        children: [
                          Center(
                            child: Container(
                              height: 46.h,
                              width: 231.w,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 56.w, vertical: 24.h),
                              decoration: BoxDecoration(
                                  color: Color(0xffC4C4C4),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                child: Row(
                                  children: [
                                    Text(
                                      "نقاطك الحالية",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 35.w,
                                    ),
                                    Text(
                                      snapshot.data!.pointsCount == null
                                          ? "0 نقطة"
                                          : "${snapshot.data!.pointsCount} نقطة",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Color(0xff7B217E),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          snapshot.data!.pointsCount != 0
                              ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(

                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight
                                        ,
                                        child: Text(
                                          "الجوائز التي يمكنك دخول السحب عليها",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff7B217E)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  ),
                              )
                              : Text("")
                        ],
                      ):
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [


                            Text('لكي تتمكن من كسب النقاط والدخول في السحوبات سجل الان  ',  overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                            ),),
                            TextButton(onPressed: (){

                              Navigator.pushNamed(context, '/register_screen');
                            }, child: Text("كمستخدم",style: TextStyle(

                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                fontSize: 20.sp,
                                color: Color(0xff18499A)
                            ),)),

                          ],
                        ),
                      );
                    }

                    else if (snapshot.hasError) {
                      return  Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [


                            Text('لكي تتمكن من كسب النقاط والدخول في السحوبات سجل الان  ',  overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                            ),),
                            TextButton(onPressed: (){

                              Navigator.pushNamed(context, '/register_screen');
                            }, child: Text("كمستخدم",style: TextStyle(

                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                fontSize: 20.sp,
                                color: Color(0xff18499A)
                            ),)),

                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                    );
                  }),

              FutureBuilder<List<Awards>>(
                future: UserApiController().Awards_CanWin(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.purple,));
                  }
                  else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    award = snapshot.data ?? [];

                    return

                      ListView.builder(
                      itemCount: award.length,
                      shrinkWrap: true,
                      physics:ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 280.h,
                          width: 343.w,
                          margin: EdgeInsets.only(
                            bottom: 14.h,
                            right: 16.w,
                            left: 16.w
                          ),
                          decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  height: 188.h,
                                  width: 323.w,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                          image: NetworkImage(
                                              award[index].image.toString()))

                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 8.h, right: 8.w),
                                      height: 27.h,
                                      width: 58.w,
                                      decoration: BoxDecoration(
                                          color: Color(0xff18499A),
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Center(
                                          child: Text(
                                        "${award[index].pointsCount} نقطة",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     award[index].name.toString(),
                                     style: TextStyle(
                                         fontSize: 16.sp,
                                         fontWeight: FontWeight.w600),
                                   ),

                                   FutureBuilder<User?>(
                                       future: UserApiController().getProfile(),
                                       builder: (context, snapshot) {
                                         if (snapshot.connectionState == ConnectionState.waiting) {
                                           return Center();
                                         }
                                         else if (snapshot.hasData) {

                                           return   snapshot.data!.type =='user'?
                                           InkWell(
                                               onTap: (){
                                                 showModalBottomSheet(

                                                   context: context,

                                                   shape:  RoundedRectangleBorder( // <-- SEE HERE
                                                       borderRadius:  BorderRadius.only(
                                                         topRight: Radius.circular(15),
                                                         topLeft:  Radius.circular(15),
                                                       )
                                                   ),
                                                   builder: (context) {
                                                     return Container(

                                                         margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                                                         decoration: BoxDecoration(

                                                             borderRadius: BorderRadius.only(
                                                               topRight: Radius.circular(15),
                                                               topLeft:  Radius.circular(15),
                                                             )
                                                         ),
                                                         height: 520.h,
                                                         width: double.infinity,

                                                         alignment: Alignment.center,
                                                         child: ListView(
                                                           children: [
                                                             Row(
                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               children: [
                                                                 SizedBox(width: 30.w,),

                                                                 Text("الدخول في السحب",style: TextStyle(
                                                                     color: Color(0xff7B217E),
                                                                     fontSize: 18.sp,
                                                                     fontWeight: FontWeight.w600
                                                                 ),),

                                                                 IconButton(onPressed: (){
                                                                   Navigator.pop(context);
                                                                 }, icon: SvgPicture.asset("images/close.svg"),),

                                                               ],
                                                             ),
                                                             CircleAvatar(
                                                               radius: 66.sp,
                                                               backgroundImage:  snapshot.data!.imageProfile!=null?

                                                               NetworkImage(
                                                                 snapshot.data!.imageProfile!
                                                               ):null
                                                             ),
                                                             SizedBox(height: 22.h,),
                                                             FieldScreen(title: "اسم البريد الالكتروني",controller: emailTextController,),
                                                             SizedBox(height: 16.h,),
                                                             FieldScreen(title:"رقم الهاتف",controller: phoneTextController,),
                                                             SizedBox(height: 28.h,),
                                                             Container(
                                                               height: 91.h,
                                                               width: 343.w,
                                                               margin: EdgeInsets.symmetric(horizontal: 16.w),
                                                               decoration: BoxDecoration(
                                                                   color: Colors.purple.shade50,
                                                                   borderRadius: BorderRadius.circular(5)),
                                                               child: Container(
                                                                 margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                                                 child: Row(

                                                                   children: [
                                                                     Container(
                                                                       height: 71.h,
                                                                       width: 76.w,
                                                                       decoration: BoxDecoration(
                                                                           color: Colors.purple,
                                                                           borderRadius: BorderRadius.circular(5),
                                                                           image: DecorationImage(
                                                                               fit: BoxFit.cover,
                                                                               image: NetworkImage(
                                                                                   award[index].image.toString()))),
                                                                     ),
                                                                     SizedBox(width: 16.w,),
                                                                     Column(
                                                                       children: [
                                                                         Text(award[index].name.toString(),style: TextStyle(
                                                                             fontSize: 16.sp,
                                                                             fontWeight: FontWeight.w500
                                                                         ),),
                                                                         Container(
                                                                           margin:
                                                                           EdgeInsets.only(top: 8.h, right: 8.w),
                                                                           height: 27.h,
                                                                           width: 58.w,
                                                                           decoration: BoxDecoration(
                                                                               color: Color(0xff18499A),
                                                                               borderRadius:
                                                                               BorderRadius.circular(14)),
                                                                           child: Center(
                                                                               child: Text(
                                                                                 "${award[index].pointsCount} نقطة",
                                                                                 style: TextStyle(
                                                                                     color: Colors.white,
                                                                                     fontWeight: FontWeight.w600,
                                                                                     fontSize: 10.sp),
                                                                               )),
                                                                         ),
                                                                       ],
                                                                     )
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                             SizedBox(height: 28.h,),
                                                             ElevatedButton  (
                                                               onPressed: () async {

                                                                 await Award_Request(award_id: award[index].id.toString());

                                                               },
                                                               child:
                                                               Text('تأكيد الدخول في السحب',style: TextStyle(
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
                                                         )
                                                     );
                                                   },
                                                 );
                                               },
                                               child:   award[index].isRequested==1||close?
                                               SvgPicture.asset(
                                                 "images/true_play.svg"

                                                 ,fit: BoxFit.scaleDown,):

                                               SvgPicture.asset(
                                                 "images/play.svg"

                                                 ,fit: BoxFit.scaleDown,)




                                           ):
                                           Text("");
                                         }

                                         else if (snapshot.hasError) {
                                           return Text('');
                                         }
                                         return Center(
                                           child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                                         );
                                       }),



                                 ],
                               )


                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }



                  else {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 80.h,),

                            Text('كي تتمكن من الاستفادة من خدامتنا سجل الان ',  overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                            ),),
                            SizedBox(height: 180.h,),
                            ElevatedButton(
                              onPressed: ()  {
                                Navigator.pushNamed(context, '/register_screen');
                              },
                              child:  Text('أنشأ حساب الان ',style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp
                              ),),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff7B217E),

                                minimumSize: Size(double.infinity, 50.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );


                  }
                },
              )
            ],
          ),
        )



    );
  }


  Future Award_Request({required String award_id }) async {

    bool loggedIn = await UserApiController().
    AwardRequest
      (context,
        mobile: phoneTextController.text,
        email: emailTextController.text,
        award_id: award_id

    );



    if (loggedIn) {
      setState(() {
        close=true;
        Navigator.pop(context);
      });

      showModalBottomSheet(

        context: context,
        shape:  RoundedRectangleBorder( // <-- SEE HERE
          borderRadius:  BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft:  Radius.circular(15),
          )
        ),

        builder: (context) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft:  Radius.circular(15),
                  )
              ),
              height: 520.h,
              width: double.infinity,

              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 40.h,),
                  Text("تم الدخول في السحب بنجاح",style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 40.h,),

                  SvgPicture.asset("images/successads.svg"),
                  Spacer(),

                  ElevatedButton  (
                    onPressed: ()  {
                          Navigator.pop(context);

                    },
                    child:
                    Text('عودة الى الجوائز',style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff7B217E),

                      minimumSize: Size(double.infinity, 50.h),
                    ),
                  ),

                ],
              )
          );
        },
      );

      phoneTextController.clear();
      emailTextController.clear();


    }else{


      phoneTextController.clear();
      emailTextController.clear();
    }
  }
}

