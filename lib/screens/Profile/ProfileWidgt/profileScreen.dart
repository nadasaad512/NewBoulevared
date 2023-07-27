import 'package:new_boulevard/api/User_Controller.dart';
import 'package:new_boulevard/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../loed/loed.dart';
import '../../../provider/app_provider.dart';
import '../../../Shared_Preferences/User_Preferences.dart';
import '../../../component/main_bac.dart';
import '../../../models/user.dart';
import '../widget/AdaminAsUserShow.dart';
import '../widget/AdmainAD.dart';
import '../widget/AdmainOneAD.dart';
import 'allFollower.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {


  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).getProfile();
    Provider.of<AppProvider>(context, listen: false).getAllUserFollow();
    Provider.of<AppProvider>(context, listen: false).getAllADS_Admain();
    return UserPreferences().token == ''
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لتتمكن من الاستفادة من خدامتنا سجل الان ',
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7B217E),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: Text(
                    'انشاء  حساب  الان ',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          )
        :
    Consumer<AppProvider>(builder: (context, provider, _) {
      return


      provider.user==null?
          SizedBox.shrink():
        provider.user!.type == "advertiser"
          ? Back_Ground(
          Bar: true,
          edit: true,
          EditAdmain: true,
          childTab:provider.user!.name,
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
                          backgroundImage: provider.user!.imageProfile !=
                              null
                              ? NetworkImage(
                              provider.user!.imageProfile!)
                              : null),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        provider.user!.name,
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
                                  builder: (context) =>
                                      AllFollower(
                                        id: provider.user!.id,
                                      )));
                        },
                        child: Container(
                          height: 38.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: const Color(0xff969696),
                              borderRadius:
                              BorderRadius.circular(37)),
                          child: Center(
                            child: Text(
                              " ${provider.user!.followMeCount} متابع",
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
                        color: const Color(0xff7B217E),
                        borderRadius: BorderRadius.circular(5)),
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xff7B217E),
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
                                      horizontal: 16.w,
                                      vertical: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    color: Colors.purple.shade50,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 20.h),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {

                                            launchUrl(Uri.parse(
                                                "whatsapp://send?phone=${provider.user!.mobile ?? ""}&text=${"Hi"}"));


                                          },
                                          child: Detatlies(
                                              name: provider.user!.mobile,
                                              image:
                                              "images/phone.svg"),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            launch(
                                                "mailto:${provider.user!.email}");
                                          },
                                          child: Detatlies(
                                              name: provider.user!.email,
                                              image:
                                              "images/gmail.svg"),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        provider.user!.website != null
                                            ? InkWell(
                                          onTap: () {
                                            launch(provider.user!
                                                .website!);
                                          },
                                          child: Detatlies(
                                              name: provider.user!
                                                  .website!,
                                              image:
                                              "images/earth.svg"),
                                        )
                                            : const Text(""),
                                        SizedBox(
                                          height: 26.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            provider.user!.twitter !=
                                                null
                                                ? InkWell(
                                              onTap: () {
                                                launch(provider.user!
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
                                            provider.user!.instagram !=
                                                null
                                                ? InkWell(

                                              onTap: () {


                                                launch(provider.user!
                                                    .instagram!);
                                              },
                                              child: SvgPicture
                                                  .asset(
                                                  "images/instegram.svg"),
                                            )
                                                : const Text(""),
                                            SizedBox(
                                              width: 26.w,
                                            ),
                                            provider.user!.whatsapp !=
                                                null
                                                ? InkWell(
                                              onTap: () {

                                                launchUrl(Uri.parse(
                                                    "whatsapp://send?phone=${provider.user!.mobile ?? ""}&text=${"Hi"}"));
                                              },
                                              child: SvgPicture
                                                  .asset(
                                                  "images/whatsapp.svg"),
                                            )
                                                : const Text(""),
                                            SizedBox(
                                              width: 26.w,
                                            ),
                                            provider.user!.facebook !=
                                                null
                                                ? InkWell(
                                              onTap: () {
                                                launch(provider.user!
                                                    .facebook!);
                                              },
                                              child: SvgPicture
                                                  .asset(
                                                  "images/facebook.svg"),
                                            )
                                                : const Text(""),
                                            SizedBox(
                                              width: 26.w,
                                            ),
                                            provider.user!.website !=
                                                null
                                                ? InkWell(
                                              onTap: () {
                                                launch(provider.user!
                                                    .website!);
                                              },
                                              child: SvgPicture
                                                  .asset(
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
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
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
                                            top: 5.h),
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xff7B217E),
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                            image:
                                            const DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                NetworkImage(
                                                    ""))),
                                        child: Center(
                                            child: Container(
                                              margin:
                                              EdgeInsets.symmetric(
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
                                                        color:
                                                        Colors.white,
                                                        size: 60.sp,
                                                      )),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    "إضافة إعلان",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
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
                                    AdmainOneAdScreen()
                                  ],
                                ),
                                AdmainAdScreen()
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
                      backgroundColor: Color(0xff7B217E),
                      backgroundImage:
                     provider.user!.imageProfile == null
                          ? null
                          : NetworkImage(
                         provider.user!.imageProfile!),
                      child:  provider.user!.imageProfile == null?
                      Icon(Icons.person,color: Colors.white,size: 30.sp,):
                      SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      provider.user!.name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      height: 38.h,
                      width: 87.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff18499A),
                          borderRadius:
                          BorderRadius.circular(37)),
                      child: Center(
                        child: Text(
                          provider.user!.pointsCount == null
                              ? "0"
                              : "${provider.user!.pointsCount!.toString()} نقطة",
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
                            color: const Color(0xff7B217E),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.FolowUser.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserShowAdmain(
                                      id: int.parse(provider.FolowUser[index].id!))),
                        );
                      },
                      child: Container(
                          width: 343.w,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h),
                          decoration: BoxDecoration(
                              color:
                              const Color(0xffD1D1D6),
                              borderRadius:
                              BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 5.w),
                            child: Card(
                              child: Container(
                                  margin:
                                  EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:
                                          70.w,
                                          height:
                                          71.h,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]!,
                                              borderRadius: BorderRadius.circular(
                                                  5),
                                              image: provider.FolowUser[index].imageProfile != null
                                                  ? DecorationImage(fit: BoxFit.cover, image: NetworkImage(provider.FolowUser[index].imageProfile!))
                                                  : null)),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            provider.FolowUser[index]
                                                .name!,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 18.sp),
                                          ),
                                          SizedBox(
                                            height:
                                            10.h,
                                          ),
                                          Container(
                                            height:
                                            27.h,
                                            width:
                                            56.w,
                                            decoration: BoxDecoration(
                                                color:
                                                const Color(0xff969696),
                                                borderRadius: BorderRadius.circular(13)),
                                            child:
                                            Center(
                                              child:
                                              Text(
                                                "${provider.FolowUser[index].followMeCount.toString()} متابع",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap:
                                            () async {

                                          await provider.unfollow(int.parse(provider.FolowUser[index].id.toString()));
                                        },
                                        child:
                                        Container(
                                          height:
                                          27.h,
                                          width:
                                          71.w,
                                          decoration: BoxDecoration(
                                              color: const Color(
                                                  0xff18499A),
                                              borderRadius:
                                              BorderRadius.circular(40)),
                                          child:
                                          Center(
                                            child:
                                            Text(
                                              "إلغاء متابعة",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          )),
                    );
                  },
                )
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
        Text(
          name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}




