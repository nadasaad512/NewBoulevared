
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:new_boulevard/screens/maps/location.dart';
import 'package:new_boulevard/story/imageitem.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_cached_player/video_cached_player.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import '../provider/app_provider.dart';
import '../screens/Profile/widget/AdaminAsUserShow.dart';

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
  final _pageNotifier = ValueNotifier(0.0);
  late CachedVideoPlayerController  controller;
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(_listener);
    });
    pageController = PageController();
    animController = AnimationController(vsync: this);
    controller = CachedVideoPlayerController.network(
      "",
    );
    controller.initialize();
    Provider.of<AppProvider>(context, listen: false)
        .getAlldataForStory(id: widget.AdId);
    // UserApiController().AdDetalies(idAD: widget.AdId).then((value) {});
  }

  @override
  void dispose() {
    Wakelock.disable();
    controller.pause();
    controller.dispose();
    pageController.removeListener(_listener);
    _pageNotifier.dispose();
    pageController.dispose();
    animController.dispose();
    super.dispose();
  }

  void _listener() {
    _pageNotifier.value = pageController.page!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: provider.story == null ||
                provider.alldata == null ||
                provider.StroryData == null
            ? SizedBox.shrink()
            : ValueListenableBuilder<double>(
                valueListenable: _pageNotifier,
                builder: (_, value, child) {
                  return PageView.builder(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.StroryData!.length,
                    onPageChanged: (int currentPage) {
                      setState(() {
                        CurrentPage = currentPage;
                      });
                    },
                    itemBuilder: (BuildContext, index) {
                      if (provider.StroryData![CurrentPage].type == "image") {
                        controller.dispose();
                        animController.stop();
                        animController.reset();
                        animController.duration = const Duration(seconds: 10);
                        animController.forward().whenComplete(() {
                          CurrentPage < provider.StroryData!.length - 1
                              ? pageController.jumpToPage(CurrentPage + 1)
                              : Navigator.pop(context);
                        });

                        return GestureDetector(
                            onTapDown: (details) =>
                                _onTapDown(details, provider),
                            child: provider.StroryData != null &&
                                    provider.alldata != null
                                ? ImageStoryScreen(
                                    StroryData:
                                        provider.StroryData![CurrentPage],
                                    animController: animController,
                                    currentPage: CurrentPage,
                                    data: provider.StroryData!,
                                    ad: provider.alldata!,
                                  )
                                : SizedBox.shrink());
                      }
                      else {
                        loadVideo(provider);
                        return GestureDetector(
                          onTapDown: (details) => _onTapDown2(details, provider),
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.black,
                            child: Stack(
                              children: [
                                Center(
                                  child: AspectRatio(
                                      aspectRatio: double.parse(provider
                                                  .StroryData![CurrentPage]
                                                  .width!)
                                              .w /
                                          double.parse(provider
                                                  .StroryData![CurrentPage]
                                                  .height!)
                                              .h,
                                      child: CachedVideoPlayer(
                                        controller,

                                      )),
                                ),
                                Positioned(
                                    top: 45.0,
                                    left: 10.0,
                                    right: 10.0,
                                    child: Column(children: <Widget>[
                                      Row(
                                        children: provider.StroryData!
                                            .asMap()
                                            .map((i, e) {
                                              return MapEntry(
                                                i,
                                                AnimatedBar(
                                                  animController:
                                                      animController,
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
                                                  builder: (context) =>
                                                      UserShowAdmain(
                                                        id: provider.alldata!
                                                            .advertiser!.id!,
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            provider.alldata!.advertiser!
                                                        .imageProfile !=
                                                    null
                                                ? CircleAvatar(
                                                    radius: 21.sp,
                                                    backgroundImage:
                                                        NetworkImage(provider
                                                            .alldata!
                                                            .advertiser!
                                                            .imageProfile
                                                            .toString()))
                                                : CircleAvatar(
                                                    radius: 21.sp,
                                                    backgroundColor:
                                                        Color(0xff7B217E),
                                                    child: Icon(
                                                      Icons.person_rounded,
                                                      color: Colors.white,
                                                      size: 15.sp,
                                                    )),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              provider.alldata!.advertiser!.name
                                                  .toString(),
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
                                          controller.pause();
                                          animController.stop();
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
                                          return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 16.h),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
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
                                                            color: const Color(
                                                                0xff7B217E),
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const Spacer(),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: SvgPicture.asset(
                                                            "images/close.svg"),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  provider.alldata!.details !=
                                                          null
                                                      ? Text(
                                                          provider.alldata!
                                                              .details!,
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
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
                                                            color: const Color(
                                                                0xff7B217E),
                                                            size: 30.sp,
                                                          )),
                                                      Text(
                                                        " السعودية-   ${provider.alldata!.city!.name.toString()}",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff7B217E),
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  MapScreen(
                                                      latitud: double.parse(
                                                          provider.alldata!
                                                              .latitude!),
                                                      longitud: double.parse(
                                                          provider.alldata!
                                                              .longitude!)),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Container(
                                                    width: 343.w,
                                                    height: 100.h,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 12.h),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.purple.shade50,
                                                    ),
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w,
                                                              vertical: 12.h),
                                                      child: Column(
                                                        children: [
                                                          provider.alldata!
                                                                      .store_url ==
                                                                  null
                                                              ? Container()
                                                              : Detatlies(
                                                                  name:
                                                                      "الموقع",
                                                                  image:
                                                                      "images/earth.svg"),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              provider.alldata!
                                                                          .twitter ==
                                                                      null
                                                                  ? Container()
                                                                  : Social(
                                                                      image:
                                                                          "images/twitter.svg",
                                                                      link: provider
                                                                          .alldata!
                                                                          .twitter
                                                                          .toString()),
                                                              SizedBox(
                                                                width: 26.w,
                                                              ),
                                                              provider.alldata!
                                                                          .instagram ==
                                                                      null
                                                                  ? Container()
                                                                  : Social(
                                                                      image:
                                                                          "images/instegram.svg",
                                                                      link: provider
                                                                          .alldata!
                                                                          .instagram
                                                                          .toString()),
                                                              SizedBox(
                                                                width: 26.w,
                                                              ),
                                                              provider.alldata!
                                                                          .whatsapp ==
                                                                      null
                                                                  ? Container()
                                                                  : Social(
                                                                      image:
                                                                          "images/whatsapp.svg",
                                                                      isWhatsapp:
                                                                          true,
                                                                      context:
                                                                          context,
                                                                      link:
                                                                          "${provider.alldata!.whatsapp}"),
                                                              SizedBox(
                                                                width: 26.w,
                                                              ),
                                                              provider.alldata!
                                                                          .facebook ==
                                                                      null
                                                                  ? Container()
                                                                  : Social(
                                                                      image:
                                                                          "images/facebook.svg",
                                                                      link: provider
                                                                          .alldata!
                                                                          .facebook
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 12.w),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset("images/show.svg"),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const Text(
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
                  );
                }),
      );
    });
  }

  Future forward5Seconds() async {
    await controller.pause(); // Pause the video player
    await goToPosition(
        (currentPosition) => currentPosition + const Duration(seconds: 10));
    await controller.play(); // Resume playback
  }

  Future rewind5Seconds() async {
    await controller.pause(); // Pause the video player
    await goToPosition(
        (currentPosition) => currentPosition - const Duration(seconds: 10));
    await controller.play(); // Resume playback
  }

  Future goToPosition(Duration Function(Duration currentPosition) builder) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition!);

    newPosition <= const Duration(hours: 0, minutes: 0, seconds: 10)
        ? start = true
        : start = false;
    newPosition >= controller.value.duration
       // ||newPosition<Duration(seconds: 10)
        ? end = true : end = false;
    print("newPosition");
    print(newPosition);

    newPosition >= controller.value.duration ?null: await controller.seekTo(newPosition);
  }

  void _onTapDown2(TapDownDetails details, AppProvider provider) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (end == true) {
        if (CurrentPage < provider.StroryData!.length - 1) {
          pageController.jumpToPage(CurrentPage + 1);
        } else {
          controller.dispose();
          Navigator.pop(context);
        }
      } else {
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
          if (CurrentPage < provider.StroryData!.length - 1) {
            pageController.jumpToPage(CurrentPage + 1);
          } else {
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
          if (CurrentPage < provider.StroryData!.length - 1) {
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
          if (CurrentPage < provider.StroryData!.length - 1) {
            pageController.jumpToPage(CurrentPage + 1);
          } else {
            controller.dispose();
            Navigator.pop(context);
          }
        });
      }
    }
  }

  void loadVideo(AppProvider provider) async {
    print("provider.StroryData![CurrentPage].duration.toString()");
    print(provider.StroryData![CurrentPage].duration.toString());
    end = false;
    start = false;
    animController.stop();
    controller.dispose();
    animController.reset();
    controller = CachedVideoPlayerController.network(provider.StroryData![CurrentPage].file.toString());
    await controller.initialize();
    splitted = provider.StroryData![CurrentPage].duration!.split('.');
    houres = int.parse(splitted[0]);
    mint = int.parse(splitted[1]);
    second = int.parse(splitted[2]);
    animController.duration = Duration(hours: houres, minutes: mint, seconds: second);
    animController.forward().whenComplete(() {
      setState(() {
        CurrentPage < provider.StroryData!.length - 1
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

  Widget Social(
      {required String link,
      required String image,
      BuildContext? context,
      isWhatsapp = false}) {
    return InkWell(
        onTap: () {
          if (isWhatsapp) {
            controller.pause();
            animController.stop();
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

  void _onTapDown(TapDownDetails details, AppProvider provider) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (provider.StroryData![CurrentPage].type == "image") {
        if (CurrentPage < provider.StroryData!.length - 1) {
          controller.dispose();
          animController.stop();
          animController.reset();
          animController.duration = const Duration(seconds: 10);
          animController.forward().whenComplete(() {
            CurrentPage < provider.StroryData!.length - 1
                ? pageController.jumpToPage(CurrentPage + 1)
                : Navigator.pop(context);
          });

          if (CurrentPage == provider.StroryData!.length - 1) {
            print("here");
          }

          pageController.jumpToPage(CurrentPage + 1);
        } else {
          Navigator.pop(context);
        }
      } else {
        null;
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (provider.StroryData![CurrentPage].type == "image") {
        controller.dispose();
        controller.dispose();
        animController.stop();
        animController.reset();
        animController.duration = const Duration(seconds: 10);
        animController.forward().whenComplete(() {
          CurrentPage < provider.StroryData!.length - 1
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
        } else {
          null;
        }
      }
    } else {
      if (provider.StroryData![CurrentPage].type == "image") {
        if (animController.isAnimating) {
          animController.stop();
        } else {
          animController.forward().whenComplete(() {
            CurrentPage < provider.StroryData!.length - 1
                ? pageController.jumpToPage(CurrentPage + 1)
                : Navigator.pop(context);
          });
        }
      }
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

}
