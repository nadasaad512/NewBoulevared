import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Shared_Preferences/User_Preferences.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/main_bac.dart';
import '../../loed/loed.dart';
import '../../provider/app_provider.dart';

class AwardScreen extends StatefulWidget {
  @override
  State<AwardScreen> createState() => _AwardScreenState();
}

class _AwardScreenState extends State<AwardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getProfile();
    Provider.of<AppProvider>(context, listen: false).getAllAward();
  }
  @override
  Widget build(BuildContext context) {
    return Back_Ground(
        Bar: true,
        ad: true,
        childTab: "الجوائز    ",
        child:
        Consumer<AppProvider>(builder: (context, provider, _) {
        return


          ListView(
          children: [

            provider.user!=null&& provider.user!.type =='user'?
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
                        provider.user!.pointsCount == null
                            ? "0 نقطة"
                            : "${provider.user!.pointsCount} نقطة",
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
            provider.user!.pointsCount != 0
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

              Text('لتتمكن من كسب النقاط والدخول في السحوبات   ',  overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
              ),),
              TextButton(onPressed: (){

                Navigator.pushNamed(context, '/register_screen');
              }, child: Text("سجل الان",style: TextStyle(

                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  fontSize: 20.sp,
                  color: Color(0xff18499A)
              ),)),

            ],
          ),
        ),

            provider.award==null?
            LoedWidget():
            provider.award!.isEmpty?
            Center(child: Text("لا يوجد جوائز لعرضها ",style: TextStyle(
              fontSize: 20.sp
            ),)):
            ListView.builder(
              itemCount: provider.award!.length,
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

                        CachedNetworkImage(
                          imageUrl:provider. award![index].image.toString(),
                          imageBuilder: (context, imageProvider) =>   Container(
                            margin: EdgeInsets.only(
                              top: 10.h,
                            ),
                            height: 188.h,
                            width: 323.w,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]!,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:imageProvider)

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
                                      "${provider.award![index].pointsCount} نقطة",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp),
                                    )),
                              ),
                            ),
                          ),),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.award![index].name.toString(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),

                            provider.user==null?
                            SizedBox.shrink():
                            provider.user!.type =="user"?
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
                                              provider.user!.imageProfile!=null?
                                              CircleAvatar(
                                                  radius: 66.sp,
                                                  backgroundImage:

                                                  NetworkImage(
                                                      provider.user!.imageProfile!
                                                  )
                                              ):
                                              CircleAvatar(radius:66.sp,
                                                  backgroundColor: Color(0xff7B217E),
                                                  child: Icon(Icons.person_rounded,color: Colors.white,
                                                    size: 50.sp,)),
                                              SizedBox(height: 22.h,),
                                              FieldScreen(title: "اسم البريد الالكتروني",controller:provider. emailTextController,),
                                              SizedBox(height: 16.h,),
                                              FieldScreen(title:"رقم الهاتف",controller:provider. phoneTextController,),
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
                                                                    provider.award![index].image.toString()))),
                                                      ),
                                                      SizedBox(width: 16.w,),
                                                      Column(
                                                        children: [
                                                          Text(provider.award![index].name.toString(),style: TextStyle(
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
                                                                  "${provider.award![index].pointsCount} نقطة",
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

                                                  await Award_Request(context,provider ,award_id: provider.award![index].id.toString());

                                                },
                                                child:
                                                Text('تأكيد الدخول في السحب',style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18.sp,
                                                  color: Colors.white
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
                                child:  provider. award![index].isRequested==1||provider.close?
                                SvgPicture.asset(
                                  "images/true_play.svg"

                                  ,fit: BoxFit.scaleDown,):

                                SvgPicture.asset(
                                  "images/play.svg"

                                  ,fit: BoxFit.scaleDown,)




                            ):
                            SizedBox.shrink()





                          ],
                        )


                      ],
                    ),
                  ),
                );
              },
            )


          ],
        );
        })



    );
  }

  Future Award_Request(BuildContext context,AppProvider provider,{required String award_id }) async {

    bool loggedIn = await UserApiController().
    AwardRequest(context, mobile: provider.phoneTextController.text, email: provider.emailTextController.text,
        award_id: award_id

    );
    if (loggedIn) {
      provider.close=true;
      Navigator.pop(context);

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
                        fontSize: 18.sp,
                        color: Colors.white
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

      provider. phoneTextController.clear();
      provider. emailTextController.clear();


    }else{


      provider. phoneTextController.clear();
      provider. emailTextController.clear();
    }
  }
}

