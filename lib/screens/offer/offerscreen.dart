import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/detalies.dart';
import '../../story/OneStory.dart';

class OfferScreen extends StatelessWidget {
  String nameoffer;
  List<Ads> offerad;

  OfferScreen({required this.nameoffer, required this.offerad});

  @override
  Widget build(BuildContext context) {
    return Back_Ground(
      back: true,
      Bar: true,
      eror: true,
      childTab: nameoffer,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: offerad.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 98.w / 160.h,
            crossAxisCount: 2,
            mainAxisSpacing: 14.h),
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(right: 5.w),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoryPage(
                              AdId: offerad[index].id!,
                            )),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: offerad[index].image.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.only(left: 12.w),
                    width: 130.w,
                    decoration: BoxDecoration(
                        color: Colors.grey[300]!,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider)),
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
                          margin: EdgeInsets.only(bottom: 10.h, right: 5.w),
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              offerad[index].advertiser!.imageProfile != null
                                  ? CircleAvatar(
                                      radius: 14,
                                      backgroundImage: NetworkImage(
                                          offerad[index]
                                              .advertiser!
                                              .imageProfile
                                              .toString()),
                                    )
                                  : CircleAvatar(
                                      radius: 12.sp,
                                      backgroundColor: Color(0xff7B217E),
                                      child: Icon(
                                        Icons.person_rounded,
                                        color: Colors.white,
                                        size: 15.sp,
                                      )),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                offerad[index].advertiser!.name.toString(),
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
