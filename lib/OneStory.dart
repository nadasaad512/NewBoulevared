import 'package:new_boulevard/screens/Profile/profileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
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
  late AnimationController _animController;
  int _currentPage = 0;
  late PageController _pageController;
  List<story1> data = [];
  late VideoPlayerController _controller;
  late VideoPlayerController old;
  Future<void>? _initializeVideoPlayerFuture;
  var seen ;
  var videotime ;
  final videoInfo = FlutterVideoInfo();

  @override
  void initState() {


    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);
    _controller = VideoPlayerController.network(
      "",
    );
    old = _controller;
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  Ads ad = Ads();






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(

          onTapDown: (details) => _onTapDown(details),
          child:
          FutureBuilder<Ads>(
            future: UserApiController().AdDetalies(idAD: widget.AdId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.purple,strokeWidth: 2,));
              } else if (snapshot.hasData) {
                ad = snapshot.data!;
                data = List.from(snapshot.data!.adImages!)..addAll(List.from(snapshot.data!.adVideos!));
                return PageView.builder(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  onPageChanged: (int currentPage) {
                    setState(() {

                      _currentPage = currentPage;

                    });
                  },
                  itemBuilder: (BuildContext, index) {
                    if (data[_currentPage].type == "image") {
                      old.dispose();
                      _controller.dispose();
                      _animController.stop();
                      _animController.reset();
                      _animController.duration =Duration(seconds: 5);
                      _animController.forward().whenComplete((){
                        setState(() {
                          _currentPage < data.length - 1 ?
                          _pageController.jumpToPage(_currentPage + 1)
                              :Navigator.pop(context);

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
                        child: CachedNetworkImage(

                            imageUrl: data[_currentPage].file!.toString(),

                            imageBuilder: (context, imageProvider) =>

                                Container(
                              decoration: BoxDecoration(

                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
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
                                                          UserShowAdmain(id:ad.advertiser!.id!,)
                                                  )




                                              );
                                            },
                                            child: Row(
                                              children: [

                                                CircleAvatar(
                                                    radius: 21.sp,

                                                    backgroundImage: ad.advertiser!.imageProfile!=null?
                                                    NetworkImage(ad.advertiser!.imageProfile!):null
                                                ),
                                                SizedBox(width: 10.w,),



                                                Text(snapshot.data!.advertiser!.name!,style: TextStyle(
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
                                                      ad.details!=null?
                                                      Text(  ad.details!,style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                      ),):Container(),
                                                      SizedBox(height: 12.h,),
                                                      Row(
                                                        children: [
                                                          IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                                                          Text(" السعودية-   ${snapshot.data!.city!}",style: TextStyle(
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
                                                              ad.store_url==null?Container():
                                                              Detatlies(name:ad.store_url!,image: "images/earth.svg"),
                                                              SizedBox(height: 20.h,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  ad.twitter==null?Container():
                                                                  SvgPicture.asset("images/twitter.svg"),
                                                                  SizedBox(width: 26.w,),
                                                                  ad.instagram==null?Container():
                                                                  SvgPicture.asset("images/instegram.svg"),
                                                                  SizedBox(width: 26.w,),
                                                                  ad.whatsapp==null?Container():
                                                                  SvgPicture.asset("images/whatsapp.svg"),
                                                                  SizedBox(width: 26.w,),
                                                                  ad.facebook==null?Container():
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

                                  ]),

                            ),

                            placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.purple,strokeWidth: 2,)),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                            )






                        ),
                      );
                    }
                    else {

                      _controller.dispose();
                      _animController.stop();
                      _animController.reset();

                      _loadVideo(index: _currentPage);


                      return FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            final splitted = data[_currentPage].duration!.split('.');
                            var  houres=int.parse(splitted[0]);
                            var mint=int.parse(splitted[1]);
                            var second=int.parse(splitted[2]);
                            _animController.duration =  Duration(hours: houres,minutes:mint ,seconds:  second);
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
                                        :Navigator.pop(context);
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
                                                            UserShowAdmain(id:ad.advertiser!.id!,)
                                                    )




                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 21.sp,

                                                      backgroundImage: ad.advertiser!.imageProfile!=null?
                                                      NetworkImage(ad.advertiser!.imageProfile!):null
                                                  ),
                                                  SizedBox(width: 10.w,),

                                                  Text(ad.advertiser!.name!,style: TextStyle(
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
                                                        ad.details!=null?
                                                        Text(  ad.details!,style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400
                                                        ),):Container(),
                                                        SizedBox(height: 12.h,),
                                                        Row(
                                                          children: [
                                                            IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                                                            Text(" السعودية-   ${ad.city}",style: TextStyle(
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
                                                                ad.store_url==null?Container():
                                                                Detatlies(name:ad.store_url!,image: "images/earth.svg"),
                                                                SizedBox(height: 20.h,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    ad.twitter==null?Container():
                                                                    SvgPicture.asset("images/twitter.svg"),
                                                                    SizedBox(width: 26.w,),
                                                                    ad.instagram==null?Container():
                                                                    SvgPicture.asset("images/instegram.svg"),
                                                                    SizedBox(width: 26.w,),
                                                                    ad.whatsapp==null?Container():
                                                                    SvgPicture.asset("images/whatsapp.svg"),
                                                                    SizedBox(width: 26.w,),
                                                                    ad.facebook==null?Container():
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
                                color: Colors.purple,strokeWidth: 2,
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                );



              } else if  (snapshot.hasError){
                return   Center(child: Text(snapshot.error.toString()));
              }


              else {
                return Center(
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 80,
                    color: Colors.yellow,
                  ),
                );
              }
            },
          )


      ),

    );
  }

  time_Video(String path) async {

    var a = await videoInfo.getVideoInfo(path);
    print("Duration is ${a!.duration}");
  }
  Future _loadVideo({required int index}) async {

    old.dispose();
    _controller = VideoPlayerController.network(data[index].file.toString());
    old = _controller;
    _initializeVideoPlayerFuture = _controller.initialize();

    await _controller.value.duration;
    print('_controller.value.duration${_controller.value.duration}');
    videotime=_controller.value.duration;


    _controller.play();

    return _initializeVideoPlayerFuture;
  }
  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {


      setState(() {
        _currentPage < data.length-1 ? _pageController.jumpToPage(_currentPage + 1)
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




