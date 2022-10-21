
import 'package:new_boulevard/screens/Profile/ProfileWidgt/User_Show_Admain.dart';
import 'package:new_boulevard/screens/Profile/profileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_time/story_time.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'models/Follower_user.dart';
import 'models/ads.dart';
import 'models/detalies.dart';


class AdDetalies extends StatefulWidget {
  List<MyFollowings> SelectPage;
  late int pageindex;
  AdDetalies({required  this.SelectPage,required this.pageindex});


  @override
  State<AdDetalies> createState() => _AdDetaliesState();
}

class _AdDetaliesState extends State<AdDetalies> {

  List<story1> data = [];
  List<story1> img=[];
  Ads ad=Ads();
  List<story1> vido=[];
  List<ListStory> Story=[];
  List<INFO> info=[];
  ListStory r=ListStory();


  late VideoPlayerController _controller;
  late VideoPlayerController old;
  Future<void>? _initializeVideoPlayerFuture;
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  List<Ads> detal=[];
    Set<Marker> _markers = Set.from([]);
    BitmapDescriptor? _markerIcon;
    int indexD=0;


    @override
    void initState() {
      super.initState();
      indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(IndicatorAnimationCommand(resume: true),);
      for (var y = 0; y < widget.SelectPage.length; y++) {


        for (var i = 0; i < widget.SelectPage[i].ads!.length; i++) {
          img = widget.SelectPage[y].ads![i].adImages!;
          vido = widget.SelectPage[y].ads![i].adVideos!;
          detal.addAll(widget.SelectPage[y].ads!);
          info.add(INFO(info: widget.SelectPage[y].ads!));




      }
      Story.add(ListStory( ad:List.from(img)..addAll(List.from(vido)),page: y ,detal:detal ));

    }





    _controller = VideoPlayerController.network(
      "",
    );
    old = _controller;
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
 // indicatorAnimationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
        body: StoryPageView(

          onStoryIndexChanged: (int newStoryIndex) {




          },



          initialPage: widget.pageindex,
          onStoryPaused: (){
            _controller.pause();
          },
          onStoryUnpaused: (){
            _controller.play();
          },

          itemBuilder: (context, pageIndex, storyIndex) {
            indexD<info[pageIndex].info!.length-1?
            indexD++:null;
            _markers.add(
                Marker(markerId: MarkerId('1'),
                  position: LatLng(double.parse(info[pageIndex].info![indexD].latitude!),double.parse(info[pageIndex].info![indexD].longitude!)),
                )

            );


            final story = Story[pageIndex].ad![storyIndex];
            if (story.type == "image") {
              return CachedNetworkImage(
                  imageUrl: story.file!.toString(),
                  imageBuilder: (context, imageProvider) {
                    indicatorAnimationController.value =
                        IndicatorAnimationCommand(
                          resume: true,
                        );


                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    indicatorAnimationController.value =
                        IndicatorAnimationCommand(
                          pause: true,
                        );


                    return Container(
                      color: Colors.black,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.black,

                          strokeWidth: 2,
                          value:1 ,

                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.wifi_off_rounded,
                      size: 80,
                      color: Colors.purple,
                    ),
                  ));
            } else {

              _loadVideo(index: storyIndex,page:pageIndex );
              return   FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.done){
                      final splitted = story.duration!.split('.');
                      var  houres=int.parse(splitted[0]);
                      var mint=int.parse(splitted[1]);
                      var second=int.parse(splitted[2]);
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand(duration:  Duration(hours: houres,minutes:mint ,seconds:  second));
                      return  Container(
                          height: double.infinity,
                          width: double.infinity,
                          child:  AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )

                      );
                    }else{
                     indicatorAnimationController.value = IndicatorAnimationCommand(duration: const Duration(days: 2),);


                      return  Container(
                        color: Colors.black,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.black,

                            strokeWidth: 2,
                            value:1 ,

                          ),
                        ),
                      );
                    }


                  });


            }
          },
          indicatorAnimationController: indicatorAnimationController,
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            int num =Story[pageIndex].ad!.length;
            final user=widget.SelectPage[pageIndex];
            final story= info[pageIndex].info![indexD];
            print(info[pageIndex].info![indexD].name);
            return Stack(
              children: [
                Positioned(
                  top: 60.0,
                  left: 15.0,
                  right: 15.0,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          _controller.dispose();
                          old.dispose();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserShowAdmain(id:user.id!,)
                              )




                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 21.sp,
                                backgroundImage: user.imageProfile!=null?
                                NetworkImage(user.imageProfile!):null
                            ),
                            SizedBox(width: 10.w,),
                            Text(user.name!,style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp
                            ),),


                          ],
                        ),
                      ),

                      Spacer(),

                      InkWell(
                        onTap: (){
                          _controller.dispose();
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

                Positioned(
                  bottom: 20.h,
                  right: 34.w,
                  left: 34.w,
                  child: InkWell(
                    onTap: ()async{
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand(
                            pause: true,
                          );
                      _controller.pause();


                      await   showModalBottomSheet(

                        context: context,
                        shape:  RoundedRectangleBorder( // <-- SEE HERE
                            borderRadius:  BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft:  Radius.circular(15),
                            )
                        ),
                        builder: (context) {
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft:  Radius.circular(15),
                                  )
                              ),
                              height: 520.h,
                              width: double.infinity,
                              // alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.w,),
                                child: ListView(
                                  children: [
                                    Row(

                                      children: [

                                        Text("وصف الإعلان",style: TextStyle(
                                            color: Color(0xff7B217E),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600
                                        ),),
                                        Spacer(),

                                        InkWell(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: SvgPicture.asset("images/close.svg")),

                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    story.details!=null?
                                    Text(  story.details!,style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400
                                    ),):SizedBox.shrink(),
                                    SizedBox(height: 12.h,),
                                    Row(
                                      children: [
                                        IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                                        Text(" السعودية-   ${story.city!.name.toString()}",style: TextStyle(
                                            color: Color(0xff7B217E),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400
                                        ),),

                                      ],
                                    ),
                                    SizedBox(height: 26.h,),
                                    //map
                                    story.latitude==null&&story.latitude==null?
                                    SizedBox.shrink():
                                    Container(
                                      height: 125.h,
                                      width: 343.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)   ,
                                      ),
                                      child: GoogleMap(

                                          myLocationButtonEnabled: false,
                                          mapType: MapType.normal,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(double.parse(story.latitude!),double.parse(story.longitude!)),

                                            zoom: 14.5,
                                          ),


                                          markers:  _markers

                                      ),

                                    ),
                                    story.store_url==null&&
                                        story.instagram==null&&
                                        story.whatsapp==null&&
                                        story.facebook==null&&
                                        story.twitter==null?
                                    SizedBox.shrink():

                                    Container(
                                      width: 343.w,
                                      height: 100.h
                                      ,
                                      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.purple.shade50,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                        child: Column(
                                          children: [
                                            story.store_url==null?SizedBox.shrink():
                                            Detatlies(name:story.store_url!,image: "images/earth.svg",url:story.store_url! ),
                                            SizedBox(height: 20.h,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                story.twitter==null?SizedBox.shrink():
                                                SocialMedia(image: "images/twitter.svg",url: story.twitter.toString() ),
                                                SizedBox(width: 26.w,),
                                                story.instagram==null?SizedBox.shrink():
                                                SocialMedia(image: "images/instegram.svg",url:story.instagram.toString() ),
                                                SizedBox(width: 26.w,),
                                                story.whatsapp==null?SizedBox.shrink():
                                                SocialMedia(image: "images/whatsapp.svg",url: story.whatsapp.toString() ),
                                                SizedBox(width: 26.w,),
                                                story.facebook==null?SizedBox.shrink():
                                                SocialMedia(image: "images/facebook.svg",url:story.facebook.toString() ),


                                              ],
                                            ),
                                          ],
                                        ),
                                      ),


                                    )







                                  ],
                                ),
                              )
                          );
                        },
                      );
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand(
                            resume: true,
                          );
                      _controller.play();

                    },
                    child: Container(
                      width: 308.w,
                      height: 38.h,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)

                      ),

                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4.h,horizontal: 12.w),
                        child: Row(
                          children: [
                            SvgPicture.asset("images/show.svg"),
                            SizedBox(width: 10.w,),
                            Text('اسحب للأعلى لمعرفة المزيد عن الإعلان',style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          pageLength: Story.length,
          storyLength: (int pageIndex) {

            return Story[pageIndex].ad!.length;
          },
          onPageLimitReached: () {
            old.dispose();
            _controller.dispose();
            Navigator.pop(context);
          },
        )






    );
  }

  Future _loadVideo({required int index,required int page}) async {
    old.dispose();
    _controller = VideoPlayerController.network( Story[page].ad![index].file.toString());
    old = _controller;
    _initializeVideoPlayerFuture =  _controller.initialize();
    _controller.play();
    return _initializeVideoPlayerFuture;
  }
  Widget Detatlies({required String name, required String image,required String url}){
    return  InkWell(
      onTap: () {
        launch(url);
      },
      child: Row(
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
      ),
    );
  }
  Widget SocialMedia({required String image, required String url}){
    return   InkWell(
        onTap: () {
          launch(url);
        },

        child: SvgPicture.asset(image));
  }
}


/*
import 'package:boulevard/screens/Profile/profileScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import 'models/Follower_user.dart';
import 'models/ads.dart';
import 'models/detalies.dart';


class AdDetalies extends StatefulWidget {
  List<MyFollowings> SelectPage;
  late int pageindex;
  AdDetalies({required  this.SelectPage,required this.pageindex});


  @override
  State<AdDetalies> createState() => _AdDetaliesState();
}

class _AdDetaliesState extends State<AdDetalies> with SingleTickerProviderStateMixin{


  int _currentPage = 0;
 late int _UserPage ;
  late AnimationController _animController;
  late PageController _pageController;
  late PageController _UserController;
  List<story1> data = [];
  late VideoPlayerController _controller;
  late VideoPlayerController old;
  Future<void>? _initializeVideoPlayerFuture;


  @override
  void initState() {
    super.initState();
    _UserPage=widget.pageindex;
    _pageController = PageController();
    _animController = AnimationController(vsync: this);
    _UserController = PageController();

    _controller = VideoPlayerController.network(
      "",
    );
    old = _controller;
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _UserController.dispose();
    super.dispose();
  }


  var seen ;



  @override
  Widget build(BuildContext context) {



    return Scaffold(
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details),
          child: PageView.builder(
              itemCount: widget.SelectPage.length,
              controller: _UserController,
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              onPageChanged: (int currentPage) {
                setState(() {
                  // currentPage= widget.SelectPage;
                  _UserPage = currentPage;
                });
              },
              itemBuilder: (BuildContext, int) {
                var img;
                var vido;
                for (var i = 0; i < widget.SelectPage[_UserPage].ads!.length; i++) {
                  img = widget.SelectPage[_UserPage].ads![i].adImages!;
                  vido = widget.SelectPage[_UserPage].ads![i].adVideos!;
                }
                data = List.from(img)..addAll(List.from(vido));



                return GestureDetector(
                    onTapDown: (details) => _onTapDown(details),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      onPageChanged: (var currentPage) {
                        setState(() {
                          _currentPage = currentPage;
                        });
                      },
                      itemBuilder: (BuildContext, index) {
                        if (data[_currentPage].type == "image") {

                          old.dispose();
                          _animController.stop();
                          _animController.reset();
                          _animController.duration =Duration(seconds: 5);
                          _animController.forward().whenComplete((){
                            setState(() {
                              _currentPage < data.length - 1 ?
                              _pageController.jumpToPage(_currentPage + 1)
                                  :_UserPage< widget.SelectPage.length-1?

                              _UserController.jumpToPage(_UserPage+1):Navigator.pop(context);


                            });

                          });
                          return InkWell(
                            onLongPress: () {

                              _animController.stop();
                              seen =_animController.value;

                            },
                            onTap: () {
                              _animController.forward(from: seen).whenComplete((){
                                setState(() {
                                  _currentPage < data.length - 1 ?
                                  _pageController.jumpToPage(_currentPage + 1)
                                      :Navigator.pop(context);
                                });

                              });;


                            },
                            child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        data[_currentPage].file!),
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



                                                  children:data.asMap().map((i, e) {
                                                    return MapEntry(
                                                      i,
                                                      AnimatedBar(
                                                        animController: _animController,
                                                        position: i,
                                                        currentIndex: _currentPage,
                                                      ),
                                                    );
                                                  })
                                                      .values
                                                      .toList(),
                                                ),
                                              ])



                                      ),


                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserShowAdmain(
                                                          id: widget.SelectPage[_UserPage].id!
                                                              )
                                                )


                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 50.h,
                                                right: 18.w
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 21.sp,

                                                    backgroundImage:  widget.SelectPage[_UserPage].imageProfile!= null
                                                        ?
                                                    NetworkImage(
                                                        widget.SelectPage[_UserPage].imageProfile!)
                                                        : null
                                                ),
                                                SizedBox(width: 10.w,),

                                                Text(
                                                  widget.SelectPage[_UserPage].name!
                                                  ,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontSize: 16.sp
                                                  ),),


                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: InkWell(
                                          onTap: () {

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 50.h,
                                                left: 18.w
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey
                                                  .shade400,
                                              radius: 12.sp,
                                              child: Center(
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  size: 15.sp,
                                                  color: Colors.black,),
                                              ),
                                            ),
                                          ),
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
                                              shape: RoundedRectangleBorder( // <-- SEE HERE
                                                  borderRadius: BorderRadius
                                                      .only(
                                                    topRight: Radius.circular(
                                                        15),
                                                    topLeft: Radius.circular(
                                                        15),
                                                  )
                                              ),
                                              builder: (context) {
                                                return Container(
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.w,
                                                        vertical: 16.h),
                                                    decoration: BoxDecoration(

                                                        borderRadius: BorderRadius
                                                            .only(
                                                          topRight: Radius
                                                              .circular(15),
                                                          topLeft: Radius
                                                              .circular(15),
                                                        )
                                                    ),
                                                    height: 520.h,
                                                    width: double.infinity,

                                                    alignment: Alignment
                                                        .center,
                                                    child: ListView(
                                                      children: [
                                                        Row(

                                                          children: [


                                                            Text(
                                                              "وصف الإعلان",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff7B217E),
                                                                  fontSize: 16
                                                                      .sp,
                                                                  fontWeight: FontWeight
                                                                      .w600
                                                              ),),
                                                            Spacer(),

                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: SvgPicture
                                                                  .asset(
                                                                  "images/close.svg"),),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,),
                                                        widget.SelectPage[_UserPage].ads![_currentPage].details != null ?
                                                        Text(widget.SelectPage[_UserPage].ads![_currentPage].details!,
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight
                                                                  .w400
                                                          ),) : Container(),
                                                        SizedBox(
                                                          height: 12.h,),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {},
                                                                icon: Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Color(
                                                                      0xff7B217E),
                                                                  size: 30
                                                                      .sp,)),
                                                            Text(
                                                              " السعودية-   ${widget.SelectPage[_UserPage].ads![_currentPage].city}",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff7B217E),
                                                                  fontSize: 16
                                                                      .sp,
                                                                  fontWeight: FontWeight
                                                                      .w400
                                                              ),),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 26.h,),

                                                        Container(
                                                          width: 343.w,
                                                          height: 100.h
                                                          ,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                              horizontal: 12
                                                                  .w,
                                                              vertical: 12.h),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(5),
                                                            color: Colors
                                                                .purple
                                                                .shade50,
                                                          ),
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12
                                                                    .w,
                                                                vertical: 12
                                                                    .h),
                                                            child: Column(
                                                              children: [
                                                                widget.SelectPage[_UserPage].ads![_currentPage]
                                                                    .store_url ==
                                                                    null
                                                                    ? Container()
                                                                    :
                                                                Detatlies(
                                                                    name: widget.SelectPage[_UserPage].ads![_currentPage].store_url!
                                                                    ,
                                                                    image: "images/earth.svg"),
                                                                SizedBox(
                                                                  height: 20
                                                                      .h,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    widget.SelectPage[_UserPage].ads![_currentPage].twitter ==
                                                                        null
                                                                        ? Container()
                                                                        :
                                                                    SvgPicture
                                                                        .asset(
                                                                        "images/twitter.svg"),
                                                                    SizedBox(
                                                                      width: 26
                                                                          .w,),
                                                                    widget.SelectPage[_UserPage].ads![_currentPage].instagram ==
                                                                        null
                                                                        ? Container()
                                                                        :
                                                                    SvgPicture
                                                                        .asset(
                                                                        "images/instegram.svg"),
                                                                    SizedBox(
                                                                      width: 26
                                                                          .w,),
                                                                    widget.SelectPage[_UserPage].ads![_currentPage].whatsapp ==
                                                                        null
                                                                        ? Container()
                                                                        :
                                                                    SvgPicture
                                                                        .asset(
                                                                        "images/whatsapp.svg"),
                                                                    SizedBox(
                                                                      width: 26
                                                                          .w,),
                                                                    widget.SelectPage[_UserPage].ads![_currentPage].facebook ==
                                                                        null
                                                                        ? Container()
                                                                        :
                                                                    SvgPicture
                                                                        .asset(
                                                                        "images/facebook.svg"),

                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),


                                                        )


                                                      ],
                                                    )
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 308.w,
                                            height: 38.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius
                                                    .circular(5)

                                            ),

                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "images/show.svg"),
                                                  SizedBox(width: 10.w,),
                                                  Text(
                                                    'اسحب للأعلى لمعرفة المزيد عن الإعلان',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        fontSize: 16
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ])

                            ),
                          );
                        } else {
                          _animController.stop();
                          _animController.reset();


                          _loadVideo(index: _currentPage);
                          return FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                final splitted = data[_currentPage].duration!.split('.');
                                var  houres=double.parse(splitted[0]);
                                var mint=double.parse(splitted[1]);
                                var second=double.parse(splitted[2]);
                                _animController.duration =  Duration(hours: houres.toInt(),minutes:mint.toInt() ,seconds:  second.toInt());
                                print(_animController.duration);
                                _animController.forward().whenComplete((){
                                  setState(() {
                                    if( _currentPage < data.length - 1 ){
                                      _pageController.jumpToPage(_currentPage + 1);
                                    }else{
                                      _controller.dispose();
                                      old.dispose();
                                      Navigator.pop(context);
                                    }
                                  });

                                });


                                return InkWell(
                                  onLongPress: () {

                                    _controller.pause();
                                    _animController.stop();
                                    seen =_animController.value;
                                  },
                                  onTap: () {
                                    _controller.play();
                                    _animController.forward(from: seen).whenComplete((){
                                      setState(() {
                                        _currentPage < data.length - 1 ?
                                        _pageController.jumpToPage(_currentPage + 1)
                                            :  _UserPage< widget.SelectPage.length-1?
                                        _UserController.jumpToPage(_UserPage+1):Navigator.pop(context);
                                      });

                                    });;
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: AspectRatio(
                                      aspectRatio:
                                      _controller.value.aspectRatio,
                                      child: Stack(
                                        children: [

                                          Positioned(
                                              top: 45.0,
                                              left: 10.0,
                                              right: 10.0,
                                              child: Column(
                                                  children: <Widget>[

                                                    Row(
                                                      children:data.asMap().map((i, e) {
                                                        return MapEntry(
                                                          i,
                                                          AnimatedBar(
                                                            animController: _animController,
                                                            position: i,
                                                            currentIndex: _currentPage,
                                                          ),
                                                        );
                                                      })
                                                          .values
                                                          .toList(),
                                                    ),
                                                  ])),


                                          Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: VideoPlayer(_controller)),
                                          Positioned(
                                            top: 60.0,
                                            left: 15.0,
                                            right: 15.0,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    _controller.dispose();
                                                    old.dispose();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserShowAdmain(id:widget.SelectPage[_UserPage].id!)
                                                        )




                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          radius: 21.sp,

                                                          backgroundImage: widget.SelectPage[_UserPage].imageProfile==null?
                                                          NetworkImage(widget.SelectPage[_UserPage].imageProfile!):null
                                                      ),
                                                      SizedBox(width: 10.w,),

                                                      Text(widget.SelectPage[_UserPage].name!,style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16.sp
                                                      ),),


                                                    ],
                                                  ),
                                                ),

                                                Spacer(),

                                                InkWell(
                                                  onTap: (){
                                                    _controller.dispose();
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

                                          Positioned(
                                            bottom: 20.h,
                                            right: 34.w,
                                            left: 34.w,
                                            child: InkWell(
                                              onTap: (){


                                                showModalBottomSheet(
                                                  context: context,
                                                  shape:  RoundedRectangleBorder( // <-- SEE HERE
                                                      borderRadius:  BorderRadius.only(
                                                        topRight: Radius.circular(15),
                                                        topLeft:  Radius.circular(15),
                                                      )
                                                  ),
                                                  builder: (context) {
                                                    return Container(
                                                        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                                                        decoration: BoxDecoration(

                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(15),
                                                              topLeft:  Radius.circular(15),
                                                            )
                                                        ),
                                                        height: 520.h,
                                                        width: double.infinity,

                                                        alignment: Alignment.center,
                                                        child: ListView(
                                                          children: [
                                                            Row(

                                                              children: [


                                                                Text("وصف الإعلان",style: TextStyle(
                                                                    color: Color(0xff7B217E),
                                                                    fontSize: 16.sp,
                                                                    fontWeight: FontWeight.w600
                                                                ),),
                                                                Spacer(),

                                                                IconButton(onPressed: (){
                                                                  Navigator.pop(context);
                                                                }, icon: SvgPicture.asset("images/close.svg"),),

                                                              ],
                                                            ),
                                                            SizedBox(height: 10.h,),
                                                            widget.SelectPage[_UserPage].ads![_currentPage].details!=null?
                                                            Text(  widget.SelectPage[_UserPage].ads![_currentPage].details!,style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w400
                                                            ),):Container(),
                                                            SizedBox(height: 12.h,),
                                                            Row(
                                                              children: [
                                                                IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                                                                Text(" السعودية-   ${widget.SelectPage[_UserPage].ads![_currentPage].city}",style: TextStyle(
                                                                    color: Color(0xff7B217E),
                                                                    fontSize: 16.sp,
                                                                    fontWeight: FontWeight.w400
                                                                ),),

                                                              ],
                                                            ),
                                                            SizedBox(height: 26.h,),

                                                            Container(
                                                              width: 343.w,
                                                              height: 100.h
                                                              ,
                                                              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                color: Colors.purple.shade50,
                                                              ),
                                                              child: Container(
                                                                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                                                child: Column(
                                                                  children: [
                                                                    widget.SelectPage[_UserPage].ads![_currentPage].store_url==null?Container():
                                                                    Detatlies(name:widget.SelectPage[_UserPage].ads![_currentPage].store_url!,image: "images/earth.svg"),
                                                                    SizedBox(height: 20.h,),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        widget.SelectPage[_UserPage].ads![_currentPage].twitter==null?Container():
                                                                        SvgPicture.asset("images/twitter.svg"),
                                                                        SizedBox(width: 26.w,),
                                                                        widget.SelectPage[_UserPage].ads![_currentPage].instagram==null?Container():
                                                                        SvgPicture.asset("images/instegram.svg"),
                                                                        SizedBox(width: 26.w,),
                                                                        widget.SelectPage[_UserPage].ads![_currentPage].whatsapp==null?Container():
                                                                        SvgPicture.asset("images/whatsapp.svg"),
                                                                        SizedBox(width: 26.w,),
                                                                        widget.SelectPage[_UserPage].ads![_currentPage].facebook==null?Container():
                                                                        SvgPicture.asset("images/facebook.svg"),

                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),


                                                            )






                                                          ],
                                                        )
                                                    );


                                                  },
                                                );

                                              },
                                              child: Container(
                                                width: 308.w,
                                                height: 38.h,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(5)

                                                ),

                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical: 4.h,horizontal: 12.w),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset("images/show.svg"),
                                                      SizedBox(width: 10.w,),
                                                      Text('اسحب للأعلى لمعرفة المزيد عن الإعلان',style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16
                                                      ),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return SizedBox(

                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                    )


                );
              }
          ),
        )


    );
  }

  Future _loadVideo({required int index}) async {
    old.dispose();
    _controller = VideoPlayerController.network(data[index].file.toString());
    old = _controller;
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    return _initializeVideoPlayerFuture;
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        _currentPage < 3 ? _pageController.jumpToPage(_currentPage + 1)
            : null;
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentPage > 0) {
          if (_currentPage == 1) {
            _currentPage = 0;
          } else {
            _pageController.jumpToPage(_currentPage - 1);
          }
        }
      });
    }
  }

  Widget Detatlies({required String name, required String image}) {
    return Row(
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
}


class AnimatedBar extends StatefulWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(

          builder: (context, constraints) {
            return Stack(
              children: <Widget>[

                _buildContainer(
                  double.infinity,
                  widget.position < widget.currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                widget.position == widget.currentIndex
                    ? AnimatedBuilder(
                  animation: widget.animController,

                  builder: (context, child) {
                    return _buildContainer(

                      constraints.maxWidth * widget.animController.value,
                      Colors.white,
                    );
                  },
                )
                    : const SizedBox.shrink(),



              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

 */
