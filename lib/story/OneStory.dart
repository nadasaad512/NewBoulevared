import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:new_boulevard/screens/Profile/ProfileWidgt/profileScreen.dart';
import 'package:new_boulevard/screens/maps/location.dart';
import 'package:new_boulevard/story/imageitem.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import '../api/User_Controller.dart';
import '../models/ads.dart';
import '../models/detalies.dart';



class StoryPage extends StatefulWidget {
  int AdId;

  StoryPage({required this.AdId});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  int CurrentPage = 0;
  late PageController pageController;
  late AnimationController animController;
  List<story1> StroryData = [];
  late VideoPlayerController controller;
  Ads ad = Ads();
  bool start = false;
  bool end = false;
  var splitted;
  var houres;
  var mint;
  var second;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    pageController = PageController();
    animController = AnimationController(vsync: this);
    controller = VideoPlayerController.network("");
    controller.initialize();
    UserApiController().AdDetalies(idAD: widget.AdId).then((value) {
      setState(() {
        ad = value;
        StroryData = List.from(value.adImages!)
          ..addAll(List.from(value.adVideos!));
      });
      setState(() {
        StroryData;
      });
    });
  }
  @override
  void dispose() {
    Wakelock.disable();
    pageController.dispose();
    controller.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: StroryData.length,
        onPageChanged: (int currentPage) {
          setState(() {
            CurrentPage = currentPage;
          });
        },
        itemBuilder: (BuildContext, index) {
          if (StroryData[CurrentPage].type == "image") {
            controller.dispose();
            animController.stop();
            animController.reset();
            animController.duration = Duration(seconds: 10);
            animController.forward().whenComplete(() {
                CurrentPage < StroryData.length - 1
                    ? pageController.jumpToPage(CurrentPage + 1)
                    : Navigator.pop(context);

            });

            return GestureDetector(
                onTapDown: (details) => _onTapDown(details),
                child: ImageStoryScreen(
                  StroryData: StroryData[CurrentPage],
                  animController: animController,
                  currentPage: CurrentPage,
                  data: StroryData,
                  ad: ad,
                ));
          } else {
            loedvideo();
            return GestureDetector(
              onTapDown: (details) => _onTapDown2(details),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio:
                            double.parse(StroryData[CurrentPage].width!).w /
                                double.parse(StroryData[CurrentPage].height!).h,
                        child: VideoPlayer(controller),
                      ),
                    ),
                    Positioned(
                        top: 45.0,
                        left: 10.0,
                        right: 10.0,
                        child: Column(children: <Widget>[
                          Row(
                            children: StroryData.asMap()
                                .map((i, e) {
                                  return MapEntry(
                                    i,
                                    AnimatedBar(
                                      animController: animController,
                                      position: i,
                                      currentIndex: CurrentPage,
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
                              controller.pause();
                              animController.stop();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserShowAdmain(
                                            id: ad.advertiser!.id!,
                                          )));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 21.sp,
                                    backgroundImage:
                                        ad.advertiser!.imageProfile != null
                                            ? NetworkImage(
                                                ad.advertiser!.imageProfile!)
                                            : null),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  ad.advertiser!.name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )),
                            builder: (context) {
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 16.h),
                                  decoration: BoxDecoration(
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
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: SvgPicture.asset(
                                                "images/close.svg"),
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
                                                color: Color(0xff7B217E),
                                                size: 30.sp,
                                              )),
                                          Text(
                                            " السعودية-   ${ad.city!.name.toString()}",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
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
                                          longitud:
                                              double.parse(ad.longitude!)),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        width: 343.w,
                                        height: 100.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 12.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                      name: ad.store_url!,
                                                      image:
                                                          "images/earth.svg"),
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
                                                          image:
                                                              "images/twitter.svg",
                                                          link: ad.twitter
                                                              .toString()),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  ad.instagram == null
                                                      ? Container()
                                                      : Social(
                                                          image:
                                                              "images/instegram.svg",
                                                          link: ad.instagram
                                                              .toString()),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  ad.whatsapp == null
                                                      ? Container()
                                                      : Social(
                                                          image:
                                                              "images/whatsapp.svg",
                                                          link:
                                                              "https://wa.me/${ad.whatsapp}/?text=${Uri.parse("Hi")}"),
                                                  SizedBox(
                                                    width: 26.w,
                                                  ),
                                                  ad.facebook == null
                                                      ? Container()
                                                      : Social(
                                                          image:
                                                              "images/facebook.svg",
                                                          link: ad.facebook
                                                              .toString()),
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 12.w),
                            child: Row(
                              children: [
                                SvgPicture.asset("images/show.svg"),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'اسحب للأعلى لمعرفة المزيد عن الإعلان',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future forward5Seconds() async => goToPosition(
      (currentPosition) => currentPosition + Duration(seconds: 10));

  Future rewind5Seconds() async => goToPosition(
      (currentPosition) => currentPosition - Duration(seconds: 10));

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition!);

    newPosition <= Duration(hours: 0, minutes: 0, seconds: 10)
        ? start = true
        : start = false;
    print("newPosition$newPosition");
    print("controller.value.duration${controller.value.duration}");
    newPosition >= controller.value.duration ? end = true : end = false;

    await controller.seekTo(newPosition);
  }

  void _onTapDown2(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (end == true) {
        if (CurrentPage < StroryData.length - 1) {
          pageController.jumpToPage(CurrentPage + 1);
        } else {
          print("1");
          controller.dispose();
          Navigator.pop(context);
        }
      } else {
        print("nada");
        forward5Seconds();
        if (controller.value.isInitialized) {
          final int duration = controller.value.duration.inMilliseconds;
          final int position = controller.value.position.inMilliseconds;
          int maxBuffering = 0;
          for (final DurationRange range in controller.value.buffered) {
            final int end = range.end.inMilliseconds;
            if (end > maxBuffering) {
              maxBuffering = end;
            }
          }
          animController.stop();
          animController.reset();
          animController.value = position / duration;
        }

        animController.forward().whenComplete(() {
          if (CurrentPage < StroryData.length - 1) {
            pageController.jumpToPage(CurrentPage + 1);
          } else {
            print("2");
            controller.dispose();
            Navigator.pop(context);
          }
        });
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (start) {
        if (CurrentPage > 0) {
          pageController.jumpToPage(CurrentPage - 1);
        }
      } else {
        rewind5Seconds();
        if (controller.value.isInitialized) {
          final int duration = controller.value.duration.inMilliseconds;
          final int position = controller.value.position.inMilliseconds;

          int maxBuffering = 0;
          for (final DurationRange range in controller.value.buffered) {
            final int end = range.end.inMilliseconds;
            if (end > maxBuffering) {
              maxBuffering = end;
            }
          }
          animController.stop();
          animController.reset();

          animController.value = position / duration;
        }
        animController.forward().whenComplete(() {
          if (CurrentPage < StroryData.length - 1) {
            pageController.jumpToPage(CurrentPage + 1);
          } else {
            controller.dispose();
            Navigator.pop(context);
          }
        });
      }
    } else {
      if (controller.value.isPlaying) {
        controller.pause();
        animController.stop();
      } else {
        controller.play();
        animController.forward().whenComplete(() {
          if (CurrentPage < StroryData.length - 1) {
            pageController.jumpToPage(CurrentPage + 1);
          } else {
            controller.dispose();
            Navigator.pop(context);
          }
        });
      }
    }
  }

  loedvideo() async {
    end=false;
    start=false;
    controller.dispose();
    animController.stop();
    animController.reset();
    controller =
        VideoPlayerController.network(StroryData[CurrentPage].file.toString());
    await controller.initialize();
    splitted = StroryData[CurrentPage].duration!.split('.');
    houres = int.parse(splitted[0]);
    mint = int.parse(splitted[1]);
    second = int.parse(splitted[2]);
    animController.duration =
        Duration(hours: houres, minutes: mint, seconds: second);
    animController.forward().whenComplete(() {
      setState(() {
        CurrentPage < StroryData.length - 1
            ? pageController.jumpToPage(CurrentPage + 1)
            : Navigator.pop(context);
      });
    });

    controller.play();
  }

  Widget Detatlies({required String name, required String image}) {
    return InkWell(
      onTap: () {
        controller.pause();
        animController.stop();
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

  Widget Social({required String link, required String image}) {
    return InkWell(
        onTap: () {
          controller.pause();
          animController.stop();
          launch(link);
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

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (StroryData[CurrentPage].type == "image") {
           if(CurrentPage < StroryData.length - 1){
             controller.dispose();
             animController.stop();
             animController.reset();
             animController.duration = Duration(seconds: 10);
             animController.forward().whenComplete(() {
               CurrentPage < StroryData.length - 1
                   ? pageController.jumpToPage(CurrentPage + 1)
                   : Navigator.pop(context);

             });

             pageController.jumpToPage(CurrentPage + 1);
           }else{
             null;
           }



      } else {
        null;
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (StroryData[CurrentPage].type == "image") {
        controller.dispose();
        controller.dispose();
        animController.stop();
        animController.reset();
        animController.duration = Duration(seconds: 10);
        animController.forward().whenComplete(() {
          CurrentPage < StroryData.length - 1
              ? pageController.jumpToPage(CurrentPage + 1)
              : Navigator.pop(context);

        });

        if (CurrentPage > 0) {
            if (CurrentPage == 1) {
              CurrentPage = 0;
              pageController.jumpToPage(CurrentPage);
            } else {
              pageController.jumpToPage(CurrentPage - 1);
            }
          }else{
          null;
        }

      }
    } else {
      if (StroryData[CurrentPage].type == "image") {
        if (animController.isAnimating) {
          animController.stop();
        } else {
          animController.forward().whenComplete(() {

              CurrentPage < StroryData.length - 1
                  ? pageController.jumpToPage(CurrentPage + 1)
                  : Navigator.pop(context);

          });
        }
      }
    }
  }
}
