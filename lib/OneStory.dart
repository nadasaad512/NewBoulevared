
import 'package:flutter/material.dart';
import 'package:new_boulevard/story/imageitem.dart';
import 'package:new_boulevard/story/videostory.dart';
import 'package:video_player/video_player.dart';
import 'api/User_Controller.dart';
import 'models/ads.dart';
import 'models/detalies.dart';

class StoryPage extends StatefulWidget {
  int AdId;
  StoryPage({required this.AdId});
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with SingleTickerProviderStateMixin {
  int CurrentPage = 0;
  late PageController pageController;
  late AnimationController animController;
  List<story1> StroryData = [];
  late VideoPlayerController controller;
  late VideoPlayerController old;
  Ads ad = Ads();


  @override
  void initState() {
    super.initState();
    pageController = PageController();
    animController = AnimationController(vsync: this);

    controller=VideoPlayerController.network("");
    controller.initialize();
    old = controller;
    UserApiController().AdDetalies(idAD: widget.AdId).then((value) {
     setState(() {
       ad=value;
       StroryData = List.from(value.adImages!)..addAll(List.from(value.adVideos!));
     });
     setState(() {
       StroryData;


     });

    });




  }

  @override
  void dispose() {
    pageController.dispose();
    controller.dispose();
    super.dispose();
  }








  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(

          onTapDown: (details) => _onTapDown(details),
          child: PageView.builder(
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
                old.dispose();

                animController.duration =Duration(seconds: 5);
                animController.forward().whenComplete((){
                  setState(() {
                    CurrentPage < StroryData.length - 1 ?
                    pageController.jumpToPage(CurrentPage + 1)
                        :Navigator.pop(context);

                  });

                });

                return ImageStoryScreen(
                  StroryData: StroryData[CurrentPage],
                  animController:animController,
                  currentPage: CurrentPage,
                  data: StroryData,
                  ad: ad,
                );
              }
              else {



                return  VideoStoryScreen(controller: controller,
                  old: old,StroryData: StroryData[CurrentPage],
                  currentPage:CurrentPage ,
                animController: animController,
                pageController: pageController,
                Len_StroryData: StroryData.length,
                data: StroryData,
                ad: ad,);}
            },
          )



      ),






    );
  }
  Future forward5Seconds() async => goToPosition((currentPosition) => currentPosition + Duration(seconds: 5));
  Future rewind5Seconds() async => goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));
  Future goToPosition(Duration Function(Duration currentPosition) builder,) async {
    final currentPosition = await  controller.position;
    final newPosition = builder(currentPosition!);
    await  controller.seekTo(newPosition);
  }


  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if(StroryData[CurrentPage].type == "image"){
        setState(() {
          CurrentPage < StroryData.length-1 ?
          pageController.jumpToPage(CurrentPage + 1)
              : null;
        });
      }else{
        null;
      }




    } else if (dx > 2 * screenWidth / 3) {
      if(StroryData[CurrentPage].type == "image"){
        setState(() {
          if (CurrentPage > 0) {
            if (CurrentPage == 1) {
              CurrentPage = 0;
            } else {
              pageController.jumpToPage(CurrentPage - 1);
            }
          }
        });
      }else{
        null;

      }





    }
  }






}





