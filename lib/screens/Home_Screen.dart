import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../ListStory.dart';
import '../OneStory.dart';
import '../Shared_Preferences/User_Preferences.dart';
import '../api/User_Controller.dart';
import '../component/main_bac.dart';

import '../models/Follower_user.dart';
import '../models/categories.dart';
import '../models/detalies.dart';
import '../models/special_ads.dart';
import '../models/user.dart';
import 'PARTBar/detalies.dart';
import 'maps/mapscreen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MyFollowings> _folow = [];
  List<MyFollowings> test = [];
  List<SpecialAds> _special_ads = [];
  List<Categories> _categories = [];
  List<Ads> BestAds = [];
  var result;


  @override
  void initState() {
    // TODO: implement initState
 UserApiController().HSpecialAds().then((value) => _special_ads=value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Back_Ground(
     childTab: "الرئيسية",
      ad: true,
      child: RefreshIndicator(


        color: Colors.purple,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1500));
          setState(() {

          });
        },
        child:     Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: ListView(
            children: [








              FutureBuilder<User?>(
                  future: UserApiController().getProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return  snapshot.data!.type != "advertiser"&&UserPreferences().isLoggedIn?
                      FutureBuilder<List<MyFollowings>>(
                        future: UserApiController().Followers_User(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center();
                          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            _folow = snapshot.data ?? [];

                            return SizedBox(
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
                                                    AdDetalies(SelectPage:_folow,pageindex: index,)
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
                            );
                          } else if(snapshot.data!.isEmpty){
                            return  SizedBox.shrink();
                          } else {
                            return Center(
                              child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                            );
                          }
                        },
                      )
                          :  SizedBox.shrink();
                    }
                    return  SizedBox.shrink();
                  }),




            FutureBuilder<List<SpecialAds>>(
                future: UserApiController().HSpecialAds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center();
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    _special_ads = snapshot.data ?? [];



                    return  Row(

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
                    );
                  }




                  else {
                    return SizedBox.shrink();
                  }
                },
              ),

            SizedBox(height: 16.h,),

              FutureBuilder<List<SpecialAds>>(
                future: UserApiController().HSpecialAds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center();
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    _special_ads = snapshot.data ?? [];

                    return SizedBox(
                      height: 166.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _special_ads.length,
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
                              width: 130.w,
                              decoration: BoxDecoration(
                                  color:   Color(0xff7B217E),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          _special_ads[index].image.toString())
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

                                        CircleAvatar(radius: 14,
                                          backgroundImage: NetworkImage(

                                              _special_ads[index].advertiser!.imageProfile.toString()),),
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
                    );
                  }




                  else {
                    return SizedBox.shrink();
                  }
                },
              ),

              SizedBox(height: 16.h,),









              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("الأقسام",style: TextStyle(
                      color:  Color(0xff7B217E),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp
                  ),),
                  SizedBox(width: 8.w,),
                  SvgPicture.asset("images/categorypart.svg",color: Color(0xff7B217E) ,),
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
              ),
              SizedBox(height: 16.h,),
              FutureBuilder<List<Categories>>(
                future: UserApiController().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center();
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    _categories = snapshot.data ?? [];
                    return   GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 8,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 165.w / 98.h,
                            crossAxisCount: 2,
                            crossAxisSpacing: 13.w,
                            mainAxisSpacing: 14.h

                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext, index){
                          return  InkWell(
                            onTap: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(

                                    builder: (context) => DetailesScreen(name:_categories[index].name.toString(),idcat:_categories[index].id! ,)
                                ),



                              );
                            },
                            child: Container(
                                width: 165.w,
                                height: 98.h,
                                decoration: BoxDecoration(
                                    color:   Color(0xff7B217E),
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(_categories[index].image.toString())
                                    )
                                ),

                                child: Center(
                                  child:  Text(_categories[index].name.toString(),style: TextStyle(
                                      color:  Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp
                                  ),) ,
                                )
                            ),
                          );
                        }


                    );
                  } else {
                    return Center(
                      child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                    );
                  }
                },
              ),


                FutureBuilder<List<Ads>>(
                future: UserApiController().getBestTenAds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center();
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    BestAds = snapshot.data ?? [];

                    return   Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(

                        children: [
                          Text(" أفضل إعلانات الشهر  ",style: TextStyle(
                              color:  Color(0xff7B217E),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp
                          ),),
                          SizedBox(width: 8.w,),
                          Icon(Icons.stacked_line_chart,color: Color(0xff7B217E),size: 30.sp,),







                        ],
                      ),
                    );
                  }



                  else {
                    return SizedBox.shrink();
                  }
                },
              ),
                 FutureBuilder<List<Ads>>(
                   future: UserApiController().getBestTenAds(),
                   builder: (context, snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return Center(child: CircularProgressIndicator(color: Colors.purple,));
                     } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                       BestAds = snapshot.data ?? [];

                       return SizedBox(
                         height: 166.h,
                         child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           itemCount: BestAds.length,
                           itemBuilder: (context, index) {
                             return InkWell(
                               onTap: (){

                                 // Navigator.push(
                                 //   context,
                                 //   MaterialPageRoute(
                                 //       builder: (context) =>
                                 //           StoryPage1(
                                 //             data:BestAds[index].id!,
                                 //
                                 //           )
                                 //   ),
                                 //
                                 //
                                 //
                                 // );

                               },
                               child: Container(
                                 margin: EdgeInsets.only(
                                     left: 12.w
                                 ),
                                 width: 130.w,
                                 decoration: BoxDecoration(
                                     color:   Color(0xff7B217E),
                                     borderRadius: BorderRadius.circular(5),
                                     image: DecorationImage(
                                         fit: BoxFit.cover,
                                         image: NetworkImage(
                                             BestAds[index].image.toString())
                                     )
                                 ),

                                 child: Stack(
                                   children: [
                                     Align(
                                       alignment: Alignment.topLeft,
                                       child: IconButton(onPressed: (){}, icon:  Icon(Icons.stacked_line_chart,color: Color(0xffFFCC46),size: 25.sp,),),
                                     ),
                                     Container(
                                       margin: EdgeInsets.only(
                                           bottom: 10.h,
                                           right: 5.w
                                       ),
                                       alignment: Alignment.bottomRight,
                                       child:Row(

                                         children: [

                                           CircleAvatar(radius: 14,
                                             backgroundImage: NetworkImage(

                                                 BestAds[index].advertiser!.imageProfile!.toString()),),
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
                       );
                     }



                     else {
                       return SizedBox.shrink();
                     }
                   },
                 ),







            ],
          ),
        ),

      )






    );
  }


}