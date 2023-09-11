import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_boulevard/api/User_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../loed/loed.dart';
import '../../../provider/app_provider.dart';
import '../../../story/OneStory.dart';
import '../../../Shared_Preferences/User_Preferences.dart';
import '../../../component/main_bac.dart';

import '../ProfileWidgt/allFollower.dart';



class UserShowAdmain extends StatefulWidget {
  int id;


  UserShowAdmain({required this.id,});

  @override
  State<UserShowAdmain> createState() => _UserShowAdmainState();
}

class _UserShowAdmainState extends State<UserShowAdmain> {
  @override



  @override
  Widget build(BuildContext context) {

    Provider.of<AppProvider>(context, listen: false).getInfoAdmain(widget.id);
 //   Provider.of<AppProvider>(context, listen: false).getUserFolow(widget.id);
    Provider.of<AppProvider>(context, listen: false).getAllADS_AdmainForUser(id: widget.id);
    return Consumer<AppProvider>(builder: (context, provider, _) {
    return
      provider.advertiser==null?
      LoedWidget():
      Back_Ground(
        Bar: true,
        back: true,
        eror: true,
        EditAdmain: true,
        childTab: provider.advertiser!.name.toString(),
        child:
        DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    CircleAvatar(
                        radius: 44.sp,
                        backgroundColor: Colors.purple,
                        backgroundImage: provider.advertiser!.imageProfile !=
                            null
                            ? NetworkImage(provider.advertiser!.imageProfile!)
                            : null),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      provider.advertiser!.name.toString(),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllFollower(
                                    id:provider.advertiser!.id!,
                                  )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 38.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xff969696),
                                  borderRadius:
                                  BorderRadius.circular(37)),
                              child: Center(
                                child: Text(
                                  " ${provider.advertiser!.followMeCount} متابع",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 35.w,
                            ),
                            UserPreferences().user.type == "user"
                                ?
                           provider.statusFollow=="إلغاء متابعة"
                                ? InkWell(
                              onTap: () async {
                                await provider.unfollow(widget.id);
                              },
                              child: Container(
                                height: 38.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        37),
                                    color: const Color(
                                        0xff18499A)),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      provider. staus?
                                  LoadingAnimationWidget.staggeredDotsWave(
                                      color:Colors.white, size: 20.sp
                                ):
                                      Text(
                                        provider.statusFollow,
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontSize:
                                            14.sp,
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                                : InkWell(
                              onTap: () async {
                                await provider.follow(widget.id);
                              },
                              child: Container(
                                height: 38.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        37),
                                    color: const Color(
                                        0xff18499A)),
                                child: Container(
                                  margin: EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      provider.staus?
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color:Colors.white, size: 20.sp
                                      ):

                                      Text(
                                        provider.statusFollow,
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontSize:
                                            14.sp,
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                                : const SizedBox.shrink()
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(5)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: const Color(0xff7B217E),
                      borderRadius: BorderRadius.circular(5)),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xff7B217E),
                  indicatorSize: TabBarIndicatorSize.tab,

                  tabs: const [
                    Tab(
                      text: "تواصل معنا",
                    ),
                    Tab(
                      text: "الإعلانات",
                    ),
                  ],
                ),
              ),

              Expanded(
                  child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 343.w,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.purple.shade50,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async{


                                          launchUrl(Uri.parse(
                                              "whatsapp://send?phone=${provider.advertiser!.whatsapp}&text=${"Hi"}"));

                                        },
                                        child: Detatlies(
                                            name: provider.advertiser!.mobile.toString()
                                                .toString(),
                                            image: "images/phone.svg"),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launch(
                                              "mailto:${provider.advertiser!.email}");
                                        },
                                        child: Detatlies(
                                            name: provider.advertiser!.email.toString(),
                                            image: "images/gmail.svg"),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      provider.advertiser!.website != null
                                          ? Detatlies(
                                          name: provider.advertiser!.website.toString(),
                                          image: "images/earth.svg")
                                          : const Text(""),
                                      SizedBox(
                                        height: 26.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [

                                          provider.advertiser!.twitter !=
                                              null
                                              ? InkWell(
                                            onTap: () {
                                              launch(provider.advertiser!
                                                  .twitter!);
                                            },
                                            child: SvgPicture
                                                .asset(
                                                "images/twitter.svg"),
                                          )
                                              : const Text(""),
                                          SizedBox(
                                            width: 26.w,
                                          ),
                                          provider.advertiser!.instagram != null
                                              ? InkWell(
                                            onTap: () {
                                              launch(provider.advertiser!.instagram.toString());
                                            },
                                            child:SvgPicture
                                                .asset(
                                                "images/instegram.svg"),
                                          )
                                              : const Text(""),
                                          SizedBox(
                                            width: 26.w,
                                          ),
                                          provider.advertiser!.whatsapp != null
                                              ? InkWell(
                                            onTap: () async{

                                              launchUrl(Uri.parse(
                                                  "whatsapp://send?phone=${provider.advertiser!.whatsapp}&text=${"Hi"}"));

                                            },
                                            child: SvgPicture.asset(
                                                "images/whatsapp.svg"),
                                          )
                                              : const Text(""),
                                          SizedBox(
                                            width: 26.w,
                                          ),
                                          provider.advertiser!.facebook != null
                                              ? InkWell(
                                            onTap: () {
                                              launch(provider.advertiser!.facebook.toString());
                                            },
                                            child: SvgPicture.asset(
                                                "images/facebook.svg"),
                                          )
                                              : const Text(""),
                                          SizedBox(
                                            width: 26.w,
                                          ),
                                          provider.advertiser!.website != null
                                              ? InkWell(
                                            onTap: () {
                                              launch(provider.advertiser!.website.toString());
                                            },
                                            child: SvgPicture.asset(
                                              "images/earth.svg",
                                              height: 20.h,
                                            ),
                                          )
                                              : const Text(""),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 26.h,
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                        provider.AdmainAd.isEmpty?
                        Column(
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            SizedBox(
                                height: 150.h,
                                width: 150.w,
                                child: SvgPicture.asset(
                                    "images/ads.svg")),
                            SizedBox(
                              height: 50.h,
                            ),
                            Text(
                              "لا يوجد اعلانات في الوقت الحالي",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            )
                          ],
                        ):
                        SingleChildScrollView(
                          child: SizedBox(
                            width: 350.w,
                            child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: provider.AdmainAd.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                    165.w / 170.h,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 14.h),
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (BuildContext, index) {
                                  return provider.AdmainAd[index].adType!.type ==
                                      "special"
                                      ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                storyPageScreen(
                                                  AdId: provider.AdmainAd[
                                                  index]
                                                      .id!,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 5.w,
                                          left: 5.w),
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xff7B217E),
                                          borderRadius:
                                          BorderRadius
                                              .circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  provider.AdmainAd[index]
                                                      .image!
                                                      .toString()))),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment
                                                .topLeft,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons
                                                    .star_rounded,
                                                color: const Color(
                                                    0xffFFCC46),
                                                size: 25.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                storyPageScreen(
                                                  AdId: provider.AdmainAd[
                                                  index]
                                                      .id!,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                      EdgeInsets.symmetric(
                                          horizontal: 5.w),
                                      width: 165.w,
                                      height: 170.h,
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xff7B217E),
                                          borderRadius:
                                          BorderRadius
                                              .circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  provider.AdmainAd[index]
                                                      .image
                                                      .toString()))),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ]))
            ],
          ),
        ));

    });



  }

  Widget Detatlies({required String name, required String image}) {
    return Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(
          width: 10.w,
        ),
        Directionality(
           textDirection: TextDirection.ltr,
          child: Text(
            name,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}