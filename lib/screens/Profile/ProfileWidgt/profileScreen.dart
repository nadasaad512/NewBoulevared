import 'package:new_boulevard/api/User_Controller.dart';
import 'package:new_boulevard/utils/helpers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../story/OneStory.dart';
import '../../../Shared_Preferences/User_Preferences.dart';
import '../../../component/main_bac.dart';

import '../../../models/Follower_user.dart';
import '../../../models/ads.dart';
import '../../../models/user.dart';
import '../../allAds/new_ads.dart';
import 'allFollower.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  bool progss = false;
  bool progss1 = false;

  List<AdvertiserADs> _ads = [];
  User? user;

  List<MyFollowings> _folow = [];
  var count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: UserApiController().getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ));
          } else if (snapshot.hasData) {
            user = snapshot.data;
            return snapshot.data!.type == "advertiser"
                ? Back_Ground(
                Bar: true,
                edit: true,
                EditAdmain: true,
                childTab: snapshot.data!.name,
                child: DefaultTabController(
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
                                backgroundImage:
                                snapshot.data!.imageProfile != null
                                    ? NetworkImage(
                                    snapshot.data!.imageProfile!)
                                    : null),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                              snapshot.data!.name,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
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
                                          id: snapshot.data!.id,
                                        )));
                              },
                              child: Container(
                                height: 38.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    color: Color(0xff969696),
                                    borderRadius:
                                    BorderRadius.circular(37)),
                                child: Center(
                                  child: Text(
                                    " ${snapshot.data!.followMeCount} متابع",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
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
                              color: Color(0xff7B217E),
                              borderRadius: BorderRadius.circular(5)),
                          labelColor: Colors.white,
                          unselectedLabelColor: Color(0xff7B217E),
                          tabs: [
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
                            //controller: tabController,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        width: 343.w,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: Colors.purple.shade50,
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 20.h),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "whatsapp://send?phone=${snapshot.data!.mobile}&text=${"Hi"}");
                                                },
                                                child: Detatlies(
                                                    name: snapshot.data!.mobile,
                                                    image: "images/phone.svg"),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "mailto:${snapshot.data!.email}");
                                                },
                                                child: Detatlies(
                                                    name: snapshot.data!.email,
                                                    image: "images/gmail.svg"),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              snapshot.data!.website != null
                                                  ? InkWell(
                                                onTap: () {
                                                  launch(snapshot
                                                      .data!.website!);
                                                },
                                                child: Detatlies(
                                                    name: snapshot
                                                        .data!.website!,
                                                    image:
                                                    "images/earth.svg"),
                                              )
                                                  : Text(""),
                                              SizedBox(
                                                height: 26.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  snapshot.data!.twitter != null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!
                                                          .twitter!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/twitter.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.instagram !=
                                                      null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!
                                                          .instagram!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/instegram.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.whatsapp !=
                                                      null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!
                                                          .whatsapp!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/whatsapp.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.facebook !=
                                                      null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!
                                                          .facebook!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/facebook.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.website != null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!
                                                          .website!);
                                                    },
                                                    child:
                                                    SvgPicture.asset(
                                                      "images/earth.svg",
                                                      height: 20.h,
                                                    ),
                                                  )
                                                      : Text(""),
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
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/NewAdsScreen');
                                            },
                                            child: Container(
                                              width: 170.w,
                                              height: 170.h,
                                              margin: EdgeInsets.only(
                                                  left: 5.w,
                                                  right: 5.w,
                                                  top: 5.h
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff7B217E),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                      NetworkImage(""))),
                                              child: Center(
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: 20.h),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/NewAdsScreen');
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .add_circle_rounded,
                                                              color: Colors.white,
                                                              size: 60.sp,
                                                            )),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text(
                                                          "إضافة إعلان",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 16.sp,
                                                              color:
                                                              Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          FutureBuilder<List<AdvertiserADs>>(
                                            future: UserApiController()
                                                .ADS_Admain(
                                                userid:
                                                snapshot.data!.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                );
                                              }
                                              else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                _ads = snapshot.data ?? [];

                                                return _ads[0].adType!.type ==
                                                    "special"
                                                    ?

                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StoryPage(
                                                                AdId:_ads[0].id!,

                                                              )
                                                      ),



                                                    );
                                                  },
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.only(
                                                        top: 5.h,
                                                        right: 5.w,
                                                        left: 5.w),
                                                    width: 170.w,
                                                    height: 170.h,
                                                    decoration: BoxDecoration(
                                                        color: Color(
                                                            0xff7B217E),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5),
                                                        image: DecorationImage(
                                                            fit: BoxFit
                                                                .cover,
                                                            image: NetworkImage(
                                                                _ads[0]
                                                                    .image
                                                                    .toString()))),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: 10
                                                                  .w,
                                                              top: 10
                                                                  .h),
                                                          child: Align(
                                                              alignment:
                                                              Alignment
                                                                  .topLeft,
                                                              child:
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                Color(
                                                                    0xff7B217E),
                                                                radius:
                                                                14.sp,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      showModalBottomSheet(
                                                                        context: context,
                                                                        shape: RoundedRectangleBorder(
                                                                          // <-- SEE HERE
                                                                            borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                            )),
                                                                        builder: (context) {
                                                                          return Container(
                                                                              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topRight: Radius.circular(15),
                                                                                    topLeft: Radius.circular(15),
                                                                                  )),
                                                                              height: 520.h,
                                                                              width: double.infinity,
                                                                              alignment: Alignment.center,
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 30.w,
                                                                                      ),
                                                                                      Text(
                                                                                        "اعدادات الاعلان",
                                                                                        style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      IconButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        icon: SvgPicture.asset("images/close.svg"),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 35.h,
                                                                                  ),
                                                                                  SvgPicture.asset("images/setting.svg"),
                                                                                  Spacer(),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.pushReplacement(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => NewAdsScreen(
                                                                                              edit: true,
                                                                                              indexAd: _ads[0].id!,
                                                                                            )),
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                            onPressed: () {
                                                                                              // Navigator.pushReplacement(
                                                                                              //   context,
                                                                                              //   MaterialPageRoute(
                                                                                              //       builder: (context) => NewAdsScreen(
                                                                                              //             edit: true,
                                                                                              //             indexAd: 237,
                                                                                              //           )),
                                                                                              // );
                                                                                            },
                                                                                            icon: Icon(
                                                                                              Icons.edit,
                                                                                              color: Color(0xff7B217E),
                                                                                            )),
                                                                                        Text(
                                                                                          "تعديل الاعلان",
                                                                                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      showModalBottomSheet(
                                                                                        context: context,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          // <-- SEE HERE
                                                                                            borderRadius: BorderRadius.only(
                                                                                              topRight: Radius.circular(15),
                                                                                              topLeft: Radius.circular(15),
                                                                                            )),
                                                                                        builder: (context) {
                                                                                          return Container(
                                                                                              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                                              decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.only(
                                                                                                    topRight: Radius.circular(15),
                                                                                                    topLeft: Radius.circular(15),
                                                                                                  )),
                                                                                              height: 600.h,
                                                                                              width: double.infinity,
                                                                                              alignment: Alignment.center,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      SizedBox(
                                                                                                        width: 30.w,
                                                                                                      ),
                                                                                                      Text(
                                                                                                        "حذف الاعلان",
                                                                                                        style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                                      ),
                                                                                                      IconButton(
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                        icon: SvgPicture.asset("images/close.svg"),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 35.h,
                                                                                                  ),
                                                                                                  SvgPicture.asset("images/trash.svg"),
                                                                                                  SizedBox(
                                                                                                    height: 20.h,
                                                                                                  ),
                                                                                                  Center(
                                                                                                    child: Text(
                                                                                                      "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
                                                                                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Spacer(),
                                                                                                  Expanded(
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        InkWell(
                                                                                                          onTap: () async {
                                                                                                            setState(() {
                                                                                                              progss = true;
                                                                                                            });

                                                                                                            await DeletId(context, id: _ads[0].id!);
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            height: 50.h,
                                                                                                            width: 165.w,
                                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
                                                                                                            child: Center(
                                                                                                              child: progss1
                                                                                                                  ? CircularProgressIndicator(
                                                                                                                color: Colors.white,
                                                                                                              )
                                                                                                                  : Text(
                                                                                                                "حذف الاعلان",
                                                                                                                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: 13.w,
                                                                                                        ),
                                                                                                        Container(
                                                                                                          height: 50.h,
                                                                                                          width: 165.w,
                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
                                                                                                          child: Center(
                                                                                                            child: Text(
                                                                                                              "تراجع",
                                                                                                              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ));
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                            onPressed: () {},
                                                                                            icon: Icon(
                                                                                              Icons.delete,
                                                                                              color: Color(0xffE04F5F),
                                                                                            )),
                                                                                        Text(
                                                                                          "حذف الاعلان",
                                                                                          style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 35.h,
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons.more_vert,
                                                                      color:
                                                                      Colors.white,
                                                                    )),
                                                              )),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              bottom: 10
                                                                  .h,
                                                              right: 5
                                                                  .w),
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius:
                                                                14,
                                                                backgroundImage: NetworkImage(user!
                                                                    .imageProfile
                                                                    .toString()),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                10.w,
                                                              ),
                                                              Text(
                                                                user!.name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffFFFFFF),
                                                                    fontWeight: FontWeight
                                                                        .w900,
                                                                    fontSize:
                                                                    10.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                    : InkWell(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StoryPage(
                                                                AdId:_ads[0].id!,

                                                              )
                                                      ),



                                                    );
                                                  },
                                                      child: Container(
                                                  margin:
                                                  EdgeInsets.only(
                                                        top: 5.h,
                                                        right: 5.w,
                                                        left: 5.w),
                                                  width: 170.w,
                                                  height: 170.h,
                                                  decoration: BoxDecoration(
                                                        color: Color(
                                                            0xff7B217E),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5),
                                                        image: DecorationImage(
                                                            fit: BoxFit
                                                                .cover,
                                                            image: NetworkImage(
                                                                _ads[0]
                                                                    .image
                                                                    .toString()))),
                                                  child: Stack(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: 10
                                                                  .w,
                                                              top: 10
                                                                  .h),
                                                          child: Align(
                                                              alignment:
                                                              Alignment
                                                                  .topLeft,
                                                              child:
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                Color(
                                                                    0xff7B217E),
                                                                radius:
                                                                14.sp,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      showModalBottomSheet(
                                                                        context: context,
                                                                        shape: RoundedRectangleBorder(
                                                                          // <-- SEE HERE
                                                                            borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                            )),
                                                                        builder: (context) {
                                                                          return Container(
                                                                              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topRight: Radius.circular(15),
                                                                                    topLeft: Radius.circular(15),
                                                                                  )),
                                                                              height: 520.h,
                                                                              width: double.infinity,
                                                                              alignment: Alignment.center,
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 30.w,
                                                                                      ),
                                                                                      Text(
                                                                                        "اعدادات الاعلان",
                                                                                        style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      IconButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        icon: SvgPicture.asset("images/close.svg"),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 35.h,
                                                                                  ),
                                                                                  SvgPicture.asset("images/setting.svg"),
                                                                                  Spacer(),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.pushReplacement(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => NewAdsScreen(
                                                                                              edit: true,
                                                                                              indexAd: _ads[0].id!,
                                                                                            )),
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                            onPressed: () {
                                                                                              // Navigator.pushReplacement(
                                                                                              //   context,
                                                                                              //   MaterialPageRoute(
                                                                                              //       builder: (context) => NewAdsScreen(
                                                                                              //             edit: true,
                                                                                              //             indexAd: 237,
                                                                                              //           )),
                                                                                              // );
                                                                                            },
                                                                                            icon: Icon(
                                                                                              Icons.edit,
                                                                                              color: Color(0xff7B217E),
                                                                                            )),
                                                                                        Text(
                                                                                          "تعديل الاعلان",
                                                                                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      showModalBottomSheet(
                                                                                        context: context,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          // <-- SEE HERE
                                                                                            borderRadius: BorderRadius.only(
                                                                                              topRight: Radius.circular(15),
                                                                                              topLeft: Radius.circular(15),
                                                                                            )),
                                                                                        builder: (context) {
                                                                                          return Container(
                                                                                              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                                              decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.only(
                                                                                                    topRight: Radius.circular(15),
                                                                                                    topLeft: Radius.circular(15),
                                                                                                  )),
                                                                                              height: 600.h,
                                                                                              width: double.infinity,
                                                                                              alignment: Alignment.center,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      SizedBox(
                                                                                                        width: 30.w,
                                                                                                      ),
                                                                                                      Text(
                                                                                                        "حذف الاعلان",
                                                                                                        style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                                      ),
                                                                                                      IconButton(
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                        icon: SvgPicture.asset("images/close.svg"),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 35.h,
                                                                                                  ),
                                                                                                  SvgPicture.asset("images/trash.svg"),
                                                                                                  SizedBox(
                                                                                                    height: 20.h,
                                                                                                  ),
                                                                                                  Center(
                                                                                                    child: Text(
                                                                                                      "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
                                                                                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Spacer(),
                                                                                                  Expanded(
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        InkWell(
                                                                                                          onTap: () async {
                                                                                                            setState(() {
                                                                                                              progss = true;
                                                                                                            });

                                                                                                            await DeletId(context, id: _ads[0].id!);
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            height: 50.h,
                                                                                                            width: 165.w,
                                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
                                                                                                            child: Center(
                                                                                                              child: progss1
                                                                                                                  ? CircularProgressIndicator(
                                                                                                                color: Colors.white,
                                                                                                              )
                                                                                                                  : Text(
                                                                                                                "حذف الاعلان",
                                                                                                                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: 13.w,
                                                                                                        ),
                                                                                                        Container(
                                                                                                          height: 50.h,
                                                                                                          width: 165.w,
                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
                                                                                                          child: Center(
                                                                                                            child: Text(
                                                                                                              "تراجع",
                                                                                                              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ));
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                            onPressed: () {},
                                                                                            icon: Icon(
                                                                                              Icons.delete,
                                                                                              color: Color(0xffE04F5F),
                                                                                            )),
                                                                                        Text(
                                                                                          "حذف الاعلان",
                                                                                          style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 35.h,
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons.more_vert,
                                                                      color:
                                                                      Colors.white,
                                                                    )),
                                                              )),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              bottom: 10
                                                                  .h,
                                                              right: 5
                                                                  .w),
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius:
                                                                14,
                                                                backgroundImage: NetworkImage(user!
                                                                    .imageProfile
                                                                    .toString()),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                10.w,
                                                              ),
                                                              Text(
                                                                user!.name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffFFFFFF),
                                                                    fontWeight: FontWeight
                                                                        .w900,
                                                                    fontSize:
                                                                    10.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                  ),
                                                ),
                                                    );
                                              }

                                              else {
                                                return SizedBox.shrink();
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                      FutureBuilder<List<AdvertiserADs>>(
                                        future: UserApiController().ADS_Admain(
                                            userid: snapshot.data!.id),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                CircularProgressIndicator());
                                          }
                                          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                            _ads = snapshot.data ?? [];

                                            return GridView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: _ads.length - 1,
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                    170.w / 170.h,
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 14.h),
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext, index) {
                                                  return _ads[index + 1]
                                                      .adType!
                                                      .type ==
                                                      "special"
                                                      ? InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                StoryPage(
                                                                  AdId:_ads[index + 1].id!,

                                                                )
                                                        ),



                                                      );
                                                    },
                                                        child: Container(
                                                    margin:
                                                    EdgeInsets.only(
                                                          right: 5.w,
                                                          left: 5.w),
                                                    width: 170.w,
                                                    height: 170.h,
                                                    decoration: BoxDecoration(
                                                          color: Color(
                                                              0xff7B217E),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          image: DecorationImage(
                                                              fit: BoxFit
                                                                  .cover,
                                                              image: NetworkImage(_ads[
                                                              index +
                                                                  1]
                                                                  .image
                                                                  .toString()))),
                                                    child: Stack(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                left: 10
                                                                    .w,
                                                                top: 10
                                                                    .h),
                                                            child: Align(
                                                                alignment:
                                                                Alignment
                                                                    .topLeft,
                                                                child:
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                  Color(
                                                                      0xff7B217E),
                                                                  radius:
                                                                  14.sp,
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        showModalBottomSheet(
                                                                          context: context,
                                                                          shape: RoundedRectangleBorder(
                                                                            // <-- SEE HERE
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(15),
                                                                                topLeft: Radius.circular(15),
                                                                              )),
                                                                          builder: (context) {
                                                                            return Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topRight: Radius.circular(15),
                                                                                      topLeft: Radius.circular(15),
                                                                                    )),
                                                                                height: 520.h,
                                                                                width: double.infinity,
                                                                                alignment: Alignment.center,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 30.w,
                                                                                        ),
                                                                                        Text(
                                                                                          "اعدادات الاعلان",
                                                                                          style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                        IconButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          icon: SvgPicture.asset("images/close.svg"),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 35.h,
                                                                                    ),
                                                                                    SvgPicture.asset("images/setting.svg"),
                                                                                    Spacer(),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        Navigator.pushReplacement(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (context) => NewAdsScreen(
                                                                                                edit: true,
                                                                                                indexAd: _ads[index + 1].id!,
                                                                                              )),
                                                                                        );
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          IconButton(
                                                                                              onPressed: () {
                                                                                                // Navigator.pushReplacement(
                                                                                                //   context,
                                                                                                //   MaterialPageRoute(
                                                                                                //       builder: (context) => NewAdsScreen(
                                                                                                //             edit: true,
                                                                                                //             indexAd: 237,
                                                                                                //           )),
                                                                                                // );
                                                                                              },
                                                                                              icon: Icon(
                                                                                                Icons.edit,
                                                                                                color: Color(0xff7B217E),
                                                                                              )),
                                                                                          Text(
                                                                                            "تعديل الاعلان",
                                                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        showModalBottomSheet(
                                                                                          context: context,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            // <-- SEE HERE
                                                                                              borderRadius: BorderRadius.only(
                                                                                                topRight: Radius.circular(15),
                                                                                                topLeft: Radius.circular(15),
                                                                                              )),
                                                                                          builder: (context) {
                                                                                            return Container(
                                                                                                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                                                decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                      topRight: Radius.circular(15),
                                                                                                      topLeft: Radius.circular(15),
                                                                                                    )),
                                                                                                height: 600.h,
                                                                                                width: double.infinity,
                                                                                                alignment: Alignment.center,
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        SizedBox(
                                                                                                          width: 30.w,
                                                                                                        ),
                                                                                                        Text(
                                                                                                          "حذف الاعلان",
                                                                                                          style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                                        ),
                                                                                                        IconButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          icon: SvgPicture.asset("images/close.svg"),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 35.h,
                                                                                                    ),
                                                                                                    SvgPicture.asset("images/trash.svg"),
                                                                                                    SizedBox(
                                                                                                      height: 20.h,
                                                                                                    ),
                                                                                                    Center(
                                                                                                      child: Text(
                                                                                                        "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
                                                                                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Spacer(),
                                                                                                    Expanded(
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          InkWell(
                                                                                                            onTap: () async {
                                                                                                              setState(() {
                                                                                                                progss = true;
                                                                                                              });

                                                                                                              await DeletId(context, id: _ads[index + 1].id!);
                                                                                                            },
                                                                                                            child: Container(
                                                                                                              height: 50.h,
                                                                                                              width: 165.w,
                                                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
                                                                                                              child: Center(
                                                                                                                child: progss1
                                                                                                                    ? CircularProgressIndicator(
                                                                                                                  color: Colors.white,
                                                                                                                )
                                                                                                                    : Text(
                                                                                                                  "حذف الاعلان",
                                                                                                                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            width: 13.w,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            height: 50.h,
                                                                                                            width: 165.w,
                                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
                                                                                                            child: Center(
                                                                                                              child: Text(
                                                                                                                "تراجع",
                                                                                                                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )
                                                                                                  ],
                                                                                                ));
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          IconButton(
                                                                                              onPressed: () {},
                                                                                              icon: Icon(
                                                                                                Icons.delete,
                                                                                                color: Color(0xffE04F5F),
                                                                                              )),
                                                                                          Text(
                                                                                            "حذف الاعلان",
                                                                                            style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 35.h,
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                          },
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons.more_vert,
                                                                        color:
                                                                        Colors.white,
                                                                      )),
                                                                )),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                bottom: 10
                                                                    .h,
                                                                right: 5
                                                                    .w),
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius:
                                                                  14,
                                                                  backgroundImage: NetworkImage(user!
                                                                      .imageProfile
                                                                      .toString()),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  10.w,
                                                                ),
                                                                Text(
                                                                  user!.name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                      fontWeight: FontWeight
                                                                          .w900,
                                                                      fontSize:
                                                                      10.sp),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                    ),
                                                  ),
                                                      )
                                                      : InkWell(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                StoryPage(
                                                                  AdId:_ads[index + 1].id!,

                                                                )
                                                        ),



                                                      );
                                                    },
                                                        child: Container(
                                                    margin:
                                                    EdgeInsets.only(
                                                          right: 5.w,
                                                          left: 5.w),
                                                    width: 170.w,
                                                    height: 170.h,
                                                    decoration: BoxDecoration(
                                                          color: Color(
                                                              0xff7B217E),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          image: DecorationImage(
                                                              fit: BoxFit
                                                                  .cover,
                                                              image: NetworkImage(_ads[
                                                              index +
                                                                  1]
                                                                  .image
                                                                  .toString()))),
                                                    child: Stack(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                left: 10
                                                                    .w,
                                                                top: 10
                                                                    .h),
                                                            child: Align(
                                                                alignment:
                                                                Alignment
                                                                    .topLeft,
                                                                child:
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                  Color(
                                                                      0xff7B217E),
                                                                  radius:
                                                                  14.sp,
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        showModalBottomSheet(
                                                                          context: context,
                                                                          shape: RoundedRectangleBorder(
                                                                            // <-- SEE HERE
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(15),
                                                                                topLeft: Radius.circular(15),
                                                                              )),
                                                                          builder: (context) {
                                                                            return Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topRight: Radius.circular(15),
                                                                                      topLeft: Radius.circular(15),
                                                                                    )),
                                                                                height: 520.h,
                                                                                width: double.infinity,
                                                                                alignment: Alignment.center,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 30.w,
                                                                                        ),
                                                                                        Text(
                                                                                          "اعدادات الاعلان",
                                                                                          style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                        IconButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          icon: SvgPicture.asset("images/close.svg"),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 35.h,
                                                                                    ),
                                                                                    SvgPicture.asset("images/setting.svg"),
                                                                                    Spacer(),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        print(_ads[index + 1].id);
                                                                                        Navigator.pushReplacement(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (context) => NewAdsScreen(
                                                                                                edit: true,
                                                                                                indexAd: _ads[index + 1].id!,
                                                                                              )),
                                                                                        );
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          IconButton(
                                                                                              onPressed: () {
                                                                                                // Navigator.pushReplacement(
                                                                                                //   context,
                                                                                                //   MaterialPageRoute(
                                                                                                //       builder: (context) => NewAdsScreen(
                                                                                                //             edit: true,
                                                                                                //             indexAd: 237,
                                                                                                //           )),
                                                                                                // );
                                                                                              },
                                                                                              icon: Icon(
                                                                                                Icons.edit,
                                                                                                color: Color(0xff7B217E),
                                                                                              )),
                                                                                          Text(
                                                                                            "تعديل الاعلان",
                                                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        showModalBottomSheet(
                                                                                          context: context,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            // <-- SEE HERE
                                                                                              borderRadius: BorderRadius.only(
                                                                                                topRight: Radius.circular(15),
                                                                                                topLeft: Radius.circular(15),
                                                                                              )),
                                                                                          builder: (context) {
                                                                                            return Container(
                                                                                                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                                                                decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                      topRight: Radius.circular(15),
                                                                                                      topLeft: Radius.circular(15),
                                                                                                    )),
                                                                                                height: 600.h,
                                                                                                width: double.infinity,
                                                                                                alignment: Alignment.center,
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        SizedBox(
                                                                                                          width: 30.w,
                                                                                                        ),
                                                                                                        Text(
                                                                                                          "حذف الاعلان",
                                                                                                          style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                                                                        ),
                                                                                                        IconButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          icon: SvgPicture.asset("images/close.svg"),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 35.h,
                                                                                                    ),
                                                                                                    SvgPicture.asset("images/trash.svg"),
                                                                                                    SizedBox(
                                                                                                      height: 20.h,
                                                                                                    ),
                                                                                                    Center(
                                                                                                      child: Text(
                                                                                                        "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
                                                                                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Spacer(),
                                                                                                    Expanded(
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          InkWell(
                                                                                                            onTap: () async {
                                                                                                              setState(() {
                                                                                                                progss = true;
                                                                                                              });

                                                                                                              await DeletId(context, id: _ads[index + 1].id!);
                                                                                                            },
                                                                                                            child: Container(
                                                                                                              height: 50.h,
                                                                                                              width: 165.w,
                                                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
                                                                                                              child: Center(
                                                                                                                child: progss1
                                                                                                                    ? CircularProgressIndicator(
                                                                                                                  color: Colors.white,
                                                                                                                )
                                                                                                                    : Text(
                                                                                                                  "حذف الاعلان",
                                                                                                                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            width: 13.w,
                                                                                                          ),
                                                                                                          Container(
                                                                                                            height: 50.h,
                                                                                                            width: 165.w,
                                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
                                                                                                            child: Center(
                                                                                                              child: Text(
                                                                                                                "تراجع",
                                                                                                                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )
                                                                                                  ],
                                                                                                ));
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          IconButton(
                                                                                              onPressed: () {},
                                                                                              icon: Icon(
                                                                                                Icons.delete,
                                                                                                color: Color(0xffE04F5F),
                                                                                              )),
                                                                                          Text(
                                                                                            "حذف الاعلان",
                                                                                            style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 35.h,
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                          },
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons.more_vert,
                                                                        color:
                                                                        Colors.white,
                                                                      )),
                                                                )),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                bottom: 10
                                                                    .h,
                                                                right: 5
                                                                    .w),
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius:
                                                                  14,
                                                                  backgroundImage: NetworkImage(user!
                                                                      .imageProfile
                                                                      .toString()),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  10.w,
                                                                ),
                                                                Text(
                                                                  user!.name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                      fontWeight: FontWeight
                                                                          .w900,
                                                                      fontSize:
                                                                      10.sp),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                    ),
                                                  ),
                                                      );
                                                });
                                          } else if (snapshot.data!.isEmpty) {
                                            return Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 80.h,
                                                ),
                                                SvgPicture.asset(
                                                    "images/ads.svg"),
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                                Text(
                                                  'لا يوجد اعلانات في الوقت الحالي ',
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Color(0xff7B217E)),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child: Icon(
                                                Icons.wifi_off_rounded,
                                                size: 80,
                                                color: Colors.purple,
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ]))
                    ],
                  ),
                ))
                : Back_Ground(
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
                            backgroundImage: snapshot.data!.imageProfile ==
                                null
                                ? null
                                : NetworkImage(snapshot.data!.imageProfile!),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
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
                                snapshot.data!.pointsCount == null
                                    ? "0"
                                    : "${snapshot.data!.pointsCount!.toString()} نقطة",
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
                                                            color: Colors.purple,
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
                                                                  BorderRadius
                                                                      .circular(
                                                                      5),
                                                                  image: snapshot.data!.imageProfile !=
                                                                      null
                                                                      ? DecorationImage(
                                                                      fit:
                                                                      BoxFit.cover,
                                                                      image: NetworkImage(snapshot.data!.imageProfile!))
                                                                      : null)),
                                                          SizedBox(
                                                            width: 15.w,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                snapshot.data!
                                                                    .name!,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    18.sp),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Container(
                                                                height: 27.h,
                                                                width: 56.w,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff969696),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        13)),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${snapshot.data!.followMeCount.toString()} متابع",
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
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: () async {
                                                              await UserApiController().Follow_One(
                                                                  followed_id:
                                                                  _folow[index]
                                                                      .id
                                                                      .toString(),
                                                                  action:
                                                                  "unfollow");

                                                              setState(() {});
                                                            },
                                                            child: Container(
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
                                                          Icon(Icons.warning,
                                                              size: 80),
                                                          Text(
                                                            'NO DATA',
                                                            style: TextStyle(
                                                                fontSize: 26),
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
                            return Center(

                            );
                          }
                        },
                      ),
                    ],
                  ),
                ));
          } else if (snapshot.hasError) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'كي تتمكن من الاستفادة من خدامتنا سجل الان ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_screen');
                    },
                    child: Text(
                      'انشاء  حساب  الان ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff7B217E),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Icon(
              Icons.wifi_off_rounded,
              size: 80,
              color: Colors.purple,
            ),
          );
        });
  }

  Future DeletId(BuildContext context, {required int id}) async {
    bool loggedIn = await UserApiController().DeletAds(context, id_dele: id);
    if (loggedIn) {
      setState(() {
        progss = false;
      });
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  Widget Detatlies({required String name, required String image}) {
    return Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(
          width: 10.w,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class UserShowAdmain extends StatefulWidget {
  int id;

  UserShowAdmain({required this.id});

  @override
  State<UserShowAdmain> createState() => _UserShowAdmainState();
}

class _UserShowAdmainState extends State<UserShowAdmain> {
  @override
  List<AdvertiserADs> _ads = [];

  Widget build(BuildContext context) {
    return FutureBuilder<Advertiser>(
        future: UserApiController().info_Admain(userid: widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ));
          } else if (snapshot.hasData) {
            return Back_Ground(
                Bar: true,
                back: true,
                eror: true,
                EditAdmain: true,
                childTab: snapshot.data!.name!,
                child: DefaultTabController(
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
                                backgroundImage: snapshot.data!.imageProfile !=
                                    null
                                    ? NetworkImage(snapshot.data!.imageProfile!)
                                    : null),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                              snapshot.data!.name!,
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
                                            id: widget.id,
                                          )));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 38.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                          color: Color(0xff969696),
                                          borderRadius:
                                          BorderRadius.circular(37)),
                                      child: Center(
                                        child: Text(
                                          " ${snapshot.data!.followMeCount} متابع",
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
                                    UserPreferences().user.type=="user"?
                                    FutureBuilder<List<MyFollowings>>(
                                      future: UserApiController().Followers_User(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center();
                                        } else if (snapshot.hasData) {
                                          List<int?> f = snapshot.data!.map((e) => e.id).toList();
                                          return f.contains(widget.id)
                                              ? InkWell(
                                            onTap: () async {
                                              await UserApiController().Follow_One(
                                                  followed_id: widget.id.toString(), action: "unfollow");
                                              setState(() {});
                                            },
                                            child:
                                            Container(
                                              height: 38.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      37),
                                                  color: Color(
                                                      0xff18499A)),
                                              child:
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    5.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      "إلغاء متابعة",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                              : InkWell(
                                            onTap:
                                                () async {
                                              await UserApiController().Follow_One(
                                                  followed_id: widget.id.toString(), action: "follow");
                                              setState(() {});
                                            },
                                            child:
                                            Container(
                                              height: 38.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      37),
                                                  color: Color(
                                                      0xff18499A)),
                                              child:
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    5.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .add_sharp,
                                                      color:
                                                      Colors.white,
                                                      size:
                                                      20,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                      10.w,
                                                    ),
                                                    Text(
                                                      "متابعة",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                       return InkWell(
                                         onTap: () async {
                                           await UserApiController().Follow_One(
                                               followed_id: widget.id.toString(), action: "unfollow");
                                           setState(() {});
                                         },
                                         child:
                                         Container(
                                           height: 38.h,
                                           width: 90.w,
                                           decoration: BoxDecoration(
                                               borderRadius:
                                               BorderRadius.circular(
                                                   37),
                                               color: Color(
                                                   0xff18499A)),
                                           child:
                                           Container(
                                             margin: EdgeInsets.symmetric(
                                                 horizontal:
                                                 5.w),
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment
                                                   .center,
                                               children: [
                                                 Text(
                                                   "إلغاء متابعة",
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 14.sp,
                                                       fontWeight: FontWeight.w600),
                                                 )
                                               ],
                                             ),
                                           ),
                                         ),
                                       );
                                        }
                                      },
                                    ):
                                    Text( UserPreferences().user.type),


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
                              color: Color(0xff7B217E),
                              borderRadius: BorderRadius.circular(5)),
                          labelColor: Colors.white,
                          unselectedLabelColor: Color(0xff7B217E),
                          tabs: [
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
                            //controller: tabController,
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
                                                onTap: () {
                                                  launch(
                                                      "whatsapp://send?phone=${snapshot.data!.mobile}&text=${"Hi"}");
                                                },
                                                child: Detatlies(
                                                    name: snapshot.data!.mobile!
                                                        .toString(),
                                                    image: "images/phone.svg"),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "mailto:${snapshot.data!.email}");
                                                },
                                                child: Detatlies(
                                                    name: snapshot.data!.email!,
                                                    image: "images/gmail.svg"),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              snapshot.data!.website != null
                                                  ? Detatlies(
                                                  name: snapshot.data!.website!,
                                                  image: "images/earth.svg")
                                                  : Text(""),
                                              SizedBox(
                                                height: 26.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.instagram != null
                                                      ? InkWell(
                                                    onTap: () {
                                                      //url_launcher: ^6.0.18

                                                      launch(snapshot
                                                          .data!.instagram!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/insnapshot.data!.instagram!stegram.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.whatsapp != null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!.whatsapp!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/whatsapp.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.facebook != null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!.facebook!);
                                                    },
                                                    child: SvgPicture.asset(
                                                        "images/facebook.svg"),
                                                  )
                                                      : Text(""),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  snapshot.data!.website != null
                                                      ? InkWell(
                                                    onTap: () {
                                                      launch(snapshot
                                                          .data!.website!);
                                                    },
                                                    child: SvgPicture.asset(
                                                      "images/earth.svg",
                                                      height: 20.h,
                                                    ),
                                                  )
                                                      : Text(""),
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
                                FutureBuilder<List<AdvertiserADs>>(
                                  future: UserApiController()
                                      .ADS_Admain(userid: widget.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      _ads = snapshot.data ?? [];
                                      return SingleChildScrollView(
                                        child: SizedBox(
                                          width: 350.w,
                                          child: GridView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: _ads.length,
                                              gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio:
                                                  165.w / 170.h,
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 14.h),
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemBuilder: (BuildContext, index) {
                                                return _ads[index].adType!.type ==
                                                    "special"
                                                    ? InkWell(
                                                  onTap: () {

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StoryPage(
                                                                AdId:_ads[index].id!,

                                                              )
                                                      ),



                                                    );


                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5.w,
                                                        left: 5.w),
                                                    width: 130.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Color(0xff7B217E),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                _ads[index]
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
                                                              color: Color(
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
                                                          builder: (context) =>
                                                              StoryPage(
                                                                AdId:_ads[index].id!,

                                                              )
                                                      ),



                                                    );

                                                  },
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5.w),
                                                    width: 165.w,
                                                    height: 170.h,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Color(0xff7B217E),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                _ads[index]
                                                                    .image
                                                                    .toString()))),
                                                  ),
                                                );
                                              }),
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 80.h,
                                          ),
                                          Container(
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
                                      );
                                    }
                                  },
                                )
                              ]))
                    ],
                  ),
                ));
          }
          return Center(
            child: Icon(
              Icons.wifi_off_rounded,
              size: 80,
              color: Colors.purple,
            ),
          );
        });
  }

  Widget Detatlies({required String name, required String image}) {
    return Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(
          width: 10.w,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
