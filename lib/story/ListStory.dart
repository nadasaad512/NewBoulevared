import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:video_cached_player/video_cached_player.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import '../api/User_Controller.dart';
import '../models/Follower_user.dart';
import '../models/ads.dart';
import '../screens/Profile/widget/AdaminAsUserShow.dart';

class ListStoryScreen extends StatefulWidget {
  List<MyFollowings> PageFollowing;
  late int initialindex;

  ListStoryScreen({required this.initialindex, required this.PageFollowing});

  @override
  _ListStoryScreenState createState() => _ListStoryScreenState();
}

class _ListStoryScreenState extends State<ListStoryScreen>
    with SingleTickerProviderStateMixin {
  int CurrentStory = 0;
  int PageCurrent = 0;
  int PageDetal = 0;
  late PageController pageController;
  late PageController StoryController;
  late AnimationController animController;
  late CachedVideoPlayerController controller;
  late CachedVideoPlayerController old;
  List<story1> img = [];
 List<story1> vido = [];
  List<ListStory> Story = [];
  bool start = false;
  bool end = false;
  double heightImg = 50;
  double widthImg = 50;
  bool scale=true;
  PageController _pageController = PageController();
  int CurrentVideo = 0;
  int TestVideo = 0;
  List<CachedVideoPlayerController> controllers = [];
  List<int> controllerIndices = [];
  int index=0;
  int videoindex=0;
  int videoAllPageLength=0;
  List<VideoType> test = [];


  int count=0;


  @override
  void initState() {
    super.initState();
   // Wakelock.enable();
    PageCurrent = widget.initialindex;
    pageController = PageController(initialPage: widget.initialindex);
    StoryController = PageController();
    UserApiController().AdDetalies(idAD: widget.PageFollowing[PageCurrent].ads![0].id!);
    animController = AnimationController(vsync: this);
    controller = CachedVideoPlayerController.network("");
    controller.initialize();
    old = controller;
    for (var y = 0; y < widget.PageFollowing.length; y++) {
      img = [];
      vido = [];
      controllerIndices=[];
      for (var i = 0; i < widget.PageFollowing[y].ads!.length; i++) {
        img.addAll(widget.PageFollowing[y].ads![i].adImages!);
        vido.addAll(widget.PageFollowing[y].ads![i].adVideos!);
      }
      for (story1 url in vido) {
        controllerIndices.add(index);
        index++;
        controllers.add(CachedVideoPlayerController.network(url.file.toString())
          ..initialize().then((_) {
            setState(() {});
          }));

      }
      test.add(VideoType(page: y,controllerVideo: controllers,lenght: controllerIndices));
      Story.add(
          ListStory(ad: List.from(img)..addAll(List.from(vido)),
              page: y,
              lengthad: widget.PageFollowing[y].ads!.length,));
      videoAllPageLength=videoAllPageLength+controllerIndices.length;
    }

if(test[widget.initialindex].lenght!=null) {
  CurrentVideo =
      test[widget.initialindex].lenght!.isEmpty ? 0 : test[PageCurrent]
      .lenght!.first;
}

    






  }

  @override
  void dispose() {
  //  Wakelock.disable();
    for (var controller in controllers) {
      controller.dispose();
    }
    controller.pause();
    controller.dispose();
    pageController.dispose();
    StoryController.dispose();
    animController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details, test[PageCurrent].lenght!.length),
          child: PageView.builder(
              itemCount: widget.PageFollowing.length,
              controller: pageController,
              physics: ScrollPhysics(),
              onPageChanged: (int onPageChanged) async {
                setState(() {
                  controllers[CurrentVideo].pause();
                  PageCurrent = onPageChanged;
                  end=false;
                  CurrentStory = 0;
                  PageDetal = 0;
                  videoindex=0;


                  if(test[PageCurrent].lenght!=null) {
                    CurrentVideo =
                    test[PageCurrent].lenght!.isEmpty ? 0 : test[PageCurrent]
                        .lenght!.first;
                  }


                });

                await UserApiController().AdDetalies(idAD: widget.PageFollowing[PageCurrent].ads![0].id!);
              },
              itemBuilder: (BuildContext, index) {
                return PageView.builder(
                    itemCount: Story[PageCurrent].ad!.length,
                    controller: StoryController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int currentPage) {
                      setState(() {
                        CurrentStory = currentPage;
                        print(CurrentStory);
                      });
                    },
                    itemBuilder: (BuildContext, index) {
                      if (Story[PageCurrent].ad![CurrentStory].type == "image") {

                        loedImage();
                        return Container(
                          height: heightImg,
                          width: widthImg,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: NetworkImage(Story[PageCurrent]
                                  .ad![CurrentStory]
                                  .file
                                  .toString()),
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
                                      children: Story[PageCurrent]
                                          .ad!
                                          .asMap()
                                          .map((i, e) {
                                        return MapEntry(
                                          i,
                                          AnimatedBar(
                                            animController:
                                            animController,
                                            position: i,
                                            currentIndex:
                                            CurrentStory,
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserShowAdmain(
                                                        id: widget
                                                            .PageFollowing[
                                                        PageCurrent]
                                                            .id!)));
                                      },
                                      child: Row(
                                        children: [
                                          widget
                                              .PageFollowing[
                                          PageCurrent]
                                              .imageProfile !=
                                              null
                                              ? CircleAvatar(
                                              radius: 21.sp,
                                              backgroundImage:
                                              NetworkImage(widget
                                                  .PageFollowing[
                                              PageCurrent]
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
                                            widget
                                                .PageFollowing[
                                            PageCurrent]
                                                .name
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
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        controller.dispose();
                                        old.dispose();
                                        Navigator.pop(context);
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
                            ],
                          ),
                        );
                      } else {
                        _loadVideo(test[PageCurrent].lenght!.length);
                        return PageView.builder(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:test[PageCurrent].lenght!.length,
                          onPageChanged: (int currentPage) {

                          },
                          itemBuilder: (BuildContext , te) {
                            controllers[CurrentVideo].play();
                            return Stack(
                              children: [
                                Center(
                                  child:controllers[CurrentVideo].value.isInitialized
                                      ? AspectRatio(
                                    aspectRatio:controllers[CurrentVideo].value.aspectRatio,
                                    child: CachedVideoPlayer(controllers[CurrentVideo]),
                                  )
                                      : CircularProgressIndicator(),
                                ),
                                Positioned(
                                    top: 45.0,
                                    left: 10.0,
                                    right: 10.0,
                                    child: Column(children: <Widget>[
                                      Row(
                                        children: Story[PageCurrent]
                                            .ad!
                                            .asMap()
                                            .map((i, e) {
                                          return MapEntry(
                                            i,
                                            AnimatedBar(
                                              animController:
                                              animController,
                                              position: i,
                                              currentIndex: CurrentStory,
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
                                          controllers[CurrentVideo].pause();
                                          controller.pause();
                                          animController.stop();

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserShowAdmain(

                                                          id: widget
                                                              .PageFollowing[
                                                          PageCurrent]
                                                              .ads![0]
                                                              .advertiser!
                                                              .id!)));
                                        },
                                        child: Row(
                                          children: [
                                            widget
                                                .PageFollowing[
                                            PageCurrent]
                                                .ads![0]
                                                .advertiser!
                                                .imageProfile !=
                                                null
                                                ? CircleAvatar(
                                                radius: 21.sp,
                                                backgroundImage:
                                                NetworkImage(widget
                                                    .PageFollowing[
                                                PageCurrent]
                                                    .ads![0]
                                                    .advertiser!
                                                    .imageProfile!
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
                                              widget
                                                  .PageFollowing[PageCurrent]
                                                  .ads![0]
                                                  .advertiser!
                                                  .name!
                                                  .toString(),
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
                                          controller.dispose();
                                          old.dispose();
                                          controllers[CurrentVideo].pause();
                                          animController.stop();

                                          Navigator.pop(context);
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

                              ],
                            );
                          },
                        );

                      }
                    });
              }),
        ));
  }

  loedImage(){
    controllers[CurrentVideo].pause();
    Size size1=  _calculateImageDimension(image1: Story[PageCurrent].ad![CurrentStory].file.toString());
    heightImg= size1.height;
    widthImg= size1.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animController.stop();
      animController.duration = Duration(seconds: 10);
      animController.reset();
      animController.forward().whenComplete(() {
        setState(() {
          if (Story[PageCurrent].ad![CurrentStory].type == "image") {
            if (CurrentStory < Story[PageCurrent].ad!.length - 1) {
              CurrentStory++;
              StoryController.jumpToPage(CurrentStory);
            } else {
              if (CurrentStory == Story[PageCurrent].ad!.length - 1) {
                if (PageCurrent < widget.PageFollowing.length - 1) {
                  controllers[CurrentVideo].pause();
                  PageCurrent++;
                  pageController.jumpToPage(PageCurrent);
                } else {
                  Navigator.pop(context);
                }
              }
            }
          }
        });
      });
    });


  }


  Size _calculateImageDimension({required String image1}) {
    Completer<Size> completer = Completer();
    Image image = Image.network(image1);
    Size size1 = Size(0, 0);

    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          size1 = size;
          completer.complete(size);
        },
      ),
    );
    return size1;
  }

  void _onTapDown(TapDownDetails details,int length) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
        controllers[CurrentVideo].pause();
        if (CurrentStory < Story[PageCurrent].ad!.length - 1) {
          setState(() {
            StoryController.jumpToPage(CurrentStory + 1);
          });
        } else {
          if (CurrentStory == Story[PageCurrent].ad!.length - 1) {
            if (PageCurrent < widget.PageFollowing.length - 1) {
              PageCurrent++;
              pageController.jumpToPage(PageCurrent);
            } else {
              Navigator.pop(context);
            }
          }
        }
      }

      ///video

      else {
        if (end == true) {
          print("length is $length");
          print("videoindex is $videoindex");
          if (videoindex < length-1) {
              _pageController.jumpToPage(CurrentVideo++);
            CurrentStory++;
              videoindex++;
              setState(() {});
              controllers[CurrentVideo].seekTo(Duration.zero);
              end = false;
          } else {
            if(PageCurrent<widget.PageFollowing.length-1){
              controllers[CurrentVideo].pause();
              PageCurrent++;
              CurrentVideo =  test[PageCurrent].lenght!.first;
              pageController.jumpToPage(PageCurrent);
            }else{
              Navigator.pop(context);
            }
          }
        }
        else {
          forward5Seconds();
          if (controllers[CurrentVideo].value.isInitialized) {
            final int duration = controllers[CurrentVideo].value.duration.inMilliseconds;
            final int position = controllers[CurrentVideo].value.position.inMilliseconds;
            int maxBuffering = 0;
            for (final DurationRange range in controllers[CurrentVideo].value.buffered) {
              final int end = range.end.inMilliseconds;
              if (end > maxBuffering) {
                maxBuffering = end;
              }
            }
            animController.value = position / duration;
          }
          animController.forward().whenComplete(() {
            if (videoindex < length-1) {
              _pageController.jumpToPage(CurrentVideo++);
                CurrentStory++;
              videoindex++;
              CurrentVideo;
                setState(() {
                });
                controllers[CurrentVideo].seekTo(Duration.zero);
                end = false;

            } else {

              if(PageCurrent<widget.PageFollowing.length-1){
                controllers[CurrentVideo].pause();
                PageCurrent++;
                setState(() {

                });

                pageController.jumpToPage(PageCurrent);
                controllers[CurrentVideo].pause();
              }else{
                Navigator.pop(context);
              }
            }
          });
        }
      }
    }

    ///back

    else if (dx > 2 * screenWidth / 3) {
      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
        controllers[CurrentVideo].pause();
        if (CurrentStory != 0) {
          setState(() {
            StoryController.jumpToPage(CurrentStory - 1);
          });
        } else {
          if (CurrentStory == 0) {
            pageController.jumpToPage(PageCurrent - 1);
          }
        }
      }

      else {
        if (start) {
          if(videoindex==0){
            setState(() {
              StoryController.jumpToPage(CurrentStory - 1);
              start = false;
            });
          }
          if (CurrentVideo > 0) {
            controller.dispose();
            old.dispose();
            setState(() {
              CurrentStory--;
              _pageController.jumpToPage(CurrentVideo--);
              videoindex--;
              CurrentVideo;

              start = false;
            });
          } else {
            if (PageCurrent != 0) {
              setState(() {
                pageController.jumpToPage(PageCurrent - 1);
              });
            }
          }
        } else {
          rewind5Seconds();
          if (controllers[CurrentVideo].value.isInitialized) {
            final int duration = controllers[CurrentVideo].value.duration.inMilliseconds;
            final int position = controllers[CurrentVideo].value.position.inMilliseconds;

            int maxBuffering = 0;
            for (final DurationRange range in controllers[CurrentVideo].value.buffered) {
              final int end = range.end.inMilliseconds;
              if (end > maxBuffering) {
                maxBuffering = end;
              }
            }
            animController.value = position / duration;
          }
          animController.forward().whenComplete(() {
            if (CurrentStory > 0) {
              setState(() {
                CurrentStory--;
                _pageController.jumpToPage(CurrentVideo--);
                videoindex--;
                CurrentVideo;
                start = false;
              });
            } else {
              if (PageCurrent != 0) {
                setState(() {
                  pageController.jumpToPage(PageCurrent - 1);
                });
              }
            }
          });
        }
      }
    }

    ///back
 else{

      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
        if (animController.isAnimating) {
          animController.stop();
        } else {
          animController.forward();
        }

      }else{
        if (controllers[CurrentVideo].value.isPlaying) {
          controllers[CurrentVideo].pause();
          animController.stop();
        } else {

          controllers[CurrentVideo].play();
          animController.forward();
        }
    }
  }}


  _loadVideo(int length) async {
    old.dispose();
    animController.stop();
    animController.reset();
    controller = CachedVideoPlayerController.network(Story[PageCurrent].ad![CurrentStory].file.toString());
    old = controller;
    await controller.initialize();
    var splitted = Story[PageCurrent].ad![CurrentStory].duration!.split('.');
    var houres = int.parse(splitted[0]);
    var mint = int.parse(splitted[1]);
    var second = int.parse(splitted[2]);
    animController.duration = Duration(hours: houres, minutes: mint, seconds: second);
    animController.forward().whenComplete(() {
      if (videoindex < length-1) {
        _pageController.jumpToPage(CurrentVideo++);
        CurrentStory++;
        videoindex++;
        setState(() {
          CurrentVideo;
        });

        controllers[CurrentVideo].seekTo(Duration.zero);
          end = false;
        setState(() {});
      } else {
        if(PageCurrent<widget.PageFollowing.length){
          pageController.jumpToPage(PageCurrent++);
          controllers[CurrentVideo].pause();

        }else{
          Navigator.pop(context);
        }

      }
    });
    controllers[CurrentVideo].play();
    controllers[CurrentVideo].seekTo(Duration.zero);
  }

  Future forward5Seconds() async => goToPosition(
      (currentPosition) => currentPosition + Duration(seconds: 10));

  Future rewind5Seconds() async => goToPosition(
      (currentPosition) => currentPosition - Duration(seconds: 10));

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await controllers[CurrentVideo].position;
    final newPosition = builder(currentPosition!);
    newPosition <= Duration(hours: 0, minutes: 0, seconds: 10)
        ? start = true
        : start = false;
    print("CurrentVideo is ${CurrentVideo}");
    newPosition >= controllers[CurrentVideo].value.duration ? end = true : end = false;
    newPosition >= controllers[CurrentVideo].value.duration
        ? null
        : await controllers[CurrentVideo].seekTo(newPosition);
  }
}


