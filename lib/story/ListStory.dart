import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:new_boulevard/screens/Profile/ProfileWidgt/profileScreen.dart';

import 'package:new_boulevard/story/imageitem.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import '../api/User_Controller.dart';
import '../models/Follower_user.dart';
import '../models/ads.dart';
import '../models/detalies.dart';

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
  late VideoPlayerController controller;
  late VideoPlayerController old;
  List<story1> img = [];
  List<story1> vido = [];
  List<ListStory> Story = [];
  bool start=false;
  bool end=false;
  double heightImg=50;
  double widthImg=50;


  @override
  void initState() {
    super.initState();
    Wakelock.enable();

    PageCurrent=widget.initialindex;
    UserApiController().AdDetalies(idAD: widget.PageFollowing[PageCurrent].ads![0].id!);
    animController = AnimationController(vsync: this);
    controller = VideoPlayerController.network("");
    controller.initialize();
    old = controller;
    for (var y = 0; y < widget.PageFollowing.length; y++) {
      for (var i = 0; i < widget.PageFollowing[y].ads!.length-1; i++) {
        img.addAll(widget.PageFollowing[y].ads![i].adImages!);
        vido.addAll(widget.PageFollowing[y].ads![i].adVideos!);
      }

      Story.add(ListStory(ad: List.from(img)..addAll(List.from(vido)), page: y,lengthad:widget.PageFollowing[y].ads!.length ));
      img = [];
      vido = [];
    }

    pageController = PageController();
    StoryController = PageController();

  }

  @override
  void dispose() {
    Wakelock.disable();
    pageController.dispose();
    StoryController.dispose();
    controller.dispose();
    animController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details),
          child: PageView.builder(
              itemCount: widget.PageFollowing.length,
              controller: pageController,
              onPageChanged: (int onPageChanged)async {

                controller.dispose();
                old.dispose();
                setState(() {
                  PageCurrent = onPageChanged;
                  CurrentStory=0;
                  PageDetal=0;
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
                      });
                    },
                    itemBuilder: (BuildContext, index) {
                      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
                        loedImage();
                        return Container(
                          height:heightImg,
                          width: widthImg,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(

                              image: NetworkImage(Story[PageCurrent].ad![CurrentStory].file.toString()),
                            ),
                          ),
                          child: Stack(
                            children: [


                              Positioned(
                                  top: 45.0,
                                  left: 10.0,
                                  right: 10.0,
                                  child: Column(


                                      children: <Widget>[
                                        Row(

                                          children:Story[PageCurrent].ad!.asMap().map((i, e) {
                                            return MapEntry(
                                              i,
                                              AnimatedBar(
                                                animController: animController,
                                                position: i,
                                                currentIndex: CurrentStory,
                                              ),
                                            );
                                          })
                                              .values
                                              .toList(),
                                        ),
                                      ])



                              ),
                              Positioned(
                                top: 60.0,
                                left: 15.0,
                                right: 15.0,
                                child: Row(
                                  children: [

                                    InkWell(
                                      onTap: (){

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserShowAdmain(id: widget.PageFollowing[PageCurrent].ads![0].advertiser!.id!)
                                            )




                                        );
                                      },
                                      child: Row(
                                        children: [
                                          widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!=null?

                                          CircleAvatar(
                                              radius: 21.sp,

                                              backgroundImage:
                                              NetworkImage(widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!)
                                          ):
                                          CircleAvatar(radius: 21.sp,
                                              backgroundColor: Color(0xff7B217E),
                                              child: Icon(Icons.person_rounded,color: Colors.white,
                                                size: 15.sp,)),
                                          SizedBox(width: 10.w,),


                                          Text(widget.PageFollowing[PageCurrent].ads![0].advertiser!.name!,style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 16.sp
                                          ),),




                                        ],
                                      ),
                                    ),

                                    Spacer(),

                                    InkWell(
                                      onTap: (){
                                        controller.dispose();
                                        old.dispose();
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade400,
                                        radius: 12.sp,
                                        child:   Center(
                                          child: Icon(Icons.close_rounded,size: 15.sp,color: Colors.black,),
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
                        controller.dispose();
                        _loadVideo();
                        return Stack(
                          children: [
                            Center(
                              child: AspectRatio(
                                aspectRatio: double.parse(Story[PageCurrent].ad![CurrentStory].width!)/ double.parse(Story[PageCurrent].ad![CurrentStory].height!),
                                child: VideoPlayer(controller),
                              ),
                            ),
                            Positioned(
                                top: 45.0,
                                left: 10.0,
                                right: 10.0,
                                child: Column(
                                    children: <Widget>[
                                      Row(

                                        children: Story[PageCurrent].ad!.asMap().map((i, e) {
                                          return MapEntry(
                                            i,
                                            AnimatedBar(
                                              animController:animController,
                                              position: i,
                                              currentIndex: CurrentStory,
                                            ),
                                          );
                                        })
                                            .values
                                            .toList(),
                                      ),
                                    ])



                            ),


                            Positioned(
                              top: 60.0,
                              left: 15.0,
                              right: 15.0,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      controller.pause();
                                      animController.stop();


                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserShowAdmain(id: widget.PageFollowing[PageCurrent].ads![0].advertiser!.id!)
                                          )




                                      );
                                    },
                                    child: Row(
                                      children: [
                                        widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!=null?
                                        CircleAvatar(
                                            radius: 21.sp,

                                            backgroundImage:
                                            NetworkImage(widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!)
                                        ):
                                        CircleAvatar(radius: 21.sp,
                                            backgroundColor: Color(0xff7B217E),
                                            child: Icon(Icons.person_rounded,color: Colors.white,
                                              size: 15.sp,)),
                                        SizedBox(width: 10.w,),


                                        Text(widget.PageFollowing[PageCurrent].ads![0].advertiser!.name!,style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 16.sp
                                        ),),




                                      ],
                                    ),
                                  ),

                                  Spacer(),

                                  InkWell(
                                    onTap: (){
                                      controller.dispose();
                                   old.dispose();
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade400,
                                      radius: 12.sp,
                                      child:   Center(
                                        child: Icon(Icons.close_rounded,size: 15.sp,color: Colors.black,),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        );
                      }
                    }
                );
              }


          ),
        )


    );
  }
  loedImage(){

    Size size1=  _calculateImageDimension(image1: Story[PageCurrent].ad![CurrentStory].file.toString());
    print("size1");
    print(size1);


      heightImg= size1.height;
      widthImg= size1.width;



    animController.stop();
    animController.reset();
    animController.duration = Duration(seconds: 10);

    animController.forward().whenComplete(() {
    setState(() {
      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
        if (CurrentStory < Story[PageCurrent].ad!.length - 1) {
          CurrentStory++;
          StoryController.jumpToPage(CurrentStory);
        }

        else {
          if (CurrentStory == Story[PageCurrent].ad!.length - 1) {
            PageCurrent++;
            pageController.jumpToPage(PageCurrent);
          }
        }}
    });

    });


  }

  Size _calculateImageDimension({required String image1}) {
    Completer<Size> completer = Completer();
    Image image = Image.network(image1);
    Size size1= Size(0,0);

    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          size1=size;
          completer.complete(size);
        },
      ),
    );
    return size1;
  }


  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
        if (CurrentStory < Story[PageCurrent].ad!.length - 1) {
         setState(() {
           print(CurrentStory);
           StoryController.jumpToPage(CurrentStory+1);
           print(CurrentStory);
         });
        }

        else {
          if (CurrentStory == Story[PageCurrent].ad!.length - 1) {
            pageController.jumpToPage(PageCurrent+1);
          }
        }
      }

      else{
        if(end==true)
        {

          if( CurrentStory < Story[PageCurrent].ad!.length-1){
          controller.dispose();
          old.dispose();
            setState(() {
             StoryController.jumpToPage( CurrentStory+1);
             end=false;
            });
          }
          else{
            controller.dispose();
            old.dispose();
            setState(() {
              pageController.jumpToPage( PageCurrent+1);
            });

          }


        }

        else {

          forward5Seconds();
          if (controller.value.isInitialized) {
            final int duration =controller.value.duration.inMilliseconds;
            final int position =controller.value.position.inMilliseconds;


            int maxBuffering = 0;
            for (final DurationRange range in controller.value.buffered) {
              final int end = range.end.inMilliseconds;
              if (end > maxBuffering) {
                maxBuffering = end;
              }
            }
          animController.value= position / duration;
          }


        animController.forward().whenComplete(() {
          if( CurrentStory < Story[PageCurrent].ad!.length-1){
            controller.dispose();
            old.dispose();
            setState(() {
              StoryController.jumpToPage( CurrentStory+1);
              end=false;
            });
          }
          else{
            controller.dispose();
            old.dispose();
            setState(() {
              pageController.jumpToPage( PageCurrent+1);
            });

          }




          });


        }
      }

    }



    else if (dx > 2 * screenWidth / 3)
    {
      if (Story[PageCurrent].ad![CurrentStory].type == "image")


      {
        if (CurrentStory != 0) {

          setState(() {
            StoryController.jumpToPage(CurrentStory-1);
          });
        } else {
          if (CurrentStory == 0) {
            pageController.jumpToPage(PageCurrent-1);
          }
        }
      }



      else{

        if(start){
          if (CurrentStory > 0) {
            controller.dispose();
            old.dispose();
            setState(() {
              StoryController.jumpToPage(CurrentStory-1);
              start=false;
            });

          }
          else{
            if(PageCurrent!=0){

              controller.dispose();
              old.dispose();
              setState(() {
                pageController.jumpToPage( PageCurrent-1);
              });

            }
          }

        }
        else{

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
          animController.value= position / duration;
          }
         animController.forward().whenComplete(() {
           if (CurrentStory > 0) {
             controller.dispose();
             old.dispose();
             setState(() {
               StoryController.jumpToPage(CurrentStory-1);
               start=false;
             });

           }else{
             if(PageCurrent!=0){
               controller.dispose();
               old.dispose();
               setState(() {
                 pageController.jumpToPage( PageCurrent-1);
               });

             }
           }
          });


        }
      }



    }



    else{
      if ( controller.value.isPlaying) {

      controller.pause();
      animController.stop();
      } else {

        controller.play();
      animController.forward().whenComplete(() {
          setState(() {
            if( CurrentStory < Story[PageCurrent].ad!.length-1){
              controller.dispose();
              old.dispose();
              setState(() {
                CurrentStory++;
                StoryController.jumpToPage( CurrentStory);
                end=false;
              });
            }
            else{
              controller.dispose();
              old.dispose();
              setState(() {
                PageCurrent++;
                pageController.jumpToPage( PageCurrent);
              });

            }
          });
        });
      }

      if (Story[PageCurrent].ad![CurrentStory].type == "image") {
        if (animController.isAnimating) {

          animController.stop();
        } else {

          animController.forward().whenComplete(() {
            setState(() {
              if (CurrentStory < Story[PageCurrent].ad!.length - 1) {
                CurrentStory++;
                StoryController.jumpToPage(CurrentStory);
                end=false;
              }

              else {
                if (CurrentStory == Story[PageCurrent].ad!.length - 1) {
                  PageCurrent--;
                  pageController.jumpToPage(PageCurrent);

                }
              }
            } );
          });
        }

      }
    }
  }

   _loadVideo() async {
    old.dispose();
    animController.stop();
    animController.reset();
    controller = VideoPlayerController.network(Story[PageCurrent].ad![CurrentStory].file.toString());
    old = controller;
   await controller.initialize();
    var  splitted =  Story[PageCurrent].ad![CurrentStory].duration!.split('.');
    var  houres=int.parse(splitted[0]);
    var   mint=int.parse(splitted[1]);
    var second=int.parse(splitted[2]);

    animController.duration =  Duration(hours: houres,minutes:mint ,seconds:  second);
    animController.forward().whenComplete(() {

      if( CurrentStory < Story[PageCurrent].ad!.length-1){
        controller.dispose();
        old.dispose();
        setState(() {
          CurrentStory++;
          StoryController.jumpToPage( CurrentStory);
          end=false;
        });
      }
      else{
        controller.dispose();
        old.dispose();
        setState(() {
          PageCurrent++;
          pageController.jumpToPage( PageCurrent);
        });

      }
    });
    controller.play();







  }


  Future forward5Seconds() async => goToPosition((currentPosition) => currentPosition + Duration(seconds: 10));
  Future rewind5Seconds() async => goToPosition((currentPosition) => currentPosition - Duration(seconds: 10));
  Future goToPosition(Duration Function(Duration currentPosition) builder,) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition!);
    newPosition<=Duration(hours:0,minutes: 0,seconds:10 )?start=true:start=false;
    newPosition>= controller.value.duration?end=true:end=false;
    await  controller.seekTo(newPosition);





  }


    }





