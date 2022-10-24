
import 'package:flutter/material.dart';
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
  ListStoryScreen({required  this.initialindex,required this.PageFollowing});
  @override
  _ListStoryScreenState createState() => _ListStoryScreenState();
}

class _ListStoryScreenState extends State<ListStoryScreen> with SingleTickerProviderStateMixin {
  int CurrentPage = 0;
  int PageCurrent = 0;
  late PageController pageController;
  late PageController StoryController;
  late AnimationController animController;
  late VideoPlayerController controller;
  late VideoPlayerController old;
  List<story1> img=[];
  List<story1> vido=[];
  List<ListStory> Story=[];







  @override
  void initState() {
    super.initState();
    animController = AnimationController(vsync: this);
    controller=VideoPlayerController.network("");
    controller.initialize();
    old = controller;
    for (var y = 0; y < widget.PageFollowing.length; y++) {
            print(y);
            print(widget.PageFollowing[y]);
      // for (var i = 0; i < widget.PageFollowing[i].ads.length; i++) {
      //   print(i);
      //   img = widget.PageFollowing[y].ads![i].adImages!;
      //   vido = widget.PageFollowing[y].ads![i].adVideos!;
      //   // detal.addAll(widget.SelectPage[y].ads!);
      //   // info.add(INFO(info: widget.SelectPage[y].ads!));
      //
      //
      //
      //
      // }
      Story.add(ListStory( ad:List.from(img)..addAll(List.from(vido))));

    }


    print("story");
    print(Story.length);
    pageController = PageController();
    StoryController = PageController();





  }

  @override
  void dispose() {
    pageController.dispose();
    StoryController.dispose();
    controller.dispose();

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
            onPageChanged: (int? onPageChanged){
              setState(() {
                PageCurrent=onPageChanged!;
              });
              },

            itemBuilder:(BuildContext, index){
              return  PageView.builder(
              itemCount:Story.length,
                  onPageChanged: (int? onPageChanged){
                     CurrentPage=onPageChanged!;
                   },
                  itemBuilder:(BuildContext, index){

                return   Story[PageCurrent].ad![CurrentPage].type=="image"?
                ImageStoryScreen(
                  StroryData:Story[PageCurrent].ad![CurrentPage],
                  animController:animController,
                  currentPage: CurrentPage,
                  data: Story[PageCurrent].ad!,
                  ad: widget.PageFollowing[0].ads![0],
                ):
                VideoStoryScreen(
                  controller: controller,
                  old: old,
                  StroryData:Story[PageCurrent].ad![CurrentPage],
                  currentPage:CurrentPage ,
                  animController: animController,
                  pageController: pageController,
                  Len_StroryData: Story.length,
                  data:  Story[PageCurrent].ad!,
                  ad: widget.PageFollowing[0].ads![0],
                );


            }
            );}


        ),
      )






    );
  }



  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if(Story[PageCurrent].ad![CurrentPage].type == "image"){
        setState(() {
          CurrentPage < Story[PageCurrent].ad!.length-1 ?
          pageController.jumpToPage(CurrentPage + 1)
              : null;
        });
      }else{
        null;
      }




    } else if (dx > 2 * screenWidth / 3) {
      if(Story[PageCurrent].ad![CurrentPage].type == "image"){
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





