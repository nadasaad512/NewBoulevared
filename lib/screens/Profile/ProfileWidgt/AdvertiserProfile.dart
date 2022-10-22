//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../api/User_Controller.dart';
// import '../../../component/main_bac.dart';
// import '../../../models/ads.dart';
// import '../../../models/user.dart';
// import '../../allAds/new_ads.dart';
// import '../allFollower.dart';
//
//
// class AdvertiserProfileScreen extends StatefulWidget{
//   User user ;
//   AdvertiserProfileScreen({required this.user});
//   @override
//   State<AdvertiserProfileScreen> createState() => _AdvertiserProfileScreenState();
// }
//
// class _AdvertiserProfileScreenState extends State<AdvertiserProfileScreen> {
//   bool progss = false;
//   bool progss1 = false;
//
//   List<AdvertiserADs> _ads = [];
//   User? user;
//   @override
//   Widget build(BuildContext context) {
//
//
//    return Back_Ground(
//        Bar: true,
//        edit: true,
//        EditAdmain: true,
//        childTab: widget.user.name,
//        child: DefaultTabController(
//          length: 2,
//          child: Column(
//            children: [
//              Center(
//                child: Column(
//                  children: [
//                    SizedBox(
//                      height: 24.h,
//                    ),
//                    CircleAvatar(
//                        radius: 44.sp,
//                        backgroundColor: Colors.purple,
//                        backgroundImage:
//                        widget.user.imageProfile != null
//                            ? NetworkImage(
//                            widget.user.imageProfile!)
//                            : null),
//                    SizedBox(
//                      height: 14.h,
//                    ),
//                    Text(
//                      widget.user.name,
//                      style: TextStyle(
//                          fontSize: 16.sp,
//                          fontWeight: FontWeight.w600),
//                    ),
//                    SizedBox(
//                      height: 20.h,
//                    ),
//                    InkWell(
//                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => AllFollower(
//                                  id: widget.user.id,
//                                )));
//                      },
//                      child: Container(
//                        height: 38.h,
//                        width: 90.w,
//                        decoration: BoxDecoration(
//                            color: Color(0xff969696),
//                            borderRadius:
//                            BorderRadius.circular(37)),
//                        child: Center(
//                          child: Text(
//                            " ${widget.user.followMeCount} متابع",
//                            style: TextStyle(
//                                fontSize: 16.sp,
//                                color: Colors.white,
//                                fontWeight: FontWeight.w600),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 22.h,
//              ),
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 16.w),
//                height: 50,
//                decoration: BoxDecoration(
//                    color: Colors.purple.shade50,
//                    borderRadius: BorderRadius.circular(5)),
//                child: TabBar(
//                  indicator: BoxDecoration(
//                      color: Color(0xff7B217E),
//                      borderRadius: BorderRadius.circular(5)),
//                  labelColor: Colors.white,
//                  unselectedLabelColor: Color(0xff7B217E),
//                  tabs: [
//                    Tab(
//                      text: "تواصل معنا",
//                    ),
//                    Tab(
//                      text: "الإعلانات",
//                    ),
//                  ],
//                ),
//              ),
//              Expanded(
//                  child: TabBarView(
//                    //controller: tabController,
//                      children: [
//                        Column(
//                          children: [
//                            Container(
//                                width: 343.w,
//                                margin: EdgeInsets.symmetric(
//                                    horizontal: 16.w, vertical: 10.h),
//                                decoration: BoxDecoration(
//                                  borderRadius:
//                                  BorderRadius.circular(5),
//                                  color: Colors.purple.shade50,
//                                ),
//                                child: Container(
//                                  margin: EdgeInsets.symmetric(
//                                      horizontal: 20.w, vertical: 20.h),
//                                  child: Column(
//                                    children: [
//                                      InkWell(
//                                        onTap: () {
//                                          launch("whatsapp://send?phone=${widget.user.mobile}&text=${"Hi"}");
//                                        },
//                                        child: Detatlies(
//                                            name: widget.user.mobile,
//                                            image: "images/phone.svg"),
//                                      ),
//                                      SizedBox(
//                                        height: 10.h,
//                                      ),
//                                      InkWell(
//                                        onTap: () {
//                                          launch(
//                                              "mailto:${widget.user.email}");
//                                        },
//                                        child: Detatlies(
//                                            name: widget.user.email,
//                                            image: "images/gmail.svg"),
//                                      ),
//                                      SizedBox(
//                                        height: 10.h,
//                                      ),
//                                      widget.user.website != null
//                                          ? InkWell(
//                                        onTap: () {
//                                          launch(widget.user.website!);
//                                        },
//                                        child: Detatlies(
//                                            name:widget.user.website!,
//                                            image:
//                                            "images/earth.svg"),
//                                      )
//                                          : Text(""),
//                                      SizedBox(
//                                        height: 26.h,
//                                      ),
//                                      Row(
//                                        mainAxisAlignment:
//                                        MainAxisAlignment.center,
//                                        children: [
//                                          widget.user.twitter != null
//                                              ? InkWell(
//                                            onTap: () {
//                                              launch(widget.user.twitter!);
//                                            },
//                                            child: SvgPicture.asset(
//                                                "images/twitter.svg"),
//                                          )
//                                              : Text(""),
//                                          SizedBox(
//                                            width: 26.w,
//                                          ),
//                                          widget.user.instagram !=
//                                              null
//                                              ? InkWell(
//                                            onTap: () {
//                                              launch(widget.user
//                                                  .instagram!);
//                                            },
//                                            child: SvgPicture.asset(
//                                                "images/instegram.svg"),
//                                          )
//                                              : Text(""),
//                                          SizedBox(
//                                            width: 26.w,
//                                          ),
//                                          widget.user.whatsapp !=
//                                              null
//                                              ? InkWell(
//                                            onTap: () {
//                                              launch(widget.user.whatsapp!);
//                                            },
//                                            child: SvgPicture.asset(
//                                                "images/whatsapp.svg"),
//                                          )
//                                              : Text(""),
//                                          SizedBox(
//                                            width: 26.w,
//                                          ),
//                                          widget.user.facebook !=
//                                              null
//                                              ? InkWell(
//                                            onTap: () {
//                                              launch(widget.user
//                                                  .facebook!);
//                                            },
//                                            child: SvgPicture.asset(
//                                                "images/facebook.svg"),
//                                          )
//                                              : Text(""),
//                                          SizedBox(
//                                            width: 26.w,
//                                          ),
//                                          widget.user.website != null
//                                              ? InkWell(
//                                            onTap: () {
//                                              launch(widget.user
//                                                  .website!);
//                                            },
//                                            child:
//                                            SvgPicture.asset(
//                                              "images/earth.svg",
//                                              height: 20.h,
//                                            ),
//                                          )
//                                              : Text(""),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 26.h,
//                                      ),
//                                    ],
//                                  ),
//                                )),
//                            SizedBox(
//                              height: 30.h,
//                            ),
//                          ],
//                        ),
//                        SingleChildScrollView(
//                          child: Column(
//                            children: [
//                              Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.center,
//                                children: [
//                                  InkWell(
//                                    onTap: () {
//                                      Navigator.pushNamed(
//                                          context, '/NewAdsScreen');
//                                    },
//                                    child: Container(
//                                      width: 170.w,
//                                      height: 170.h,
//                                      margin: EdgeInsets.only(
//                                          left: 5.w,
//                                          right: 5.w,
//                                          top: 5.h),
//                                      decoration: BoxDecoration(
//                                          color: Color(0xff7B217E),
//                                          borderRadius:
//                                          BorderRadius.circular(5),
//                                          image: DecorationImage(
//                                              fit: BoxFit.cover,
//                                              image: NetworkImage(""))),
//                                      child: Center(
//                                          child: Container(
//                                            margin: EdgeInsets.symmetric(
//                                                vertical: 20.h),
//                                            child: Column(
//                                              mainAxisAlignment:
//                                              MainAxisAlignment.center,
//                                              children: [
//                                                InkWell(
//                                                    onTap: () {
//                                                      Navigator.pushNamed(
//                                                          context,
//                                                          '/NewAdsScreen');
//                                                    },
//                                                    child: Icon(
//                                                      Icons
//                                                          .add_circle_rounded,
//                                                      color: Colors.white,
//                                                      size: 60.sp,
//                                                    )),
//                                                SizedBox(
//                                                  height: 10.h,
//                                                ),
//                                                Text(
//                                                  "إضافة إعلان",
//                                                  style: TextStyle(
//                                                      fontWeight:
//                                                      FontWeight.w600,
//                                                      fontSize: 16.sp,
//                                                      color: Colors.white),
//                                                )
//                                              ],
//                                            ),
//                                          )),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 5.w,
//                                  ),
//                                  FutureBuilder<List<AdvertiserADs>>(
//                                    future: UserApiController()
//                                        .ADS_Admain(
//                                        userid: widget.user.id
//                                    ),
//                                    builder: (context, snapshot) {
//                                      if (snapshot.connectionState ==
//                                          ConnectionState.waiting) {
//                                        return Center();
//                                      } else if (snapshot.hasData &&
//                                          snapshot.data!.isNotEmpty) {
//                                        _ads = snapshot.data ?? [];
//
//                                        return _ads[0].adType!.type ==
//                                            "special"
//                                            ? Container(
//                                          margin: EdgeInsets.only(
//                                              top: 5.h,
//                                              right: 5.w,
//                                              left: 5.w),
//                                          width: 170.w,
//                                          height: 170.h,
//                                          decoration: BoxDecoration(
//                                              color: Color(
//                                                  0xff7B217E),
//                                              borderRadius:
//                                              BorderRadius
//                                                  .circular(
//                                                  5),
//                                              image: DecorationImage(
//                                                  fit: BoxFit
//                                                      .cover,
//                                                  image: NetworkImage(
//                                                      _ads[0]
//                                                          .image
//                                                          .toString()))),
//                                          child: Stack(
//                                            children: [
//                                              Container(
//                                                margin: EdgeInsets
//                                                    .only(
//                                                    left:
//                                                    10.w,
//                                                    top:
//                                                    10.h),
//                                                child: Align(
//                                                    alignment:
//                                                    Alignment
//                                                        .topLeft,
//                                                    child:
//                                                    CircleAvatar(
//                                                      backgroundColor:
//                                                      Color(
//                                                          0xff7B217E),
//                                                      radius:
//                                                      14.sp,
//                                                      child: InkWell(
//                                                          onTap: () {
//                                                            showModalBottomSheet(
//                                                              context:
//                                                              context,
//                                                              shape: RoundedRectangleBorder(
//                                                                // <-- SEE HERE
//                                                                  borderRadius: BorderRadius.only(
//                                                                    topRight: Radius.circular(15),
//                                                                    topLeft: Radius.circular(15),
//                                                                  )),
//                                                              builder:
//                                                                  (context) {
//                                                                return Container(
//                                                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                                                                    decoration: BoxDecoration(
//                                                                        borderRadius: BorderRadius.only(
//                                                                          topRight: Radius.circular(15),
//                                                                          topLeft: Radius.circular(15),
//                                                                        )),
//                                                                    height: 520.h,
//                                                                    width: double.infinity,
//                                                                    alignment: Alignment.center,
//                                                                    child: Column(
//                                                                      children: [
//                                                                        Row(
//                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                          children: [
//                                                                            SizedBox(
//                                                                              width: 30.w,
//                                                                            ),
//                                                                            Text(
//                                                                              "اعدادات الاعلان",
//                                                                              style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                                                                            ),
//                                                                            IconButton(
//                                                                              onPressed: () {
//                                                                                Navigator.pop(context);
//                                                                              },
//                                                                              icon: SvgPicture.asset("images/close.svg"),
//                                                                            ),
//                                                                          ],
//                                                                        ),
//                                                                        SizedBox(
//                                                                          height: 35.h,
//                                                                        ),
//                                                                        SvgPicture.asset("images/setting.svg"),
//                                                                        Spacer(),
//                                                                        InkWell(
//                                                                          onTap: () {
//                                                                            Navigator.pushReplacement(
//                                                                              context,
//                                                                              MaterialPageRoute(
//                                                                                  builder: (context) => NewAdsScreen(
//                                                                                    edit: true,
//                                                                                    indexAd: _ads[0].id!,
//                                                                                  )),
//                                                                            );
//                                                                          },
//                                                                          child: Row(
//                                                                            children: [
//                                                                              IconButton(
//                                                                                  onPressed: () {
//                                                                                    // Navigator.pushReplacement(
//                                                                                    //   context,
//                                                                                    //   MaterialPageRoute(
//                                                                                    //       builder: (context) => NewAdsScreen(
//                                                                                    //             edit: true,
//                                                                                    //             indexAd: 237,
//                                                                                    //           )),
//                                                                                    // );
//                                                                                  },
//                                                                                  icon: Icon(
//                                                                                    Icons.edit,
//                                                                                    color: Color(0xff7B217E),
//                                                                                  )),
//                                                                              Text(
//                                                                                "تعديل الاعلان",
//                                                                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                        ),
//                                                                        Divider(),
//                                                                        InkWell(
//                                                                          onTap: () {
//                                                                            showModalBottomSheet(
//                                                                              context: context,
//                                                                              shape: RoundedRectangleBorder(
//                                                                                // <-- SEE HERE
//                                                                                  borderRadius: BorderRadius.only(
//                                                                                    topRight: Radius.circular(15),
//                                                                                    topLeft: Radius.circular(15),
//                                                                                  )),
//                                                                              builder: (context) {
//                                                                                return Container(
//                                                                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                                                                                    decoration: BoxDecoration(
//                                                                                        borderRadius: BorderRadius.only(
//                                                                                          topRight: Radius.circular(15),
//                                                                                          topLeft: Radius.circular(15),
//                                                                                        )),
//                                                                                    height: 600.h,
//                                                                                    width: double.infinity,
//                                                                                    alignment: Alignment.center,
//                                                                                    child: Column(
//                                                                                      children: [
//                                                                                        Row(
//                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                          children: [
//                                                                                            SizedBox(
//                                                                                              width: 30.w,
//                                                                                            ),
//                                                                                            Text(
//                                                                                              "حذف الاعلان",
//                                                                                              style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                                                                                            ),
//                                                                                            IconButton(
//                                                                                              onPressed: () {
//                                                                                                Navigator.pop(context);
//                                                                                              },
//                                                                                              icon: SvgPicture.asset("images/close.svg"),
//                                                                                            ),
//                                                                                          ],
//                                                                                        ),
//                                                                                        SizedBox(
//                                                                                          height: 35.h,
//                                                                                        ),
//                                                                                        SvgPicture.asset("images/trash.svg"),
//                                                                                        SizedBox(
//                                                                                          height: 20.h,
//                                                                                        ),
//                                                                                        Center(
//                                                                                          child: Text(
//                                                                                            "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
//                                                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
//                                                                                          ),
//                                                                                        ),
//                                                                                        Spacer(),
//                                                                                        Expanded(
//                                                                                          child: Row(
//                                                                                            children: [
//                                                                                              InkWell(
//                                                                                                onTap: () async {
//                                                                                                  setState(() {
//                                                                                                    progss = true;
//                                                                                                  });
//
//                                                                                                  await DeletId(context, id: _ads[0].id!);
//                                                                                                },
//                                                                                                child: Container(
//                                                                                                  height: 50.h,
//                                                                                                  width: 165.w,
//                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
//                                                                                                  child: Center(
//                                                                                                    child: progss1
//                                                                                                        ? CircularProgressIndicator(
//                                                                                                      color: Colors.white,
//                                                                                                    )
//                                                                                                        : Text(
//                                                                                                      "حذف الاعلان",
//                                                                                                      style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                                                                                                    ),
//                                                                                                  ),
//                                                                                                ),
//                                                                                              ),
//                                                                                              SizedBox(
//                                                                                                width: 13.w,
//                                                                                              ),
//                                                                                              Container(
//                                                                                                height: 50.h,
//                                                                                                width: 165.w,
//                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
//                                                                                                child: Center(
//                                                                                                  child: Text(
//                                                                                                    "تراجع",
//                                                                                                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                                                                                                  ),
//                                                                                                ),
//                                                                                              ),
//                                                                                            ],
//                                                                                          ),
//                                                                                        )
//                                                                                      ],
//                                                                                    ));
//                                                                              },
//                                                                            );
//                                                                          },
//                                                                          child: Row(
//                                                                            children: [
//                                                                              IconButton(
//                                                                                  onPressed: () {},
//                                                                                  icon: Icon(
//                                                                                    Icons.delete,
//                                                                                    color: Color(0xffE04F5F),
//                                                                                  )),
//                                                                              Text(
//                                                                                "حذف الاعلان",
//                                                                                style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                        ),
//                                                                        SizedBox(
//                                                                          height: 35.h,
//                                                                        ),
//                                                                      ],
//                                                                    ));
//                                                              },
//                                                            );
//                                                          },
//                                                          child: Icon(
//                                                            Icons
//                                                                .more_vert,
//                                                            color:
//                                                            Colors.white,
//                                                          )),
//                                                    )),
//                                              ),
//                                              Container(
//                                                margin: EdgeInsets
//                                                    .only(
//                                                    bottom:
//                                                    10.h,
//                                                    right:
//                                                    5.w),
//                                                alignment: Alignment
//                                                    .bottomRight,
//                                                child: Row(
//                                                  children: [
//                                                    CircleAvatar(
//                                                      radius: 14,
//                                                      backgroundImage:
//                                                      NetworkImage(user!
//                                                          .imageProfile
//                                                          .toString()),
//                                                    ),
//                                                    SizedBox(
//                                                      width: 10.w,
//                                                    ),
//                                                    Text(
//                                                      user!.name
//                                                          .toString(),
//                                                      style: TextStyle(
//                                                          color: Color(
//                                                              0xffFFFFFF),
//                                                          fontWeight:
//                                                          FontWeight
//                                                              .w900,
//                                                          fontSize:
//                                                          10.sp),
//                                                    ),
//                                                  ],
//                                                ),
//                                              )
//                                            ],
//                                          ),
//                                        )
//                                            : Container(
//                                          margin: EdgeInsets.only(
//                                              top: 5.h,
//                                              right: 5.w,
//                                              left: 5.w),
//                                          width: 170.w,
//                                          height: 170.h,
//                                          decoration: BoxDecoration(
//                                              color: Color(
//                                                  0xff7B217E),
//                                              borderRadius:
//                                              BorderRadius
//                                                  .circular(
//                                                  5),
//                                              image: DecorationImage(
//                                                  fit: BoxFit
//                                                      .cover,
//                                                  image: NetworkImage(
//                                                      _ads[0]
//                                                          .image
//                                                          .toString()))),
//                                          child: Stack(
//                                            children: [
//                                              Container(
//                                                margin: EdgeInsets
//                                                    .only(
//                                                    left:
//                                                    10.w,
//                                                    top:
//                                                    10.h),
//                                                child: Align(
//                                                    alignment:
//                                                    Alignment
//                                                        .topLeft,
//                                                    child:
//                                                    CircleAvatar(
//                                                      backgroundColor:
//                                                      Color(
//                                                          0xff7B217E),
//                                                      radius:
//                                                      14.sp,
//                                                      child: InkWell(
//                                                          onTap: () {
//                                                            showModalBottomSheet(
//                                                              context:
//                                                              context,
//                                                              shape: RoundedRectangleBorder(
//                                                                // <-- SEE HERE
//                                                                  borderRadius: BorderRadius.only(
//                                                                    topRight: Radius.circular(15),
//                                                                    topLeft: Radius.circular(15),
//                                                                  )),
//                                                              builder:
//                                                                  (context) {
//                                                                return Container(
//                                                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                                                                    decoration: BoxDecoration(
//                                                                        borderRadius: BorderRadius.only(
//                                                                          topRight: Radius.circular(15),
//                                                                          topLeft: Radius.circular(15),
//                                                                        )),
//                                                                    height: 520.h,
//                                                                    width: double.infinity,
//                                                                    alignment: Alignment.center,
//                                                                    child: Column(
//                                                                      children: [
//                                                                        Row(
//                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                          children: [
//                                                                            SizedBox(
//                                                                              width: 30.w,
//                                                                            ),
//                                                                            Text(
//                                                                              "اعدادات الاعلان",
//                                                                              style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                                                                            ),
//                                                                            IconButton(
//                                                                              onPressed: () {
//                                                                                Navigator.pop(context);
//                                                                              },
//                                                                              icon: SvgPicture.asset("images/close.svg"),
//                                                                            ),
//                                                                          ],
//                                                                        ),
//                                                                        SizedBox(
//                                                                          height: 35.h,
//                                                                        ),
//                                                                        SvgPicture.asset("images/setting.svg"),
//                                                                        Spacer(),
//                                                                        InkWell(
//                                                                          onTap: () {
//                                                                            Navigator.pushReplacement(
//                                                                              context,
//                                                                              MaterialPageRoute(
//                                                                                  builder: (context) => NewAdsScreen(
//                                                                                    edit: true,
//                                                                                    indexAd: _ads[0].id!,
//                                                                                  )),
//                                                                            );
//                                                                          },
//                                                                          child: Row(
//                                                                            children: [
//                                                                              IconButton(
//                                                                                  onPressed: () {
//                                                                                    // Navigator.pushReplacement(
//                                                                                    //   context,
//                                                                                    //   MaterialPageRoute(
//                                                                                    //       builder: (context) => NewAdsScreen(
//                                                                                    //             edit: true,
//                                                                                    //             indexAd: 237,
//                                                                                    //           )),
//                                                                                    // );
//                                                                                  },
//                                                                                  icon: Icon(
//                                                                                    Icons.edit,
//                                                                                    color: Color(0xff7B217E),
//                                                                                  )),
//                                                                              Text(
//                                                                                "تعديل الاعلان",
//                                                                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                        ),
//                                                                        Divider(),
//                                                                        InkWell(
//                                                                          onTap: () {
//                                                                            showModalBottomSheet(
//                                                                              context: context,
//                                                                              shape: RoundedRectangleBorder(
//                                                                                // <-- SEE HERE
//                                                                                  borderRadius: BorderRadius.only(
//                                                                                    topRight: Radius.circular(15),
//                                                                                    topLeft: Radius.circular(15),
//                                                                                  )),
//                                                                              builder: (context) {
//                                                                                return Container(
//                                                                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                                                                                    decoration: BoxDecoration(
//                                                                                        borderRadius: BorderRadius.only(
//                                                                                          topRight: Radius.circular(15),
//                                                                                          topLeft: Radius.circular(15),
//                                                                                        )),
//                                                                                    height: 600.h,
//                                                                                    width: double.infinity,
//                                                                                    alignment: Alignment.center,
//                                                                                    child: Column(
//                                                                                      children: [
//                                                                                        Row(
//                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                          children: [
//                                                                                            SizedBox(
//                                                                                              width: 30.w,
//                                                                                            ),
//                                                                                            Text(
//                                                                                              "حذف الاعلان",
//                                                                                              style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                                                                                            ),
//                                                                                            IconButton(
//                                                                                              onPressed: () {
//                                                                                                Navigator.pop(context);
//                                                                                              },
//                                                                                              icon: SvgPicture.asset("images/close.svg"),
//                                                                                            ),
//                                                                                          ],
//                                                                                        ),
//                                                                                        SizedBox(
//                                                                                          height: 35.h,
//                                                                                        ),
//                                                                                        SvgPicture.asset("images/trash.svg"),
//                                                                                        SizedBox(
//                                                                                          height: 20.h,
//                                                                                        ),
//                                                                                        Center(
//                                                                                          child: Text(
//                                                                                            "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
//                                                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
//                                                                                          ),
//                                                                                        ),
//                                                                                        Spacer(),
//                                                                                        Expanded(
//                                                                                          child: Row(
//                                                                                            children: [
//                                                                                              InkWell(
//                                                                                                onTap: () async {
//                                                                                                  setState(() {
//                                                                                                    progss = true;
//                                                                                                  });
//
//                                                                                                  await DeletId(context, id: _ads[0].id!);
//                                                                                                },
//                                                                                                child: Container(
//                                                                                                  height: 50.h,
//                                                                                                  width: 165.w,
//                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
//                                                                                                  child: Center(
//                                                                                                    child: progss1
//                                                                                                        ? CircularProgressIndicator(
//                                                                                                      color: Colors.white,
//                                                                                                    )
//                                                                                                        : Text(
//                                                                                                      "حذف الاعلان",
//                                                                                                      style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                                                                                                    ),
//                                                                                                  ),
//                                                                                                ),
//                                                                                              ),
//                                                                                              SizedBox(
//                                                                                                width: 13.w,
//                                                                                              ),
//                                                                                              Container(
//                                                                                                height: 50.h,
//                                                                                                width: 165.w,
//                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
//                                                                                                child: Center(
//                                                                                                  child: Text(
//                                                                                                    "تراجع",
//                                                                                                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                                                                                                  ),
//                                                                                                ),
//                                                                                              ),
//                                                                                            ],
//                                                                                          ),
//                                                                                        )
//                                                                                      ],
//                                                                                    ));
//                                                                              },
//                                                                            );
//                                                                          },
//                                                                          child: Row(
//                                                                            children: [
//                                                                              IconButton(
//                                                                                  onPressed: () {},
//                                                                                  icon: Icon(
//                                                                                    Icons.delete,
//                                                                                    color: Color(0xffE04F5F),
//                                                                                  )),
//                                                                              Text(
//                                                                                "حذف الاعلان",
//                                                                                style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                        ),
//                                                                        SizedBox(
//                                                                          height: 35.h,
//                                                                        ),
//                                                                      ],
//                                                                    ));
//                                                              },
//                                                            );
//                                                          },
//                                                          child: Icon(
//                                                            Icons
//                                                                .more_vert,
//                                                            color:
//                                                            Colors.white,
//                                                          )),
//                                                    )),
//                                              ),
//                                              Container(
//                                                margin: EdgeInsets
//                                                    .only(
//                                                    bottom:
//                                                    10.h,
//                                                    right:
//                                                    5.w),
//                                                alignment: Alignment
//                                                    .bottomRight,
//                                                child: Row(
//                                                  children: [
//                                                    CircleAvatar(
//                                                      radius: 14,
//                                                      backgroundImage:
//                                                      NetworkImage(user!
//                                                          .imageProfile
//                                                          .toString()),
//                                                    ),
//                                                    SizedBox(
//                                                      width: 10.w,
//                                                    ),
//                                                    Text(
//                                                      user!.name
//                                                          .toString(),
//                                                      style: TextStyle(
//                                                          color: Color(
//                                                              0xffFFFFFF),
//                                                          fontWeight:
//                                                          FontWeight
//                                                              .w900,
//                                                          fontSize:
//                                                          10.sp),
//                                                    ),
//                                                  ],
//                                                ),
//                                              )
//                                            ],
//                                          ),
//                                        );
//                                      } else {
//                                        return SizedBox.shrink();
//                                      }
//                                    },
//                                  )
//                                ],
//                              ),
//                              // FutureBuilder<List<AdvertiserADs>>(
//                              //   future: UserApiController().ADS_Admain(
//                              //       userid: widget.user.id),
//                              //   builder: (context, snapshot) {
//                              //     if (snapshot.connectionState ==
//                              //         ConnectionState.waiting) {
//                              //       return Center(
//                              //           child:
//                              //           CircularProgressIndicator());
//                              //     } else if (snapshot.hasData &&
//                              //         snapshot.data!.isNotEmpty) {
//                              //       _ads = snapshot.data ?? [];
//                              //       return GridView.builder(
//                              //           scrollDirection: Axis.vertical,
//                              //           itemCount: _ads.length - 1,
//                              //           gridDelegate:
//                              //           SliverGridDelegateWithFixedCrossAxisCount(
//                              //               childAspectRatio:
//                              //               170.w / 170.h,
//                              //               crossAxisCount: 2,
//                              //               mainAxisSpacing: 14.h),
//                              //           shrinkWrap: true,
//                              //           physics: ScrollPhysics(),
//                              //           itemBuilder:
//                              //               (BuildContext, index) {
//                              //             return _ads[index + 1]
//                              //                 .adType!
//                              //                 .type ==
//                              //                 "special"
//                              //                 ? Container(
//                              //               margin:
//                              //               EdgeInsets.only(
//                              //                   right: 5.w,
//                              //                   left: 5.w),
//                              //               width: 170.w,
//                              //               height: 170.h,
//                              //               decoration: BoxDecoration(
//                              //                   color: Color(
//                              //                       0xff7B217E),
//                              //                   borderRadius:
//                              //                   BorderRadius
//                              //                       .circular(
//                              //                       5),
//                              //                   image: DecorationImage(
//                              //                       fit: BoxFit
//                              //                           .cover,
//                              //                       image: NetworkImage(_ads[
//                              //                       index +
//                              //                           1]
//                              //                           .image
//                              //                           .toString()))),
//                              //               child: Stack(
//                              //                 children: [
//                              //                   Container(
//                              //                     margin: EdgeInsets
//                              //                         .only(
//                              //                         left: 10
//                              //                             .w,
//                              //                         top: 10
//                              //                             .h),
//                              //                     child: Align(
//                              //                         alignment:
//                              //                         Alignment
//                              //                             .topLeft,
//                              //                         child:
//                              //                         CircleAvatar(
//                              //                           backgroundColor:
//                              //                           Color(
//                              //                               0xff7B217E),
//                              //                           radius:
//                              //                           14.sp,
//                              //                           child: InkWell(
//                              //                               onTap: () {
//                              //                                 showModalBottomSheet(
//                              //                                   context: context,
//                              //                                   shape: RoundedRectangleBorder(
//                              //                                     // <-- SEE HERE
//                              //                                       borderRadius: BorderRadius.only(
//                              //                                         topRight: Radius.circular(15),
//                              //                                         topLeft: Radius.circular(15),
//                              //                                       )),
//                              //                                   builder: (context) {
//                              //                                     return Container(
//                              //                                         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                              //                                         decoration: BoxDecoration(
//                              //                                             borderRadius: BorderRadius.only(
//                              //                                               topRight: Radius.circular(15),
//                              //                                               topLeft: Radius.circular(15),
//                              //                                             )),
//                              //                                         height: 520.h,
//                              //                                         width: double.infinity,
//                              //                                         alignment: Alignment.center,
//                              //                                         child: Column(
//                              //                                           children: [
//                              //                                             Row(
//                              //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              //                                               children: [
//                              //                                                 SizedBox(
//                              //                                                   width: 30.w,
//                              //                                                 ),
//                              //                                                 Text(
//                              //                                                   "اعدادات الاعلان",
//                              //                                                   style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                              //                                                 ),
//                              //                                                 IconButton(
//                              //                                                   onPressed: () {
//                              //                                                     Navigator.pop(context);
//                              //                                                   },
//                              //                                                   icon: SvgPicture.asset("images/close.svg"),
//                              //                                                 ),
//                              //                                               ],
//                              //                                             ),
//                              //                                             SizedBox(
//                              //                                               height: 35.h,
//                              //                                             ),
//                              //                                             SvgPicture.asset("images/setting.svg"),
//                              //                                             Spacer(),
//                              //                                             InkWell(
//                              //                                               onTap: () {
//                              //                                                 Navigator.pushReplacement(
//                              //                                                   context,
//                              //                                                   MaterialPageRoute(
//                              //                                                       builder: (context) => NewAdsScreen(
//                              //                                                         edit: true,
//                              //                                                         indexAd: _ads[index + 1].id!,
//                              //                                                       )),
//                              //                                                 );
//                              //                                               },
//                              //                                               child: Row(
//                              //                                                 children: [
//                              //                                                   IconButton(
//                              //                                                       onPressed: () {
//                              //                                                         // Navigator.pushReplacement(
//                              //                                                         //   context,
//                              //                                                         //   MaterialPageRoute(
//                              //                                                         //       builder: (context) => NewAdsScreen(
//                              //                                                         //             edit: true,
//                              //                                                         //             indexAd: 237,
//                              //                                                         //           )),
//                              //                                                         // );
//                              //                                                       },
//                              //                                                       icon: Icon(
//                              //                                                         Icons.edit,
//                              //                                                         color: Color(0xff7B217E),
//                              //                                                       )),
//                              //                                                   Text(
//                              //                                                     "تعديل الاعلان",
//                              //                                                     style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//                              //                                                   ),
//                              //                                                 ],
//                              //                                               ),
//                              //                                             ),
//                              //                                             Divider(),
//                              //                                             InkWell(
//                              //                                               onTap: () {
//                              //                                                 showModalBottomSheet(
//                              //                                                   context: context,
//                              //                                                   shape: RoundedRectangleBorder(
//                              //                                                     // <-- SEE HERE
//                              //                                                       borderRadius: BorderRadius.only(
//                              //                                                         topRight: Radius.circular(15),
//                              //                                                         topLeft: Radius.circular(15),
//                              //                                                       )),
//                              //                                                   builder: (context) {
//                              //                                                     return Container(
//                              //                                                         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                              //                                                         decoration: BoxDecoration(
//                              //                                                             borderRadius: BorderRadius.only(
//                              //                                                               topRight: Radius.circular(15),
//                              //                                                               topLeft: Radius.circular(15),
//                              //                                                             )),
//                              //                                                         height: 600.h,
//                              //                                                         width: double.infinity,
//                              //                                                         alignment: Alignment.center,
//                              //                                                         child: Column(
//                              //                                                           children: [
//                              //                                                             Row(
//                              //                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              //                                                               children: [
//                              //                                                                 SizedBox(
//                              //                                                                   width: 30.w,
//                              //                                                                 ),
//                              //                                                                 Text(
//                              //                                                                   "حذف الاعلان",
//                              //                                                                   style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                              //                                                                 ),
//                              //                                                                 IconButton(
//                              //                                                                   onPressed: () {
//                              //                                                                     Navigator.pop(context);
//                              //                                                                   },
//                              //                                                                   icon: SvgPicture.asset("images/close.svg"),
//                              //                                                                 ),
//                              //                                                               ],
//                              //                                                             ),
//                              //                                                             SizedBox(
//                              //                                                               height: 35.h,
//                              //                                                             ),
//                              //                                                             SvgPicture.asset("images/trash.svg"),
//                              //                                                             SizedBox(
//                              //                                                               height: 20.h,
//                              //                                                             ),
//                              //                                                             Center(
//                              //                                                               child: Text(
//                              //                                                                 "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
//                              //                                                                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
//                              //                                                               ),
//                              //                                                             ),
//                              //                                                             Spacer(),
//                              //                                                             Expanded(
//                              //                                                               child: Row(
//                              //                                                                 children: [
//                              //                                                                   InkWell(
//                              //                                                                     onTap: () async {
//                              //                                                                       setState(() {
//                              //                                                                         progss = true;
//                              //                                                                       });
//                              //
//                              //                                                                       await DeletId(context, id: _ads[index + 1].id!);
//                              //                                                                     },
//                              //                                                                     child: Container(
//                              //                                                                       height: 50.h,
//                              //                                                                       width: 165.w,
//                              //                                                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
//                              //                                                                       child: Center(
//                              //                                                                         child: progss1
//                              //                                                                             ? CircularProgressIndicator(
//                              //                                                                           color: Colors.white,
//                              //                                                                         )
//                              //                                                                             : Text(
//                              //                                                                           "حذف الاعلان",
//                              //                                                                           style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                              //                                                                         ),
//                              //                                                                       ),
//                              //                                                                     ),
//                              //                                                                   ),
//                              //                                                                   SizedBox(
//                              //                                                                     width: 13.w,
//                              //                                                                   ),
//                              //                                                                   Container(
//                              //                                                                     height: 50.h,
//                              //                                                                     width: 165.w,
//                              //                                                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
//                              //                                                                     child: Center(
//                              //                                                                       child: Text(
//                              //                                                                         "تراجع",
//                              //                                                                         style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                              //                                                                       ),
//                              //                                                                     ),
//                              //                                                                   ),
//                              //                                                                 ],
//                              //                                                               ),
//                              //                                                             )
//                              //                                                           ],
//                              //                                                         ));
//                              //                                                   },
//                              //                                                 );
//                              //                                               },
//                              //                                               child: Row(
//                              //                                                 children: [
//                              //                                                   IconButton(
//                              //                                                       onPressed: () {},
//                              //                                                       icon: Icon(
//                              //                                                         Icons.delete,
//                              //                                                         color: Color(0xffE04F5F),
//                              //                                                       )),
//                              //                                                   Text(
//                              //                                                     "حذف الاعلان",
//                              //                                                     style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
//                              //                                                   ),
//                              //                                                 ],
//                              //                                               ),
//                              //                                             ),
//                              //                                             SizedBox(
//                              //                                               height: 35.h,
//                              //                                             ),
//                              //                                           ],
//                              //                                         ));
//                              //                                   },
//                              //                                 );
//                              //                               },
//                              //                               child: Icon(
//                              //                                 Icons.more_vert,
//                              //                                 color:
//                              //                                 Colors.white,
//                              //                               )),
//                              //                         )),
//                              //                   ),
//                              //                   Container(
//                              //                     margin: EdgeInsets
//                              //                         .only(
//                              //                         bottom: 10
//                              //                             .h,
//                              //                         right: 5
//                              //                             .w),
//                              //                     alignment: Alignment
//                              //                         .bottomRight,
//                              //                     child: Row(
//                              //                       children: [
//                              //                         CircleAvatar(
//                              //                           radius:
//                              //                           14,
//                              //                           backgroundImage: NetworkImage(user!
//                              //                               .imageProfile
//                              //                               .toString()),
//                              //                         ),
//                              //                         SizedBox(
//                              //                           width:
//                              //                           10.w,
//                              //                         ),
//                              //                         Text(
//                              //                           user!.name
//                              //                               .toString(),
//                              //                           style: TextStyle(
//                              //                               color: Color(
//                              //                                   0xffFFFFFF),
//                              //                               fontWeight: FontWeight
//                              //                                   .w900,
//                              //                               fontSize:
//                              //                               10.sp),
//                              //                         ),
//                              //                       ],
//                              //                     ),
//                              //                   )
//                              //                 ],
//                              //               ),
//                              //             )
//                              //                 : Container(
//                              //               margin:
//                              //               EdgeInsets.only(
//                              //                   right: 5.w,
//                              //                   left: 5.w),
//                              //               width: 170.w,
//                              //               height: 170.h,
//                              //               decoration: BoxDecoration(
//                              //                   color: Color(
//                              //                       0xff7B217E),
//                              //                   borderRadius:
//                              //                   BorderRadius
//                              //                       .circular(
//                              //                       5),
//                              //                   image: DecorationImage(
//                              //                       fit: BoxFit
//                              //                           .cover,
//                              //                       image: NetworkImage(_ads[
//                              //                       index +
//                              //                           1]
//                              //                           .image
//                              //                           .toString()))),
//                              //               child: Stack(
//                              //                 children: [
//                              //                   Container(
//                              //                     margin: EdgeInsets
//                              //                         .only(
//                              //                         left: 10
//                              //                             .w,
//                              //                         top: 10
//                              //                             .h),
//                              //                     child: Align(
//                              //                         alignment:
//                              //                         Alignment
//                              //                             .topLeft,
//                              //                         child:
//                              //                         CircleAvatar(
//                              //                           backgroundColor:
//                              //                           Color(
//                              //                               0xff7B217E),
//                              //                           radius:
//                              //                           14.sp,
//                              //                           child: InkWell(
//                              //                               onTap: () {
//                              //                                 showModalBottomSheet(
//                              //                                   context: context,
//                              //                                   shape: RoundedRectangleBorder(
//                              //                                     // <-- SEE HERE
//                              //                                       borderRadius: BorderRadius.only(
//                              //                                         topRight: Radius.circular(15),
//                              //                                         topLeft: Radius.circular(15),
//                              //                                       )),
//                              //                                   builder: (context) {
//                              //                                     return Container(
//                              //                                         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                              //                                         decoration: BoxDecoration(
//                              //                                             borderRadius: BorderRadius.only(
//                              //                                               topRight: Radius.circular(15),
//                              //                                               topLeft: Radius.circular(15),
//                              //                                             )),
//                              //                                         height: 520.h,
//                              //                                         width: double.infinity,
//                              //                                         alignment: Alignment.center,
//                              //                                         child: Column(
//                              //                                           children: [
//                              //                                             Row(
//                              //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              //                                               children: [
//                              //                                                 SizedBox(
//                              //                                                   width: 30.w,
//                              //                                                 ),
//                              //                                                 Text(
//                              //                                                   "اعدادات الاعلان",
//                              //                                                   style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                              //                                                 ),
//                              //                                                 IconButton(
//                              //                                                   onPressed: () {
//                              //                                                     Navigator.pop(context);
//                              //                                                   },
//                              //                                                   icon: SvgPicture.asset("images/close.svg"),
//                              //                                                 ),
//                              //                                               ],
//                              //                                             ),
//                              //                                             SizedBox(
//                              //                                               height: 35.h,
//                              //                                             ),
//                              //                                             SvgPicture.asset("images/setting.svg"),
//                              //                                             Spacer(),
//                              //                                             InkWell(
//                              //                                               onTap: () {
//                              //                                                 print(_ads[index + 1].id);
//                              //                                                 Navigator.pushReplacement(
//                              //                                                   context,
//                              //                                                   MaterialPageRoute(
//                              //                                                       builder: (context) => NewAdsScreen(
//                              //                                                         edit: true,
//                              //                                                         indexAd: _ads[index + 1].id!,
//                              //                                                       )),
//                              //                                                 );
//                              //                                               },
//                              //                                               child: Row(
//                              //                                                 children: [
//                              //                                                   IconButton(
//                              //                                                       onPressed: () {
//                              //                                                         // Navigator.pushReplacement(
//                              //                                                         //   context,
//                              //                                                         //   MaterialPageRoute(
//                              //                                                         //       builder: (context) => NewAdsScreen(
//                              //                                                         //             edit: true,
//                              //                                                         //             indexAd: 237,
//                              //                                                         //           )),
//                              //                                                         // );
//                              //                                                       },
//                              //                                                       icon: Icon(
//                              //                                                         Icons.edit,
//                              //                                                         color: Color(0xff7B217E),
//                              //                                                       )),
//                              //                                                   Text(
//                              //                                                     "تعديل الاعلان",
//                              //                                                     style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//                              //                                                   ),
//                              //                                                 ],
//                              //                                               ),
//                              //                                             ),
//                              //                                             Divider(),
//                              //                                             InkWell(
//                              //                                               onTap: () {
//                              //                                                 showModalBottomSheet(
//                              //                                                   context: context,
//                              //                                                   shape: RoundedRectangleBorder(
//                              //                                                     // <-- SEE HERE
//                              //                                                       borderRadius: BorderRadius.only(
//                              //                                                         topRight: Radius.circular(15),
//                              //                                                         topLeft: Radius.circular(15),
//                              //                                                       )),
//                              //                                                   builder: (context) {
//                              //                                                     return Container(
//                              //                                                         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                              //                                                         decoration: BoxDecoration(
//                              //                                                             borderRadius: BorderRadius.only(
//                              //                                                               topRight: Radius.circular(15),
//                              //                                                               topLeft: Radius.circular(15),
//                              //                                                             )),
//                              //                                                         height: 600.h,
//                              //                                                         width: double.infinity,
//                              //                                                         alignment: Alignment.center,
//                              //                                                         child: Column(
//                              //                                                           children: [
//                              //                                                             Row(
//                              //                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              //                                                               children: [
//                              //                                                                 SizedBox(
//                              //                                                                   width: 30.w,
//                              //                                                                 ),
//                              //                                                                 Text(
//                              //                                                                   "حذف الاعلان",
//                              //                                                                   style: TextStyle(color: Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
//                              //                                                                 ),
//                              //                                                                 IconButton(
//                              //                                                                   onPressed: () {
//                              //                                                                     Navigator.pop(context);
//                              //                                                                   },
//                              //                                                                   icon: SvgPicture.asset("images/close.svg"),
//                              //                                                                 ),
//                              //                                                               ],
//                              //                                                             ),
//                              //                                                             SizedBox(
//                              //                                                               height: 35.h,
//                              //                                                             ),
//                              //                                                             SvgPicture.asset("images/trash.svg"),
//                              //                                                             SizedBox(
//                              //                                                               height: 20.h,
//                              //                                                             ),
//                              //                                                             Center(
//                              //                                                               child: Text(
//                              //                                                                 "أنت على وشك حذف الاعلان بشكل نهائي هل تريد بالتأكيد حذف الاعلان ؟",
//                              //                                                                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
//                              //                                                               ),
//                              //                                                             ),
//                              //                                                             Spacer(),
//                              //                                                             Expanded(
//                              //                                                               child: Row(
//                              //                                                                 children: [
//                              //                                                                   InkWell(
//                              //                                                                     onTap: () async {
//                              //                                                                       setState(() {
//                              //                                                                         progss = true;
//                              //                                                                       });
//                              //
//                              //                                                                       await DeletId(context, id: _ads[index + 1].id!);
//                              //                                                                     },
//                              //                                                                     child: Container(
//                              //                                                                       height: 50.h,
//                              //                                                                       width: 165.w,
//                              //                                                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff7B217E)),
//                              //                                                                       child: Center(
//                              //                                                                         child: progss1
//                              //                                                                             ? CircularProgressIndicator(
//                              //                                                                           color: Colors.white,
//                              //                                                                         )
//                              //                                                                             : Text(
//                              //                                                                           "حذف الاعلان",
//                              //                                                                           style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                              //                                                                         ),
//                              //                                                                       ),
//                              //                                                                     ),
//                              //                                                                   ),
//                              //                                                                   SizedBox(
//                              //                                                                     width: 13.w,
//                              //                                                                   ),
//                              //                                                                   Container(
//                              //                                                                     height: 50.h,
//                              //                                                                     width: 165.w,
//                              //                                                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xff969696)),
//                              //                                                                     child: Center(
//                              //                                                                       child: Text(
//                              //                                                                         "تراجع",
//                              //                                                                         style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
//                              //                                                                       ),
//                              //                                                                     ),
//                              //                                                                   ),
//                              //                                                                 ],
//                              //                                                               ),
//                              //                                                             )
//                              //                                                           ],
//                              //                                                         ));
//                              //                                                   },
//                              //                                                 );
//                              //                                               },
//                              //                                               child: Row(
//                              //                                                 children: [
//                              //                                                   IconButton(
//                              //                                                       onPressed: () {},
//                              //                                                       icon: Icon(
//                              //                                                         Icons.delete,
//                              //                                                         color: Color(0xffE04F5F),
//                              //                                                       )),
//                              //                                                   Text(
//                              //                                                     "حذف الاعلان",
//                              //                                                     style: TextStyle(color: Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
//                              //                                                   ),
//                              //                                                 ],
//                              //                                               ),
//                              //                                             ),
//                              //                                             SizedBox(
//                              //                                               height: 35.h,
//                              //                                             ),
//                              //                                           ],
//                              //                                         ));
//                              //                                   },
//                              //                                 );
//                              //                               },
//                              //                               child: Icon(
//                              //                                 Icons.more_vert,
//                              //                                 color:
//                              //                                 Colors.white,
//                              //                               )),
//                              //                         )),
//                              //                   ),
//                              //                   Container(
//                              //                     margin: EdgeInsets
//                              //                         .only(
//                              //                         bottom: 10
//                              //                             .h,
//                              //                         right: 5
//                              //                             .w),
//                              //                     alignment: Alignment
//                              //                         .bottomRight,
//                              //                     child: Row(
//                              //                       children: [
//                              //                         CircleAvatar(
//                              //                           radius:
//                              //                           14,
//                              //                           backgroundImage: NetworkImage(user!
//                              //                               .imageProfile
//                              //                               .toString()),
//                              //                         ),
//                              //                         SizedBox(
//                              //                           width:
//                              //                           10.w,
//                              //                         ),
//                              //                         Text(
//                              //                           user!.name
//                              //                               .toString(),
//                              //                           style: TextStyle(
//                              //                               color: Color(
//                              //                                   0xffFFFFFF),
//                              //                               fontWeight: FontWeight
//                              //                                   .w900,
//                              //                               fontSize:
//                              //                               10.sp),
//                              //                         ),
//                              //                       ],
//                              //                     ),
//                              //                   )
//                              //                 ],
//                              //               ),
//                              //             );
//                              //           });
//                              //     } else if (snapshot.data!.isEmpty ||
//                              //         snapshot.data == null) {
//                              //       return Column(
//                              //         mainAxisAlignment:
//                              //         MainAxisAlignment.center,
//                              //         crossAxisAlignment:
//                              //         CrossAxisAlignment.center,
//                              //         children: [
//                              //           SizedBox(
//                              //             height: 80.h,
//                              //           ),
//                              //           SvgPicture.asset(
//                              //               "images/ads.svg"),
//                              //           SizedBox(
//                              //             height: 30.h,
//                              //           ),
//                              //           Text(
//                              //             'لا يوجد اعلانات في الوقت الحالي ',
//                              //             style: TextStyle(
//                              //                 fontSize: 20.sp,
//                              //                 fontWeight:
//                              //                 FontWeight.bold,
//                              //                 color: Color(0xff7B217E)),
//                              //           ),
//                              //         ],
//                              //       );
//                              //     } else {
//                              //       return Center(
//                              //         child: Icon(
//                              //           Icons.wifi_off_rounded,
//                              //           size: 80,
//                              //           color: Colors.purple,
//                              //         ),
//                              //       );
//                              //     }
//                              //   },
//                              // )
//                            ],
//                          ),
//                        )
//                      ]))
//            ],
//          ),
//        ));
//   }
//   Future DeletId(BuildContext context, {required int id}) async {
//     bool loggedIn = await UserApiController().DeletAds(context, id_dele: id);
//     if (loggedIn) {
//       setState(() {
//         progss = false;
//       });
//       Navigator.pop(context);
//       Navigator.pop(context);
//     }
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