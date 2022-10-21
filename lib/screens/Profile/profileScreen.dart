import 'package:new_boulevard/api/User_Controller.dart';
import 'package:new_boulevard/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/main_bac.dart';

import '../../models/Follower_user.dart';
import '../../models/ads.dart';
import '../../models/user.dart';
import '../allAds/new_ads.dart';
import 'ProfileWidgt/AdvertiserProfile.dart';
import 'ProfileWidgt/UserProfile.dart';
import 'ProfileWidgt/User_Show_Admain.dart';
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
                ? AdvertiserProfileScreen(user: user!,)
                : UserProfileScreen(user: user!,);
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


