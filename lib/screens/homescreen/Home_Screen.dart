import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_boulevard/screens/homescreen/widget/ImageRotater.dart';
import 'package:new_boulevard/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../Shared_Preferences/User_Preferences.dart';
import '../../loed/loed.dart';
import '../../models/detalies.dart';
import '../../provider/app_provider.dart';
import '../../story/ListStory.dart';
import '../../story/OneStory.dart';
import '../../component/main_bac.dart';
import '../PARTBar/detalies.dart';
import '../offer/offerscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers {
  List<Ads> offerad = [];
  bool isDone = false;
  final ScrollController _scrollController = ScrollController();

  loed(AppProvider provider) async {
    await provider.getAllBanner();
    await provider.getAllCategory();
    await provider.getAllSpecialAds();
    await provider.getAllBestTenAds();
    await provider.getAllOffer();
    await provider.getAllListStory();
    provider.notifyListeners();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).isEdit = false;
    return Back_Ground(
        childTab: "الرئيسية",
        ad: true,
        child: Consumer<AppProvider>(builder: (context, provider, _) {
          return
            provider.categories.isNotEmpty?
            RefreshIndicator(
            color: Colors.purple,
            onRefresh: () async {
              await loed(provider);

              await Future.delayed(Duration(milliseconds: 1500));
              await provider.getAllNotification();
              if (provider.massages.isNotEmpty) {
                for (int i = 0; i < provider.massages.length; i++) {
                  Flushbar(
                    messageText: Text(
                      provider.massages[i].message.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
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
                    margin:
                        EdgeInsets.only(top: 100.h, right: 10.w, left: 10.w),
                    flushbarPosition: FlushbarPosition.TOP,
                    leftBarIndicatorColor: Colors.white,
                  )..show(context);

                  await Future.delayed(Duration(seconds: 3));
                }
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              child: provider.categories == []
                  ? LoedWidget()
                  : ListView(
                      children: [
                        provider.banners.isNotEmpty
                            ? SizedBox(
                                height: 150.h,
                                child: CasualImageSlider(
                                    scrollController: _scrollController,
                                    imageUrls: provider.banners))
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 16.h,
                        ),
                        provider.folow.isNotEmpty
                            ? SizedBox(
                                height: 110.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.folow.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        int i = index;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListStoryScreen(
                                                      PageFollowing:
                                                          provider.folow,
                                                      initialindex: index,
                                                    )));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 12.w),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                begin: AlignmentDirectional
                                                    .centerStart,
                                                end: AlignmentDirectional
                                                    .centerEnd,
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
                                                  radius: 38.sp,
                                                  backgroundColor:
                                                      Colors.grey[300]!,
                                                  backgroundImage: provider
                                                              .folow[index]
                                                              .imageProfile !=
                                                          null
                                                      ? NetworkImage(provider
                                                          .folow[index]
                                                          .imageProfile!)
                                                      : null),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 12.w),
                                            child: Text(
                                              provider.folow[index].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ))
                            : SizedBox.shrink(),
                        provider.special_ads.isNotEmpty
                            ? Row(
                                children: [
                                  Text(
                                    "الإعلانات المميزة",
                                    style: TextStyle(
                                        color: Color(0xff7B217E),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: Color(0xff7B217E),
                                    size: 30.sp,
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/SpeciaScreen');
                                    },
                                    child: Text(
                                      "عرض الجميع",
                                      style: TextStyle(
                                          color: Color(0xffC4C4C4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 16.h,
                        ),
                        provider.special_ads.isNotEmpty
                            ? SizedBox(
                                height: 220.h,
                                width: 300.w,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.special_ads.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => StoryPage(
                                                      AdId: provider
                                                          .special_ads[index]
                                                          .id!,
                                                    )),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: provider
                                              .special_ads[index].image
                                              .toString(),

                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            margin: EdgeInsets.only(left: 12.w),
                                            height: 220.h,
                                            width: 150.w,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300]!,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imageProvider)),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.star_rounded,
                                                      color: Color(0xffFFCC46),
                                                      size: 25.sp,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.h, right: 5.w),
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Row(
                                                    children: [
                                                      provider
                                                                  .special_ads[
                                                                      index]
                                                                  .advertiser!
                                                                  .imageProfile !=
                                                              null
                                                          ? CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      300]!,
                                                              radius: 14,
                                                              backgroundImage:
                                                                  NetworkImage(provider
                                                                      .special_ads[
                                                                          index]
                                                                      .advertiser!
                                                                      .imageProfile
                                                                      .toString()),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 12.sp,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff7B217E),
                                                              child: Icon(
                                                                Icons
                                                                    .person_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 15.sp,
                                                              )),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        provider
                                                            .special_ads[index]
                                                            .advertiser!
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffFFFFFF),
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 16.h,
                        ),
                        provider.categories.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "الأقسام",
                                    style: TextStyle(
                                        color: Color(0xff7B217E),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/PartScreen');
                                    },
                                    child: Text(
                                      "عرض الجميع",
                                      style: TextStyle(
                                          color: Color(0xffC4C4C4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 16.h,
                        ),
                        provider.categories.isNotEmpty
                            ? SizedBox(
                                height: 230.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailesScreen(
                                                      name: provider
                                                          .categories[index]
                                                          .name
                                                          .toString(),
                                                      idcat: int.parse(provider
                                                          .categories[index].id
                                                          .toString()),
                                                    )),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                          CachedNetworkImage(
                                          imageUrl: provider.categories[index].image.toString(),
                                          imageBuilder: (context, imageProvider) =>  Container(
                                            width: 130.w,
                                            height: 190.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300]!,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imageProvider)),
                                          ),),


                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Center(
                                              child: Text(
                                                provider.categories[index].name
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xff7B217E),
                                                  fontWeight: FontWeight.normal,

                                                  // fontSize: 18.sp
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  },
                                  separatorBuilder: (BuildContext, index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                        provider.BestAds != null && provider.BestAds!.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 16.h),
                                child: Row(
                                  children: [
                                    Text(
                                      " أفضل إعلانات الشهر  ",
                                      style: TextStyle(
                                          color: Color(0xff7B217E),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/BestTenScreen');
                                      },
                                      child: Text(
                                        "عرض الجميع",
                                        style: TextStyle(
                                            color: Color(0xffC4C4C4),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                        provider.BestAds != null
                            ? SizedBox(
                                height: 200.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.BestAds!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StoryPage(
                                                    AdId: provider
                                                        .BestAds![index].id!,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 12.w),
                                        width: 130.w,
                                        //height: 190.h,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300]!,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(provider
                                                    .BestAds![index].image
                                                    .toString()))),

                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 10.h, right: 5.w),
                                              alignment: Alignment.bottomRight,
                                              child: Row(
                                                children: [
                                                  provider
                                                              .BestAds![index]
                                                              .advertiser!
                                                              .imageProfile !=
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 14,
                                                          backgroundImage:
                                                              NetworkImage(provider
                                                                  .BestAds![
                                                                      index]
                                                                  .advertiser!
                                                                  .imageProfile!
                                                                  .toString()),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 12.sp,
                                                          backgroundColor:
                                                              Color(0xff7B217E),
                                                          child: Icon(
                                                            Icons
                                                                .person_rounded,
                                                            color: Colors.white,
                                                            size: 15.sp,
                                                          )),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    provider.BestAds![index]
                                                        .advertiser!.name
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffFFFFFF),
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 16.h,
                        ),
                        provider.offer != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: provider.offer!.length,
                                itemBuilder: (context, index) {
                                  offerad = provider.offer![index].ads!;
                                  return Column(
                                    children: [
                                      provider.BestAds != null &&
                                              provider.BestAds!.isNotEmpty
                                          ? Row(
                                              children: [
                                                Text(
                                                  provider.offer![index].name
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff7B217E),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OfferScreen(
                                                                nameoffer: provider
                                                                    .offer![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                offerad:
                                                                    offerad,
                                                              )),
                                                    );
                                                  },
                                                  child: Text(
                                                    "عرض الجميع",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffC4C4C4),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox.shrink(),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      SizedBox(
                                        height: 200.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: provider
                                              .offer![index].ads!.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StoryPage(
                                                            AdId: offerad[index]
                                                                .id!,
                                                          )),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:offerad[index].image.toString(),
                                                imageBuilder: (context, imageProvider) =>   Container(
                                                  margin:
                                                  EdgeInsets.only(left: 12.w),
                                                  width: 130.w,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300]!,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:imageProvider)),

                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        Alignment.topLeft,
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.star_rounded,
                                                            color:
                                                            Color(0xffFFCC46),
                                                            size: 25.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10.h,
                                                            right: 5.w),
                                                        alignment:
                                                        Alignment.bottomRight,
                                                        child: Row(
                                                          children: [
                                                            offerad[index]
                                                                .advertiser!
                                                                .imageProfile !=
                                                                null
                                                                ? CircleAvatar(
                                                              radius: 14,
                                                              backgroundColor:
                                                              Colors.grey[
                                                              300]!,
                                                              backgroundImage: NetworkImage(offerad[
                                                              index]
                                                                  .advertiser!
                                                                  .imageProfile
                                                                  .toString()),
                                                            )
                                                                : CircleAvatar(
                                                                radius: 12.sp,
                                                                backgroundColor:
                                                                Colors.grey[
                                                                300]!,
                                                                child: Icon(
                                                                  Icons
                                                                      .person_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.sp,
                                                                )),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              offerad[index]
                                                                  .advertiser!
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffFFFFFF),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                                  fontSize:
                                                                  10.sp),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),),




                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : SizedBox.shrink()
                      ],
                    ),
            ),
          ):
            LoedWidget();
        }));
  }
}
