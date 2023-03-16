
import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_boulevard/screens/homescreen/widget/ImageRotater.dart';
import 'package:new_boulevard/utils/helpers.dart';
import '../../loed/loed.dart';
import '../../models/BestOffers.dart';
import '../../models/notification.dart';
import '../../models/setting.dart';
import '../../story/ListStory.dart';
import '../../story/OneStory.dart';
import '../../Shared_Preferences/User_Preferences.dart';
import '../../api/User_Controller.dart';
import '../../component/main_bac.dart';
import '../../models/Follower_user.dart';
import '../../models/categories.dart';
import '../../models/detalies.dart';
import '../../models/special_ads.dart';

import '../PARTBar/detalies.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers{
  List<MyFollowings> _folow = [];
  List<MyFollowings> test = [];
  List<SpecialAds> _special_ads = [];
  List<Categories> _categories = [];
  List<Ads> BestAds = [];
  List<Ads> offerad = [];
    List<Banners> banners= [];
    List<notification> massages= [];
    List<Offers> offer= [];
   bool isDone=false;

  @override
  void initState() {
    // TODO: implement initState
 UserApiController().HSpecialAds().then((value) {
   setState(() {
     _special_ads=value;
   });
 });
 UserApiController().getCategories().then((value) {

   setState(() {
     _categories=value;
   });

 });
 UserApiController().getBestTenAds().then((value) {
   setState(() {
     BestAds=value;
   });
 });
 UserApiController().getBestAds().then((value) {
   setState(() {
     offer=value;
   });
 });
 UserApiController().getbaner().then((value) {
   setState(() {
     banners=value;
     isDone=true;
   });
 });
 UserPreferences().user.type=="user"?
 UserApiController().Followers_User().then((value) {
   setState(() {
     _folow=value;

   });
 }):
 null;






  }

  @override
  Widget build(BuildContext context) {
    return Back_Ground(
     childTab: "الرئيسية",
      ad: true,
      child:
      isDone==false?
      LoedWidget():

      RefreshIndicator(
        color: Colors.purple,
        onRefresh: () async {
          loeddata();
          setState(() {

          });
          await Future.delayed(Duration(milliseconds: 1500));
          await UserApiController().Notifications().then((value) {
            setState(() {
              massages=value;
            });
          });

          if(massages.isNotEmpty){
            for(int i=0;i<massages.length;i++){
              Flushbar(

                messageText: Text(massages[i].message.toString(),style: TextStyle(
                    color: Colors.white
                ),),
                padding: EdgeInsets.all(20),
                backgroundGradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  colors: [
                    Color(0xff7B217E),
                    Color(0xff7B217E),
                    Color(0xff18499A),
                  ],
                ),


                borderRadius: BorderRadius.circular(8),

                icon: Icon(
                  Icons.notifications_on_outlined,
                  color: Colors.white,
                ),

                duration: Duration(seconds: 3),
                margin: EdgeInsets.only(
                    top: 100.h,
                    right: 10.w,
                    left: 10.w
                ),
                flushbarPosition: FlushbarPosition.TOP,
                leftBarIndicatorColor: Colors.white,
              )..show(context);

              await Future.delayed(Duration(seconds: 3));
            }
          }



        },
        child:     Container(

          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: ListView(
            children: [


              banners.isNotEmpty?
              SizedBox(
                  height: 150.h,
                  child: CasualImageSlider( imageUrls: banners)):
              SizedBox.shrink(),



              SizedBox(height: 16.h,),
              _folow.isNotEmpty?
              SizedBox(
                  height: 110.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _folow.length,
                    itemBuilder: (context, index) {

                      return    InkWell(
                        onTap: (){
                          int i=index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListStoryScreen(PageFollowing:_folow,initialindex: index,)
                              )

                          );
                        },
                        child: Column(

                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 12.w
                              ),
                              decoration: BoxDecoration(

                                shape: BoxShape.circle,

                                gradient: LinearGradient(
                                  begin: AlignmentDirectional.centerStart,
                                  end: AlignmentDirectional.centerEnd,
                                  colors: [
                                    Color(0xff7B217E),
                                    Color(0xff7B217E),
                                    Color(0xff18499A),
                                  ],

                                ),

                              ),
                              child: Container(
                                margin: EdgeInsets.all(3),

                                child: CircleAvatar(
                                    radius:38.sp,
                                    onForegroundImageError: (exception, stackTrace) {
                                      // handle error here
                                      print('Error loading image: $exception');
                                    },

                                    backgroundImage:_folow[index].imageProfile!=null?

                                    NetworkImage(

                                        _folow[index].imageProfile!

                                    ) :null


                                ),
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 12.w
                              ),
                              child: Text(_folow[index].name.toString(),style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600
                              ),),
                            )
                          ],
                        ),
                      ) ;



                    },
                  )
              ):

              SizedBox.shrink(),












              _special_ads.isNotEmpty?
              Row(

                children: [
                  Text("الإعلانات المميزة",style: TextStyle(
                      color:  Color(0xff7B217E),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp
                  ),),
                  SizedBox(width: 8.w,),
                  Icon(Icons.star_rounded,color: Color(0xff7B217E),size: 30.sp,),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/SpeciaScreen');
                    },
                    child: Text("عرض الجميع",style: TextStyle(
                        color:  Color(0xffC4C4C4),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp
                    ),),
                  ),






                ],
              ):
              SizedBox.shrink(),

            SizedBox(height: 16.h,),

              _special_ads.isNotEmpty?
              SizedBox(
                height: 220.h,
                width: 300.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _special_ads.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StoryPage(
                                    AdId:_special_ads[index].id!,

                                  )
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 12.w
                        ),
                        height: 220.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_special_ads[index].image.toString())
                            )
                        ),

                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(onPressed: (){}, icon:  Icon(Icons.star_rounded,color: Color(0xffFFCC46),size: 25.sp,),),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 10.h,
                                  right: 5.w
                              ),
                              alignment: Alignment.bottomRight,
                              child:Row(

                                children: [
                                  _special_ads[index].advertiser!.imageProfile!=null?
                                  CircleAvatar(radius: 14, backgroundImage: NetworkImage(

                                      _special_ads[index].advertiser!.imageProfile.toString()),):
                                  CircleAvatar(radius: 12.sp,
                                      backgroundColor: Color(0xff7B217E),
                                      child: Icon(Icons.person_rounded,color: Colors.white,
                                        size: 15.sp,)),
                                  SizedBox(width: 10.w,),
                                  Text(



                                    _special_ads[index].advertiser!.name!,style: TextStyle(
                                      color:  Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10.sp
                                  ),),


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ):
              SizedBox.shrink(),

              SizedBox(height: 16.h,),



              _categories.isNotEmpty?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الأقسام",style: TextStyle(
                      color:  Color(0xff7B217E),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp
                  ),),

                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/PartScreen');
                    },

                    child: Text("عرض الجميع",style: TextStyle(
                        color:  Color(0xffC4C4C4),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp
                    ),),
                  ),






                ],
              ):
              SizedBox.shrink(),
              SizedBox(height: 16.h,),
              _categories.isNotEmpty?
              SizedBox(
                height: 230.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(

                                builder: (context) => DetailesScreen(name:_categories[index].name.toString(),idcat:_categories[index].id! ,)
                            ),



                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 130.w,
                              height: 190.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300]!,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(_categories[index].image.toString())
                                  )
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Center(
                              child:  Text(_categories[index].name.toString(),style: TextStyle(
                                color:  Color(0xff7B217E),
                                fontWeight: FontWeight.normal,


                                // fontSize: 18.sp
                              ),) ,
                            )
                          ],
                        )
                    );
                  },
                  separatorBuilder:(BuildContext, index){
                    return  SizedBox(width: 10.w,);
                  },
                ),
              ):
                  SizedBox.shrink(),

              BestAds.isNotEmpty?

              Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(

                  children: [
                    Text(" أفضل إعلانات الشهر  ",style: TextStyle(
                        color:  Color(0xff7B217E),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    ),),







                  ],
                ),
              ):
              SizedBox.shrink(),


              BestAds.isNotEmpty?
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: BestAds.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StoryPage(
                                    AdId:BestAds[index].id!,

                                  )
                          ),



                        );

                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 12.w
                        ),
                        width: 130.w,
                        //height: 190.h,
                        decoration: BoxDecoration(
                            color:  Colors.grey[300]!,
                            borderRadius: BorderRadius.circular(5),

                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    BestAds[index].image.toString())
                            )
                        ),

                        child: Stack(
                          children: [

                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 10.h,
                                  right: 5.w
                              ),
                              alignment: Alignment.bottomRight,
                              child:Row(

                                children: [
                                  BestAds[index].advertiser!.imageProfile!=null?

                                  CircleAvatar(radius: 14,
                                    backgroundImage: NetworkImage(

                                        BestAds[index].advertiser!.imageProfile!.toString()),):
                                  CircleAvatar(radius: 12.sp,
                                      backgroundColor: Color(0xff7B217E),
                                      child: Icon(Icons.person_rounded,color: Colors.white,
                                        size: 15.sp,)),
                                  SizedBox(width: 10.w,),
                                  Text(



                                    BestAds[index].advertiser!.name!,style: TextStyle(
                                      color:  Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10.sp
                                  ),),


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ):
              SizedBox.shrink(),




              SizedBox(height: 16.h,),

              offer.isNotEmpty?
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                itemCount: offer.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(offer[index].name.toString(),style: TextStyle(
                              color:  Color(0xff7B217E),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp
                          ),),
                        ],
                      ),
                      SizedBox(height: 16.h,),

                      SizedBox(
                        height: 200.h,

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: offer[index].ads!.length,
                          itemBuilder: (context, index) {
                            offerad=offer[index].ads!;
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StoryPage(
                                            AdId:offerad[index].id!,

                                          )
                                  ),



                                );


                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 12.w
                                ),
                                width: 130.w,
                                //height: 80.h,
                                decoration: BoxDecoration(
                                    color:  Colors.grey[300]!,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            offerad[index].image.toString())
                                    )
                                ),

                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(onPressed: (){}, icon:  Icon(Icons.star_rounded,color: Color(0xffFFCC46),size: 25.sp,),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.h,
                                          right: 5.w
                                      ),
                                      alignment: Alignment.bottomRight,
                                      child:Row(

                                        children: [
                                          offerad[index].advertiser!.imageProfile!=null?
                                          CircleAvatar(radius: 14, backgroundImage: NetworkImage(

                                              offerad[index].advertiser!.imageProfile.toString()),):
                                          CircleAvatar(radius: 12.sp,
                                              backgroundColor: Color(0xff7B217E),
                                              child: Icon(Icons.person_rounded,color: Colors.white,
                                                size: 15.sp,)),
                                          SizedBox(width: 10.w,),
                                          Text(



                                            offerad[index].advertiser!.name!,style: TextStyle(
                                              color:  Color(0xffFFFFFF),
                                              fontWeight: FontWeight.w900,
                                              fontSize: 10.sp
                                          ),),


                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.h,),
                    ],
                  );



                },
              ):
                  SizedBox.shrink()










            ],
          ),
        ),

      )






    );
  }

  loeddata ()async{
  await  UserApiController().HSpecialAds().then((value) {
      setState(() {
        _special_ads=value;
      });
    });
  await UserApiController().getCategories().then((value) {

      setState(() {
        _categories=value;
      });

    });
  await UserApiController().getBestTenAds().then((value) {
      BestAds=value;
      setState(() {
        BestAds=value;
      });
    });
  await UserApiController().getBestAds().then((value) {
      offer=value;
      setState(() {
        offer=value;
      });
    });
  await UserApiController().getbaner().then((value) {
    setState(() {
      banners=value;
    });
  });
  UserPreferences().user.type=="user"?
  await UserApiController().Followers_User().then((value) {
    setState(() {
      _folow=value;
    });
  }):
  null;
  }


}