import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/ads.dart';
import '../models/detalies.dart';
import '../screens/Details/ad_story_screen.dart';
import '../screens/Profile/widget/AdaminAsUserShow.dart';
import '../screens/maps/location.dart';

class ImageStoryScreen extends StatefulWidget {
  story1 StroryData;
  AnimationController animController;
  int currentPage;
  List<story1> data;
  Ads ad;
  ImageStoryScreen({
    required this.StroryData,
    required this.animController,
    required this.currentPage,
    required this.data,
    required this.ad,
  });
  @override
  State<ImageStoryScreen> createState() => _ImageStoryScreenState();
}

class _ImageStoryScreenState extends State<ImageStoryScreen>
    with SingleTickerProviderStateMixin {
  double heightImg = 0;
  double widthImg = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calculateImageDimension(image1: widget.StroryData.file.toString())
        .then((value) {
      heightImg = value.height;
      widthImg = value.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightImg.h,
      width: widthImg.w,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(widget.StroryData.file.toString()),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 45.0,
              left: 10.0,
              right: 10.0,
              child: Column(children: <Widget>[
                Row(
                  children: widget.data
                      .asMap()
                      .map((i, e) {
                        return MapEntry(
                          i,
                          AnimatedBar(
                            animController: widget.animController,
                            position: i,
                            currentIndex: widget.currentPage,
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ])),
          Positioned(
            top: 60.0,
            left: 15.0,
            right: 15.0,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    widget.animController.stop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserShowAdmain(
                                  id: widget.ad.advertiser!.id!,
                                )));
                  },
                  child: Row(
                    children: [
                      widget.ad.advertiser==null?
                          SizedBox.shrink():
                  widget.ad.advertiser!.imageProfile == null?
                  CircleAvatar(radius: 21.sp,
                      backgroundColor: Color(0xff7B217E),
                      child: Icon(Icons.person_rounded,color: Colors.white,
                        size: 15.sp,)):
                      CircleAvatar(
                          radius: 21.sp,
                          backgroundImage:
                              NetworkImage(
                                      widget.ad.advertiser!.imageProfile.toString())
                                  ),

                      SizedBox(
                        width: 10.w,
                      ),
                      widget.ad.advertiser==null?
                          SizedBox.shrink():
                      Text(
                        widget.ad.advertiser!.name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 12.sp,
                    child: Center(
                      child: Icon(
                        Icons.close_rounded,
                        size: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 34.w,
            left: 34.w,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )),
                  builder: (context) {
                    var ad = widget.ad;
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )),
                        height: 520.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ListView(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "وصف الإعلان",
                                  style: TextStyle(
                                      color: const Color(0xff7B217E),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: SvgPicture.asset("images/close.svg"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ad.details != null
                                ? Text(
                                    ad.details!,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Container(),
                            SizedBox(
                              height: 12.h,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.location_on,
                                      color: const Color(0xff7B217E),
                                      size: 30.sp,
                                    )),
                                Text(
                                  " السعودية-   ${ad.city!.name.toString()}",
                                  style: TextStyle(
                                      color: const Color(0xff7B217E),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            MapScreen(
                                latitud: double.parse(ad.latitude!),
                                longitud: double.parse(ad.longitude!)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: 343.w,
                              height: 100.h,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.purple.shade50,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                child: Column(
                                  children: [
                                    ad.store_url == null
                                        ? Container()
                                        : Detatlies(
                                            name: "الموقع",
                                            image: "images/earth.svg"),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ad.twitter == null
                                            ? Container()
                                            : Social(
                                                image: "images/twitter.svg",
                                                link: ad.twitter.toString()),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        ad.instagram == null
                                            ? Container()
                                            : Social(
                                                image: "images/instegram.svg",
                                                link: ad.instagram.toString()),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        ad.whatsapp == null
                                            ? Container()
                                            : Social(
                                                image: "images/whatsapp.svg",
                                                link: "${ad.whatsapp}",
                                                isWhatsapp: true,
                                                context: context),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        ad.facebook == null
                                            ? Container()
                                            : Social(
                                                image: "images/facebook.svg",
                                                link: ad.facebook.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                  },
                );
              },
              child: Container(
                width: 308.w,
                height: 38.h,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                  child: Row(
                    children: [
                      SvgPicture.asset("images/show.svg"),
                      SizedBox(
                        width: 10.w,
                      ),
                      const Text(
                        'اسحب للأعلى لمعرفة المزيد عن الإعلان',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Size> _calculateImageDimension({required String image1}) {
    Completer<Size> completer = Completer();
    Image image = Image.network(image1);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  Widget Detatlies({required String name, required String image}) {
    return InkWell(
      onTap: () {
        widget.animController.stop();

        launch(name);
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SvgPicture.asset(image),
            SizedBox(
              width: 10.w,
            ),
            Text(
              name,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget Social(
      {required String link,
      required String image,
      BuildContext? context,
      isWhatsapp = false}) {
    return InkWell(
        onTap: () {
          if (isWhatsapp) {
            widget.animController.stop();
            launch(link);
          } else {
            _launchWhatsapp(context: context, number: link);
          }
        },
        child: SvgPicture.asset(image));
  }

  Widget MapScreen({required double latitud, required double longitud}) {
    return Container(
      height: 125.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: location(latitude: latitud, longitude: longitud),
    );
  }
}

_launchWhatsapp({number, context}) async {
  var whatsapp = number;
  var whatsappAndroid = Uri.parse("?phone=$whatsapp&text=hello");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("WhatsApp is not installed on the device"),
      ),
    );
  }
}
