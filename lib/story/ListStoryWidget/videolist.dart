
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../models/Follower_user.dart';
import '../../models/ads.dart';
import '../../models/detalies.dart';
import '../../screens/Details/ad_story_screen.dart';
import '../../screens/Profile/ProfileWidgt/profileScreen.dart';



class VideoListScreen extends StatefulWidget{
  VideoPlayerController controller;
  VideoPlayerController old;
  PageController pageController;
  PageController StoryController;
  AnimationController animController;
  int currentPage;
  int PageCureent;
  story1 image_videoData;

  int Len_image_videoData;
  List<story1> data;
  List<MyFollowings> PageFollowing;
  VideoListScreen({
    required this.controller,
    required this.old,
    required this.image_videoData,
    required this.currentPage,
    required this.PageCureent,
    required this.pageController,
    required this.StoryController,
    required this.Len_image_videoData,
    required this.animController,
    required this.data,
    required this.PageFollowing
  });
  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen>{
  bool start=false;
  bool end=false;
  var splitted;
  var  houres;
  var mint;
  var second;
  double value=0.5;
  var cut;
  var splittime;
  var edit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.animController.stop();
    widget.controller = VideoPlayerController.network(widget.image_videoData.file.toString());
    widget.controller.initialize();
    widget.old =  widget.controller;
    splitted =  widget.image_videoData.duration!.split('.');
    houres=int.parse(splitted[0]);
    mint=int.parse(splitted[1]);
    second=int.parse(splitted[2]);
    widget.animController.reset();
    widget.animController.duration =  Duration(hours: houres,minutes:mint ,seconds:  second);
    widget.animController.forward().whenComplete(() {

        // widget.currentPage < widget.Len_image_videoData-1 ?
        // widget. pageController.jumpToPage( widget.currentPage + 1)
        //     : Navigator.pop(context);

    });

    widget.controller.play();



  }

  @override
  void dispose() {

    widget.controller.dispose();
    widget.animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTapDown: (details) => _onTapDown(details),
     child: Container(
       height: double.infinity,
       width: double.infinity,
       color: Colors.black,
       child:  Stack(
         children: [
           Center(
             child: Container(

               height:widget.image_videoData.height==null?double.infinity: double.parse(widget.image_videoData.height!),

               width: widget.image_videoData.width==null?double.infinity: double.parse(widget.image_videoData.width!),
               child: AspectRatio(
                 aspectRatio: widget.controller.value.aspectRatio,
                 child: VideoPlayer(widget.controller),
               ),
             ),
           ),


           Align(
             alignment: Alignment.centerRight,
             child: IconButton(onPressed: (){





               setState(() {


                 widget.currentPage++;
                 setState(() {
                   widget.currentPage;
                 });

                 widget. StoryController.jumpToPage( widget.currentPage);
                 setState(() {
                   widget.currentPage;
                 });

                 widget.currentPage;
                 print(widget.currentPage);
               });

             }, icon: Icon(Icons.arrow_downward_rounded,color: Colors.white,)),
           ),

           Positioned(
               top: 45.0,
               left: 10.0,
               right: 10.0,
               child: Column(
                   children: <Widget>[
                     Row(

                       children:widget.data.asMap().map((i, e) {
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
                   ])



           ),
           //
           // Positioned(
           //   top: 60.0,
           //   left: 15.0,
           //   right: 15.0,
           //   child: Row(
           //     children: [
           //       InkWell(
           //         onTap: (){
           //           Navigator.push(
           //               context,
           //               MaterialPageRoute(
           //                   builder: (context) =>
           //                       UserShowAdmain(id:widget.ad.advertiser!.id!,)
           //               )
           //
           //
           //
           //
           //           );
           //         },
           //         child: Row(
           //           children: [
           //
           //             CircleAvatar(
           //                 radius: 21.sp,
           //
           //                 backgroundImage: widget.ad.advertiser!.imageProfile!=null?
           //                 NetworkImage(widget.ad.advertiser!.imageProfile!):null
           //             ),
           //             SizedBox(width: 10.w,),
           //
           //
           //             Text(widget.ad.advertiser!.name!,style: TextStyle(
           //                 fontWeight: FontWeight.w600,
           //                 color: Colors.white,
           //                 fontSize: 16.sp
           //             ),),
           //
           //
           //
           //
           //           ],
           //         ),
           //       ),
           //
           //       Spacer(),
           //
           //       InkWell(
           //         onTap: (){
           //           widget.controller.dispose();
           //           widget.old.dispose();
           //           Navigator.pop(context);
           //         },
           //         child: CircleAvatar(
           //           backgroundColor: Colors.grey.shade400,
           //           radius: 12.sp,
           //           child:   Center(
           //             child: Icon(Icons.close_rounded,size: 15.sp,color: Colors.black,),
           //           ),
           //         ),
           //       ),
           //
           //     ],
           //   ),
           // ),
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
       ),




     ),
   );
  }
  Future forward5Seconds() async => goToPosition((currentPosition) => currentPosition + Duration(seconds: 5));
  Future rewind5Seconds() async => goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));
  Future goToPosition(Duration Function(Duration currentPosition) builder,) async {
    final currentPosition = await  widget.controller.position;
    final newPosition = builder(currentPosition!);
    newPosition<=Duration(hours:0,minutes: 0,seconds:5 )?start=true:start=false;
    newPosition>= widget.controller.value.duration?end=true:end=false;
    await  widget.controller.seekTo(newPosition);





  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {

      if(end==true)
      {

        if( widget.currentPage < widget.data.length-1){
          // widget.controller.dispose();
          // widget.old.dispose();
          // setState(() {
          //   widget.currentPage++;
          //   widget. StoryController.jumpToPage( widget.currentPage);
          // });
        }
        else{
          // widget.controller.dispose();
          // widget.old.dispose();
          // widget.pageController.jumpToPage(widget.PageCureent + 1);


        }


      }

      else {

        forward5Seconds();
        if (widget.controller.value.isInitialized) {
          final int duration = widget.controller.value.duration.inMilliseconds;
          final int position = widget.controller.value.position.inMilliseconds;


          int maxBuffering = 0;
          for (final DurationRange range in widget.controller.value.buffered) {
            final int end = range.end.inMilliseconds;
            if (end > maxBuffering) {
              maxBuffering = end;
            }
          }
          widget.animController.value= position / duration;
        }


        widget. animController.forward().whenComplete(() {
          //
          // setState(() {
          //   if( widget.currentPage < widget.data.length-1){
          //     widget.controller.dispose();
          //     widget.old.dispose();
          //     widget.currentPage++;
          //     widget. StoryController.jumpToPage( widget.currentPage);
          //     print( 'widget.currentPage');
          //     print( widget.currentPage);
          //   }else{
          //     widget.controller.dispose();
          //     widget.old.dispose();
          //     Navigator.pop(context);
          //   }
          //
          // });




        });


      }
    }

    else if (dx > 2 * screenWidth / 3) {

      if(start){
        if (widget.currentPage > 0) {
          // widget.controller.dispose();
          // widget.old.dispose();
          // widget.StoryController.jumpToPage(widget.currentPage - 1);
        }else{
          if(widget.PageCureent!=0){
            // widget.controller.dispose();
            // widget.old.dispose();
            // widget.pageController.jumpToPage(widget.PageCureent - 1);
          }
        }

      }
      else{

        rewind5Seconds();
        if (widget.controller.value.isInitialized) {
          final int duration = widget.controller.value.duration.inMilliseconds;
          final int position = widget.controller.value.position.inMilliseconds;


          int maxBuffering = 0;
          for (final DurationRange range in widget.controller.value.buffered) {
            final int end = range.end.inMilliseconds;
            if (end > maxBuffering) {
              maxBuffering = end;
            }
          }
          widget.animController.value= position / duration;
        }
        widget.  animController.forward().whenComplete(() {
          // setState(() {
          //
          //   if(widget.currentPage < widget.data.length-1 ){
          //     widget.controller.dispose();
          //     widget.old.dispose();
          //     setState(() {
          //       widget.currentPage++;
          //       widget. StoryController.jumpToPage( widget.currentPage);
          //     });
          //   }else{
          //     if(widget.PageFollowing.length!=0){
          //       widget.controller.dispose();
          //       widget.old.dispose();
          //       widget.pageController.jumpToPage(widget.PageCureent - 1);
          //     }
          //   }
          //
          // });
        });


      }

    }








    else{
      if ( widget.controller.value.isPlaying) {

        widget.controller.pause();
        widget.animController.stop();
      } else {

        widget. controller.play();
        // widget.  animController.forward().whenComplete(() {
        //   setState(() {
        //     widget.currentPage < widget.Len_image_videoData-1 ?
        //     widget. pageController.jumpToPage( widget.currentPage + 1)
        //         : Navigator.pop(context);
        //   });
        // });
      }
    }
  }
  Widget Detatlies({required String name, required String image}){
    return  Row(
      children: [

        SvgPicture.asset(image),
        SizedBox(width: 10.w,),
        Text(
          name,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
  Widget Social({required String link, required String image}){
    return   InkWell(
        onTap: (){
          launch(link);

        }
        ,
        child: SvgPicture.asset(image));
  }

}