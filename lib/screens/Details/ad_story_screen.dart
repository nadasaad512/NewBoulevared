import 'package:new_boulevard/models/detalies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../api/User_Controller.dart';
import '../../models/categories.dart';

class StoryAdsScreen extends StatefulWidget{
  @override
  State<StoryAdsScreen> createState() => _StoryAdsScreenState();
}

class _StoryAdsScreenState extends State<StoryAdsScreen> with SingleTickerProviderStateMixin{
  int _currentPage = 0;
  late PageController _pageController;
  late AnimationController _animationController;
  List<Ads> ads = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _animationController=AnimationController(vsync: this);
   // final Ads firstStory = ads.first;
   // _loadStory(ad: firstStory, animateToPage: false);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_currentPage + 1 < ads.length) {
            _currentPage += 1;
            _loadStory(ad: ads[_currentPage]);
          } else {
            _currentPage = 0;
           _loadStory(ad: ads[_currentPage]);
          }
        });
      }
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Ads>>(
        future: UserApiController().ALLADSFiltter( cityid: 8),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            ads = snapshot.data ?? [];
            return   GestureDetector(
              onTapUp: (details)=>(_OnTapDown(details, ads[_currentPage])),
              child: PageView.builder(
                controller: _pageController,
                  onPageChanged: (int currentPage) {
                    setState(() {
                      _currentPage = currentPage;
                    });
                  },
                physics: NeverScrollableScrollPhysics(),
                  itemCount: ads.length,
                  itemBuilder: (context,i){
                  return  Center(
                    child: Container(
                      decoration:BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(ads[i].image.toString())
                        ),

                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 50.h,),
                            Row(
                              children: [
                                CircleAvatar(),
                                SizedBox(width: 10.w,),
                                Text("Nada"),
                                Spacer(),
                                IconButton(onPressed: (){}, icon: Icon(Icons.close))
                              ],
                            ),

                            Spacer(),

                            InkWell(
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
                                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
                                                  }, icon: SvgPicture.asset("images/close.svg"),),

                                                ],
                                              ),
                                              SizedBox(height: 10.h,),
                                              Text("السعودية - جدة",style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400
                                              ),),
                                              SizedBox(height: 12.h,),
                                              Row(
                                                children: [
                                                  IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                                                  Text("السعودية - جدة",style: TextStyle(
                                                      color: Color(0xff7B217E),
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w400
                                                  ),),

                                                ],
                                              ),
                                              SizedBox(height: 26.h,),
                                              Container(
                                                width: 343.w,
                                                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.purple.shade50,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Detatlies(name: "snapshot.data!.website!",image: "images/earth.svg"),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset("images/twitter.svg"),
                                                        SizedBox(width: 26.w,),
                                                        SvgPicture.asset("images/instegram.svg"),
                                                        SizedBox(width: 26.w,),
                                                        SvgPicture.asset("images/whatsapp.svg"),
                                                        SizedBox(width: 26.w,),
                                                        SvgPicture.asset("images/facebook.svg"),

                                                      ],
                                                    ),
                                                  ],
                                                ),


                                              )






                                            ],
                                          )
                                      );
                                    });


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
                            Positioned(
                              top: 40.0,
                              left: 10.0,
                              right: 10.0,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: ads
                                        .asMap()
                                        .map((i, e) {
                                      return MapEntry(
                                        i,
                                        AnimatedBar(
                                          animController: _animationController,
                                          position: i,
                                          currentIndex: _currentPage,
                                        ),
                                      );
                                    })
                                        .values
                                        .toList(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 1.5,
                                      vertical: 10.0,
                                    ),
                                    //child: UserInfo(ad:ads[i].advertiser!.imageProfile! ,),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h,)
                          ],
                        ),
                      ),
                    ),
                  );
                  }


              ),
            );
          }
          else if (snapshot.hasError) {
            return  Center(
              child: Container(
                decoration:BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("http://boulevard20.com/uploads/ads/Fr6V6d0vIpdUZ5772775611656177082_8192973.jpg")
                  ),

                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 50.h,),
                      Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(width: 10.w,),
                          Text("Nada"),
                          Spacer(),
                          IconButton(onPressed: (){}, icon: Icon(Icons.close))
                        ],
                      ),

                      Spacer(),

                      InkWell(
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
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
                                            }, icon: SvgPicture.asset("images/close.svg"),),

                                          ],
                                        ),
                                        SizedBox(height: 10.h,),
                                        Text("السعودية - جدة",style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                        ),),
                                        SizedBox(height: 12.h,),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                                            Text("السعودية - جدة",style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400
                                            ),),

                                          ],
                                        ),
                                        SizedBox(height: 26.h,),
                                        Container(
                                          width: 343.w,
                                    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                        color: Colors.purple.shade50,
                                        ),
                                          child: Column(
                                            children: [
                                              Detatlies(name: "snapshot.data!.website!",image: "images/earth.svg"),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset("images/twitter.svg"),
                                                  SizedBox(width: 26.w,),
                                                  SvgPicture.asset("images/instegram.svg"),
                                                  SizedBox(width: 26.w,),
                                                  SvgPicture.asset("images/whatsapp.svg"),
                                                  SizedBox(width: 26.w,),
                                                  SvgPicture.asset("images/facebook.svg"),

                                                ],
                                              ),
                                            ],
                                          ),


                                        )






                                      ],
                                    )
                                );
                              });


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

                      SizedBox(height: 24.h,)
                    ],
                  ),
                ),
              ),
            );
          }

          else {
            return Center(

            );
          }
        },
      ),





    );
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

  void _OnTapDown(TapUpDetails  details ,Ads _ads){
    final double screenWidth =MediaQuery.of(context).size.width;
    final dx=details.globalPosition.dx;
    if(dx<screenWidth/3){
      setState(() {
        if (_currentPage - 1 >= 0) {
          _currentPage -= 1;
          _loadStory(ad: ads[_currentPage]);
        }
      });

    }else if (dx>2*screenWidth/3){
      setState(() {
        if(_currentPage+1< ads.length){
          _currentPage+=1;
          _loadStory(ad: ads[_currentPage]);
        }else{
          _currentPage=0;
          _loadStory(ad: ads[_currentPage]);
        }
      });

    }else{

    }

  }


 void  _loadStory({required Ads ad ,bool animateToPage =true}){
    _animationController.stop();
    _animationController.reset();
    if (animateToPage) {
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }

 }
}
class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

   AnimatedBar({

    required this.animController,
    required this.position,
    required this.currentIndex,
  }) ;

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
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                  animation: animController,
                  builder: (context, child) {
                    return _buildContainer(
                      constraints.maxWidth * animController.value,
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

class UserInfo extends StatelessWidget {
  final Ads ad;

   UserInfo({required this.ad,}) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: NetworkImage(ad.advertiser!.imageProfile.toString())
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
          ad.advertiser!.name!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}