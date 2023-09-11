import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api/User_Controller.dart';
import '../../../loed/loed.dart';
import '../../../models/Folllowers_Advertiser.dart';
//User followe
class Followers_Advertiser extends StatefulWidget{
late  int id;
  Followers_Advertiser({required this.id});
  @override
  State<Followers_Advertiser> createState() => _Followers_AdvertiserState();
}

class _Followers_AdvertiserState extends State<Followers_Advertiser> {
  List<MyFollowers> _folow = [];

  @override
  Widget build(BuildContext context) {
    return     FutureBuilder<List<MyFollowers>>(
      future: UserApiController().Followers_Advertiser(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoedWidget();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          _folow = snapshot.data ?? [];
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _folow.length,
            itemBuilder: (context, index) {
              return Container(width: 343.w, margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                        child: Row(
                          children: [
                            Container(
                              width: 70.w,
                              height: 71.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      _folow[index].imageProfile!,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  _folow[index].name!,
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.w400,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),


                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                await UserApiController()
                                    .Follow_One(
                                    followed_id:
                                    _folow[index]
                                        .id
                                        .toString(),
                                    action: "unfollow");
                              },
                              child: Container(
                                height: 27.h,
                                width: 71.w,
                                decoration: BoxDecoration(
                                    color:
                                    Color(0xff18499A),
                                    borderRadius:
                                    BorderRadius
                                        .circular(40)),
                                child: Center(
                                  child: Text(
                                    "إلغاء متابعة",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight
                                            .w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          );
        } else {
          return Center(
            child: Text(
              'لا يوجد متابعين,,, ',
              style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.w600),
            ),
          );
        }
      },
    );
  }
}