import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:new_boulevard/screens/maps/location.dart';
import 'package:new_boulevard/story/imageitem.dart';
import 'package:new_boulevard/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_cached_player/video_cached_player.dart';
import '../models/ads.dart';
import '../provider/app_provider.dart';
import '../screens/Profile/widget/AdaminAsUserShow.dart';
import '../screens/maps/mapscreen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class storyPageScreen extends StatefulWidget {
  int AdId;

  storyPageScreen({required this.AdId});

  @override
  _storyPageScreenState createState() => _storyPageScreenState();
}

class _storyPageScreenState extends State<storyPageScreen>
    with SingleTickerProviderStateMixin, Helpers {
  int CurrentPage = 0;
  int CurrentVideo = 0;
  late PageController pageController;
  late AnimationController animController;
  late CachedVideoPlayerController controller;
  final _pageNotifier = ValueNotifier(0.0);
  bool start = false;
  bool end = false;
  var splitted;
  var houres;
  var mint;
  var second;
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _clearControllers();
    //Wakelock.enable();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(_listener);
    });
    pageController = PageController();
    controller = CachedVideoPlayerController.network("");
    controller.initialize();
    animController = AnimationController(vsync: this);
    Provider.of<AppProvider>(context, listen: false)
        .getAlldataForStory(id: widget.AdId);
    WakelockPlus.enable();

  }

  @override
  void dispose() {
    // Wakelock.disable();
    WakelockPlus.disable();
    pageController.dispose();
    animController.dispose();
    pageController.removeListener(_listener);
    _pageNotifier.dispose();
    controller.dispose();
    _clearControllers();

    super.dispose();
  }

  void _listener() {
    _pageNotifier.value = pageController.page!;
  }

  void _clearControllers() {
    for (var controller
    in Provider.of<AppProvider>(context, listen: false).controllers) {
      controller.dispose();
    }
    Provider.of<AppProvider>(context, listen: false).controllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: provider.story == null ||
            provider.alldata == null ||
            provider.listVideo == null ||
            provider.StroryData == null
            ? SizedBox.shrink()
            : ValueListenableBuilder<double>(
            valueListenable: _pageNotifier,
            builder: (_, value, child) {
              return PageView.builder(
                controller: pageController,
                itemCount: provider.StroryData!.length,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (int currentPage) {
                  setState(() {
                    CurrentPage = currentPage;
                  });
                },
                itemBuilder: (BuildContext, index) {
                  if (provider.StroryData![CurrentPage].type == "image") {
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
                    loadVideo(provider, CurrentVideo);
                    provider.controllers[CurrentVideo].play();
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: provider.listVideo!.length,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int currentPage) {
                        setState(() {
                          CurrentVideo = currentPage;
                        });
                      },
                      itemBuilder: (BuildContext, te) {

                        return GestureDetector(
                          onTapDown: (details) => _onTapDown2(details, provider, CurrentVideo),
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.black,
                            child: Stack(
                              children: [
                                Center(
                                    child: AspectRatio(
                                      aspectRatio: Provider.of<AppProvider>(
                                          context,
                                          listen: false)
                                          .controllers[te]
                                          .value
                                          .aspectRatio,
                                      child: CachedVideoPlayer(
                                          Provider.of<AppProvider>(context,
                                              listen: false)
                                              .controllers[te]),
                                    )),
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
                                          _clearControllers();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserShowAdmain(
                                                        id: provider
                                                            .alldata!
                                                            .advertiser!
                                                            .id!,
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
                                              provider
                                                  .alldata!.advertiser!.name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 16.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          _clearControllers();
                                          Navigator.pushReplacementNamed(
                                              context, '/MainScreen');
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                          Colors.grey.shade400,
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
                                  right: 5.w,
                                  left: 5.w,
                                  child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape:
                                          const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              )),
                                          builder: (context) {
                                            return Container(
                                                margin:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 16.h),
                                                decoration:
                                                const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .only(
                                                      topRight:
                                                      Radius.circular(15),
                                                      topLeft:
                                                      Radius.circular(15),
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
                                                              fontSize:
                                                              16.sp,
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
                                                          icon: SvgPicture
                                                              .asset(
                                                              "images/close.svg"),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    provider.alldata!
                                                        .details !=
                                                        null
                                                        ? Text(
                                                      provider
                                                          .alldata!
                                                          .details!,
                                                      style: TextStyle(
                                                          fontSize:
                                                          14.sp,
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
                                                            onPressed:
                                                                () {},
                                                            icon: Icon(
                                                              Icons
                                                                  .location_on,
                                                              color: const Color(
                                                                  0xff7B217E),
                                                              size: 30.sp,
                                                            )),
                                                        Text(
                                                          " السعودية-   ${provider.alldata!.city!.name.toString()}",
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff7B217E),
                                                              fontSize:
                                                              16.sp,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        controller.pause();
                                                        String
                                                        googleMapsUrl =
                                                            'https://www.google.com/maps/search/?api=1&query=${double.parse(provider.alldata!.latitude!)},'
                                                            '${double.parse(provider.alldata!.longitude!)}';

                                                        if (await canLaunch(
                                                            googleMapsUrl)) {
                                                          await launch(
                                                              googleMapsUrl);
                                                        } else {
                                                          throw 'Could not open the map.';
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 150.h,
                                                        child:
                                                        GoogleMapPage(
                                                          latitude: double
                                                              .parse(provider
                                                              .alldata!
                                                              .latitude!),
                                                          longitude: double
                                                              .parse(provider
                                                              .alldata!
                                                              .longitude!),
                                                          onlyView: true,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                      width: 343.w,
                                                      height: 100.h,
                                                      margin: EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          12.w,
                                                          vertical:
                                                          12.h),
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5),
                                                        color: Colors
                                                            .purple.shade50,
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            12.w,
                                                            vertical:
                                                            12.h),
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
                                                                provider.alldata!.twitter ==
                                                                    null
                                                                    ? Container()
                                                                    : Social(
                                                                    image:
                                                                    "images/twitter.svg",
                                                                    link:
                                                                    provider.alldata!.twitter.toString()),
                                                                SizedBox(
                                                                  width:
                                                                  26.w,
                                                                ),
                                                                provider.alldata!.instagram ==
                                                                    null
                                                                    ? Container()
                                                                    : Social(
                                                                    image:
                                                                    "images/instegram.svg",
                                                                    link:
                                                                    provider.alldata!.instagram.toString()),
                                                                SizedBox(
                                                                  width:
                                                                  26.w,
                                                                ),
                                                                provider.alldata!.whatsapp ==
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
                                                                  width:
                                                                  26.w,
                                                                ),
                                                                provider.alldata!.facebook ==
                                                                    null
                                                                    ? Container()
                                                                    : Social(
                                                                    image:
                                                                    "images/facebook.svg",
                                                                    link:
                                                                    provider.alldata!.facebook.toString()),
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
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 308.w,
                                            height: 38.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5)),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 4.h,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  SvgPicture.asset(
                                                      "images/show.svg"),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  const Text(
                                                    'اضغط لمعرفة المزيد عن الإعلان',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            }),
      );
    });
  }

  Future forward5Seconds(int index) async {
    await Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .pause(); // Pause the video player
    await goToPosition(
            (currentPosition) => currentPosition + const Duration(seconds: 10),
        index);
    await Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .play(); // Resume playback
  }

  Future rewind5Seconds(int index) async {
    await Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .pause(); // Pause the video player
    await goToPosition(
            (currentPosition) => currentPosition - const Duration(seconds: 10),
        index);
    await Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .play(); // Resume playback
  }

  Future goToPosition(Duration Function(Duration currentPosition) builder, int index) async {
    final currentPosition =
    await Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .position;
    final newPosition = builder(currentPosition!);
    newPosition <= const Duration(hours: 0, minutes: 0, seconds: 10)
        ? start = true
        : start = false;
    newPosition >=
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .value
            .duration
        ? end = true
        : end = false;
    newPosition >=
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .value
            .duration
        ? null
        : await Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .seekTo(newPosition);
    final int duration = Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .value
        .duration
        .inSeconds;
    final int position = Provider.of<AppProvider>(context, listen: false)
        .controllers[index]
        .value
        .position
        .inSeconds;
    animController.stop();
    animController.reset();
    animController.value = position / duration;
    animController.forward();
    animController.forward().whenComplete(() {
      print("66666666s");
      if (CurrentVideo <
          Provider.of<AppProvider>(context, listen: false).listVideo!.length ) {
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .dispose();
        _pageController.jumpToPage(CurrentVideo + 1);
        CurrentPage++;
        // Provider.of<AppProvider>(context, listen: false)
        //     .controllers[index]
        //     .seekTo(Duration.zero);
      } else {
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .dispose();
        Navigator.pop(context);
      }
    });
  }

  void _onTapDown2(TapDownDetails details, AppProvider provider, int index) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (end == true) {
        if (CurrentVideo < provider.listVideo!.length-1) {
          print("44444444444");
          Provider.of<AppProvider>(context, listen: false).controllers[index].pause();
          CurrentVideo++;
          CurrentPage++;
          _pageController.jumpToPage(CurrentVideo );
          Provider.of<AppProvider>(context, listen: false).controllers[index].seekTo(Duration.zero);
        } else {
          Provider.of<AppProvider>(context, listen: false).controllers[index]
              .dispose();
          Navigator.pop(context);
        }
      } else {
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .value
            .isInitialized
            ? forward5Seconds(CurrentVideo)
            : null;
        if (Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .value
            .isInitialized) {
          int maxBuffering = 0;
          for (final DurationRange range
          in Provider.of<AppProvider>(context, listen: false)
              .controllers[index]
              .value
              .buffered) {
            final int end = range.end.inSeconds;
            if (end > maxBuffering) {
              maxBuffering = end;
            }
          }
        }
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (start) {
        if (CurrentVideo == 0) {
          Provider.of<AppProvider>(context, listen: false)
              .controllers[CurrentVideo]
              .pause();
          pageController.jumpToPage(CurrentPage - 1);
        } else {

          _pageController.jumpToPage(CurrentVideo - 1);
          CurrentPage--;
        }
      } else {
        rewind5Seconds(CurrentVideo);
        if (Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .value
            .isInitialized) {
          final int duration = Provider.of<AppProvider>(context, listen: false)
              .controllers[index]
              .value
              .duration
              .inMilliseconds;
          final int position = Provider.of<AppProvider>(context, listen: false)
              .controllers[index]
              .value
              .position
              .inMilliseconds;
          int maxBuffering = 0;
          for (final DurationRange range
          in Provider.of<AppProvider>(context, listen: false)
              .controllers[index]
              .value
              .buffered) {
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
          print("here");
          if (CurrentVideo < provider.listVideo!.length-1) {
            _pageController.jumpToPage(CurrentVideo + 1);
            CurrentPage++;
          } else {
            Provider.of<AppProvider>(context, listen: false)
                .controllers[index]
                .dispose();
            Navigator.pop(context);
          }
        });
      }
    } else {
      if (Provider.of<AppProvider>(context, listen: false)
          .controllers[index]
          .value
          .isPlaying) {
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .pause();
        animController.stop();
      } else {
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .play();
        animController.forward().whenComplete(() {
          print("object");
          if (CurrentVideo < provider.listVideo!.length-1) {
            _pageController.jumpToPage(CurrentVideo + 1);
            CurrentPage++;
          } else {
            Provider.of<AppProvider>(context, listen: false)
                .controllers[index]
                .dispose();
            Navigator.pop(context);
          }
        });
      }
    }
  }

  void loadVideo(AppProvider provider, int index) async {
    end = false;
    start = false;
    animController.stop();
    animController.reset();
    splitted = provider.StroryData![CurrentPage].duration!.split('.');
    houres = int.parse(splitted[0]);
    mint = int.parse(splitted[1]);
    second = int.parse(splitted[2]);
    animController.duration = Duration(hours: houres, minutes: mint, seconds: second);
    animController.forward().whenComplete(() {
      print("here");
      if (CurrentVideo < provider.listVideo!.length-1) {
        _pageController.jumpToPage(CurrentVideo + 1);
        CurrentPage++;
        Provider.of<AppProvider>(context, listen: false)
            .controllers[CurrentVideo]
            .play();
      } else {
        Provider.of<AppProvider>(context, listen: false)
            .controllers[index]
            .dispose();
        Navigator.pop(context);
      }
    });
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
            animController.stop();
            openWhatsApp(phoneNumber: link);
          } else {
            animController.stop();
            launch(link);
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

  void openWhatsApp({required String phoneNumber}) async {
    launchUrl(Uri.parse("whatsapp://send?phone=${phoneNumber}&text=${"Hi"}"));
  }
}
