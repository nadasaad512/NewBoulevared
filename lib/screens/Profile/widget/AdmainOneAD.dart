
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_provider.dart';
import '../../../story/OneStory.dart';
import '../../allAds/new_ads.dart';

class AdmainOneAdScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Consumer<AppProvider>(builder: (context, provider, _) {
    return
      provider.AdmainAd.isEmpty||provider.AdmainAd==[]?
        SizedBox.shrink():
      provider.AdmainAd[0].adType!.type ==
          "special"
          ? InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder:
                    (context) =>
                    storyPageScreen(
                      AdId: provider.AdmainAd[0].id!,
                    )),
          );
        },
        child: Container(
          margin: EdgeInsets
              .only(
              top: 5.h,
              right:
              5.w,
              left:
              5.w),
          width: 170.w,
          height: 170.h,
          decoration: BoxDecoration(
              color: const Color(
                  0xff7B217E),
              borderRadius:
              BorderRadius
                  .circular(
                  5),
              image: DecorationImage(
                  fit: BoxFit
                      .cover,
                  image: NetworkImage(provider.AdmainAd[
                  0]
                      .image
                      .toString()))),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 10
                        .w,
                    top: 10
                        .h),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor:
                      const Color(0xff7B217E),
                      radius:
                      14.sp,
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                // <-- SEE HERE
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  )),
                              builder: (context) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                    decoration: const BoxDecoration(
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
                                              style: TextStyle(color: const Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
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
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => NewAdsScreen(
                                                    edit: true,
                                                    indexAd: provider.AdmainAd[0].id!,
                                                  )),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {

                                                  },
                                                  icon: const Icon(
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
                                        const Divider(),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              shape: const RoundedRectangleBorder(
                                                // <-- SEE HERE
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(15),
                                                    topLeft: Radius.circular(15),
                                                  )),
                                              builder: (context) {
                                                return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                    decoration: const BoxDecoration(
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
                                                              style: TextStyle(color: const Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
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
                                                            "أنت على وشك حذف الاعلان بشكل نهائيهل تريد بالتأكيد حذف الاعلان ؟",
                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () async {
                                                                await  provider. DeletId(context, id: provider.AdmainAd[0].id!);
                                                                },
                                                                child: Container(
                                                                  height: 50.h,
                                                                  width: 165.w,
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xff7B217E)),
                                                                  child: Center(
                                                                    child: provider.progss
                                                                        ? const CircularProgressIndicator(
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
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xff969696)),
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
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Color(0xffE04F5F),
                                                  )),
                                              Text(
                                                "حذف الاعلان",
                                                style: TextStyle(color: const Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
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
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          )),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 10
                        .h,
                    right: 5
                        .w),
                alignment:
                Alignment
                    .bottomRight,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius:
                      14,
                      backgroundImage: NetworkImage(provider.user!
                          .imageProfile
                          .toString()),
                    ),
                    SizedBox(
                      width:
                      10.w,
                    ),
                    Text(
                      provider.user!
                          .name
                          .toString(),
                      style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w900,
                          fontSize: 10.sp),
                    ),
                  ],
                ),
              )
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
                      AdId: provider.AdmainAd[0].id!,
                    )),
          );
        },
        child: Container(
          margin: EdgeInsets
              .only(
              top: 5.h,
              right:
              5.w,
              left:
              5.w),
          width: 170.w,
          height: 170.h,
          decoration: BoxDecoration(
              color: const Color(
                  0xff7B217E),
              borderRadius:
              BorderRadius
                  .circular(
                  5),
              image: DecorationImage(
                  fit: BoxFit
                      .cover,
                  image: NetworkImage(provider.AdmainAd[
                  0]
                      .image
                      .toString()))),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 10
                        .w,
                    top: 10
                        .h),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor:
                      const Color(0xff7B217E),
                      radius:
                      14.sp,
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                // <-- SEE HERE
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  )),
                              builder: (context) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                    decoration: const BoxDecoration(
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
                                              style: TextStyle(color: const Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
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
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => NewAdsScreen(
                                                    edit: true,
                                                    indexAd: provider.AdmainAd[0].id!,
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
                                                  icon: const Icon(
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
                                        const Divider(),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              shape: const RoundedRectangleBorder(
                                                // <-- SEE HERE
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(15),
                                                    topLeft: Radius.circular(15),
                                                  )),
                                              builder: (context) {
                                                return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                                    decoration: const BoxDecoration(
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
                                                              style: TextStyle(color: const Color(0xff7B217E), fontSize: 18.sp, fontWeight: FontWeight.w600),
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
                                                            "أنت على وشك حذف الاعلان بشكل نهائيهل تريد بالتأكيد حذف الاعلان ؟",
                                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () async {

                                                                  await provider.DeletId(context, id: provider.AdmainAd[0].id!);
                                                                },
                                                                child: Container(
                                                                  height: 50.h,
                                                                  width: 165.w,
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xff7B217E)),
                                                                  child: Center(
                                                                    child: provider.progss
                                                                        ? const CircularProgressIndicator(
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
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xff969696)),
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
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Color(0xffE04F5F),
                                                  )),
                                              Text(
                                                "حذف الاعلان",
                                                style: TextStyle(color: const Color(0xffE04F5F), fontSize: 16.sp, fontWeight: FontWeight.w600),
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
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          )),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 10
                        .h,
                    right: 5
                        .w),
                alignment:
                Alignment
                    .bottomRight,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius:
                      14,
                      backgroundImage: NetworkImage(provider.user!
                          .imageProfile
                          .toString()),
                    ),
                    SizedBox(
                      width:
                      10.w,
                    ),
                    Text(
                      provider.user!
                          .name
                          .toString(),
                      style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w900,
                          fontSize: 10.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );


    });

  }

}