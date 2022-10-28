import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:new_boulevard/screens/Profile/ProfileWidgt/profileScreen.dart';
import 'package:new_boulevard/story/ListStoryWidget/videolist.dart';
import 'package:new_boulevard/story/imageitem.dart';
import 'package:new_boulevard/story/videostory.dart';
import 'package:video_player/video_player.dart';
import 'api/User_Controller.dart';
import 'models/Follower_user.dart';
import 'models/ads.dart';
import 'models/detalies.dart';

class ListStoryScreen extends StatefulWidget {
  List<MyFollowings> PageFollowing;
  late int initialindex;

  ListStoryScreen({required this.initialindex, required this.PageFollowing});

  @override
  _ListStoryScreenState createState() => _ListStoryScreenState();
}

class _ListStoryScreenState extends State<ListStoryScreen>
    with SingleTickerProviderStateMixin {
  int CurrentPage = 0;
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

    PageCurrent=widget.initialindex;
    UserApiController().AdDetalies(idAD: widget.PageFollowing[PageCurrent].ads![0].id!);
    animController = AnimationController(vsync: this);
    controller = VideoPlayerController.network("");
    controller.initialize();
    old = controller;
    for (var y = 0; y < widget.PageFollowing.length; y++) {
      for (var i = 0; i < widget.PageFollowing[y].ads!.length; i++) {
        img.addAll(widget.PageFollowing[y].ads![i].adImages!);
        vido.addAll(widget.PageFollowing[y].ads![i].adVideos!);


      }

      Story.add(ListStory(ad: List.from(img)
        ..addAll(List.from(vido)), page: y,lengthad:widget.PageFollowing[y].ads!.length ));
      img = [];
      vido = [];
    }

    pageController = PageController();
    StoryController = PageController();

  }

  @override
  void dispose() {
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
              onPageChanged: (int? onPageChanged)async {

                controller.dispose();
                old.dispose();
                setState(() {
                  PageCurrent = onPageChanged!;
                  CurrentPage=0;
                  PageDetal=0;
                });

                await UserApiController().AdDetalies(idAD: widget.PageFollowing[PageCurrent].ads![0].id!);
              },

              itemBuilder: (BuildContext, index) {
                return PageView.builder(
                    itemCount: Story.length,
                    controller: StoryController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int currentPage) {
                      setState(() {

                        CurrentPage = currentPage;
                      });
                    },
                    itemBuilder: (BuildContext, index) {
                      if (Story[PageCurrent].ad![CurrentPage].type == "image") {
                        loedImage();



                        return Container(
                          height:heightImg,
                          width: widthImg,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(

                              image: NetworkImage(Story[PageCurrent].ad![CurrentPage].file.toString()),
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
                                                currentIndex: CurrentPage,
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

                                          CircleAvatar(
                                              radius: 21.sp,

                                              backgroundImage:widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!=null?
                                              NetworkImage(widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!):null
                                          ),
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
                              child: Container(

                                height:Story[PageCurrent].ad![CurrentPage].height==null?double.infinity: double.parse(Story[PageCurrent].ad![CurrentPage].height!),

                                width:Story[PageCurrent].ad![CurrentPage].width==null?double.infinity: double.parse(Story[PageCurrent].ad![CurrentPage].width!),
                                child: AspectRatio(
                                  aspectRatio:controller.value.aspectRatio,
                                  child: VideoPlayer(controller),
                                ),
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
                                              currentIndex: CurrentPage,
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

                                        CircleAvatar(
                                            radius: 21.sp,

                                            backgroundImage:widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!=null?
                                            NetworkImage(widget.PageFollowing[PageCurrent].ads![0].advertiser!.imageProfile!):null
                                        ),
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

                            // Positioned(
                            //   bottom: 20.h,
                            //   right: 34.w,
                            //   left: 34.w,
                            //   child: InkWell(
                            //     onTap: (){
                            //
                            //
                            //       showModalBottomSheet(
                            //         context: context,
                            //         shape:  RoundedRectangleBorder(
                            //             borderRadius:  BorderRadius.only(
                            //               topRight: Radius.circular(15),
                            //               topLeft:  Radius.circular(15),
                            //             )
                            //         ),
                            //         builder: (context) {
                            //           var ad=widget.ad;
                            //           return Container(
                            //               margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                            //               decoration: BoxDecoration(
                            //
                            //                   borderRadius: BorderRadius.only(
                            //                     topRight: Radius.circular(15),
                            //                     topLeft:  Radius.circular(15),
                            //                   )
                            //               ),
                            //               height: 520.h,
                            //               width: double.infinity,
                            //
                            //               alignment: Alignment.center,
                            //               child: ListView(
                            //                 children: [
                            //                   Row(
                            //
                            //                     children: [
                            //
                            //
                            //                       Text("وصف الإعلان",style: TextStyle(
                            //                           color: Color(0xff7B217E),
                            //                           fontSize: 16.sp,
                            //                           fontWeight: FontWeight.w600
                            //                       ),),
                            //                       Spacer(),
                            //
                            //                       IconButton(onPressed: (){
                            //                         Navigator.pop(context);
                            //                       }, icon: SvgPicture.asset("images/close.svg"),),
                            //
                            //                     ],
                            //                   ),
                            //                   SizedBox(height: 10.h,),
                            //                   ad.details!=null?
                            //                   Text(  ad.details!,style: TextStyle(
                            //                       fontSize: 14.sp,
                            //                       fontWeight: FontWeight.w400
                            //                   ),):Container(),
                            //                   SizedBox(height: 12.h,),
                            //                   Row(
                            //                     children: [
                            //                       IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                            //                       Text(" السعودية-   ${ad.city!.name.toString()}",style: TextStyle(
                            //                           color: Color(0xff7B217E),
                            //                           fontSize: 16.sp,
                            //                           fontWeight: FontWeight.w400
                            //                       ),),
                            //
                            //                     ],
                            //                   ),
                            //                   SizedBox(height: 26.h,),
                            //
                            //                   Container(
                            //                     width: 343.w,
                            //                     height: 100.h
                            //                     ,
                            //                     margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            //                     decoration: BoxDecoration(
                            //                       borderRadius: BorderRadius.circular(5),
                            //                       color: Colors.purple.shade50,
                            //                     ),
                            //                     child: Container(
                            //                       margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            //                       child: Column(
                            //                         children: [
                            //                           ad.store_url==null?Container():
                            //                           Detatlies(name:ad.store_url!,image: "images/earth.svg"),
                            //                           SizedBox(height: 20.h,),
                            //
                            //                           Row(
                            //                             mainAxisAlignment: MainAxisAlignment.center,
                            //                             children: [
                            //                               ad.twitter==null?Container():
                            //                               Social(image: "images/twitter.svg",link:ad.twitter.toString() ),
                            //                               SizedBox(width: 26.w,),
                            //                               ad.instagram==null?Container():
                            //                               Social(image: "images/instegram.svg",link:ad.instagram.toString() ),
                            //                               SizedBox(width: 26.w,),
                            //                               ad.whatsapp==null?Container():
                            //                               Social(image: "images/whatsapp.svg",link: "https://wa.me/${ad.whatsapp}/?text=${Uri.parse("Hi")}"),
                            //                               SizedBox(width: 26.w,),
                            //                               ad.facebook==null?Container():
                            //                               Social(image:"images/facebook.svg",link:ad.facebook.toString() ),
                            //
                            //
                            //                             ],
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //
                            //
                            //                   )
                            //
                            //
                            //
                            //
                            //
                            //
                            //                 ],
                            //               )
                            //           );
                            //
                            //
                            //         },
                            //       );
                            //
                            //     },
                            //     child: Container(
                            //       width: 308.w,
                            //       height: 38.h,
                            //       decoration: BoxDecoration(
                            //           color: Colors.grey,
                            //           borderRadius: BorderRadius.circular(5)
                            //
                            //       ),
                            //
                            //       child: Container(
                            //         margin: EdgeInsets.symmetric(vertical: 4.h,horizontal: 12.w),
                            //         child: Row(
                            //           children: [
                            //             SvgPicture.asset("images/show.svg"),
                            //             SizedBox(width: 10.w,),
                            //             Text('اسحب للأعلى لمعرفة المزيد عن الإعلان',style: TextStyle(
                            //                 fontWeight: FontWeight.w600,
                            //                 fontSize: 16
                            //             ),)
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
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

    Size size1=  _calculateImageDimension(image1: Story[PageCurrent].ad![CurrentPage].file.toString());
    print("size1");
    print(size1);


      heightImg= size1.height;
      widthImg= size1.width;



    animController.stop();
    animController.reset();
    animController.duration = Duration(seconds: 5);

    animController.forward().whenComplete(() {
    setState(() {
      if (Story[PageCurrent].ad![CurrentPage].type == "image") {
        if (CurrentPage < Story[PageCurrent].ad!.length - 1) {
          CurrentPage++;
          StoryController.jumpToPage(CurrentPage);
        }

        else {
          if (CurrentPage == Story[PageCurrent].ad!.length - 1) {
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
      if (Story[PageCurrent].ad![CurrentPage].type == "image") {
        if (CurrentPage < Story[PageCurrent].ad!.length - 1) {
          CurrentPage++;
          StoryController.jumpToPage(CurrentPage);
        }

        else {
          if (CurrentPage == Story[PageCurrent].ad!.length - 1) {
            PageCurrent++;
            pageController.jumpToPage(PageCurrent);
          }
        }
      }

      else{
        if(end==true)
        {

          if( CurrentPage < Story[PageCurrent].ad!.length-1){
          controller.dispose();
          old.dispose();
            setState(() {
             CurrentPage++;
             StoryController.jumpToPage( CurrentPage);
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
          if( CurrentPage < Story[PageCurrent].ad!.length-1){
            controller.dispose();
            old.dispose();
            setState(() {
              CurrentPage++;
              StoryController.jumpToPage( CurrentPage);
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


        }
      }

    }



    else if (dx > 2 * screenWidth / 3)
    {
      if (Story[PageCurrent].ad![CurrentPage].type == "image")


      {
        if (CurrentPage != 0) {

          setState(() {
            CurrentPage--;
            StoryController.jumpToPage(CurrentPage);
          });
        } else {
          if (CurrentPage == 0) {
            PageCurrent--;
            pageController.jumpToPage(PageCurrent);
          }
        }
      }



      else{

        if(start){
          if (CurrentPage > 0) {
            controller.dispose();
            old.dispose();
            setState(() {
              CurrentPage--;
              StoryController.jumpToPage(CurrentPage);
              start=false;
            });

          }
          else{
            if(PageCurrent!=0){

              controller.dispose();
              old.dispose();
              setState(() {
                PageCurrent--;
                pageController.jumpToPage( PageCurrent);
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
           if (CurrentPage > 0) {
             controller.dispose();
             old.dispose();
             setState(() {
               CurrentPage--;
               StoryController.jumpToPage(CurrentPage);
               start=false;
             });

           }else{
             if(PageCurrent!=0){
               controller.dispose();
               old.dispose();
               setState(() {
                 PageCurrent--;
                 pageController.jumpToPage( PageCurrent);
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
            if( CurrentPage < Story[PageCurrent].ad!.length-1){
              controller.dispose();
              old.dispose();
              setState(() {
                CurrentPage++;
                StoryController.jumpToPage( CurrentPage);
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

      if (Story[PageCurrent].ad![CurrentPage].type == "image") {
        if (animController.isAnimating) {

          animController.stop();
        } else {

          animController.forward().whenComplete(() {
            setState(() {
              if (CurrentPage < Story[PageCurrent].ad!.length - 1) {
                CurrentPage++;
                StoryController.jumpToPage(CurrentPage);
                end=false;
              }

              else {
                if (CurrentPage == Story[PageCurrent].ad!.length - 1) {
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
    controller = VideoPlayerController.network(Story[PageCurrent].ad![CurrentPage].file.toString());
    old = controller;
   await controller.initialize();
    var  splitted =  Story[PageCurrent].ad![CurrentPage].duration!.split('.');
    var  houres=int.parse(splitted[0]);
    var   mint=int.parse(splitted[1]);
    var second=int.parse(splitted[2]);

    animController.duration =  Duration(hours: houres,minutes:mint ,seconds:  second);
    animController.forward().whenComplete(() {

      if( CurrentPage < Story[PageCurrent].ad!.length-1){
        controller.dispose();
        old.dispose();
        setState(() {
          CurrentPage++;
          StoryController.jumpToPage( CurrentPage);
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


  Future forward5Seconds() async => goToPosition((currentPosition) => currentPosition + Duration(seconds: 5));
  Future rewind5Seconds() async => goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));
  Future goToPosition(Duration Function(Duration currentPosition) builder,) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition!);
    newPosition<=Duration(hours:0,minutes: 0,seconds:5 )?start=true:start=false;
    newPosition>= controller.value.duration?end=true:end=false;
    await  controller.seekTo(newPosition);





  }


    }





