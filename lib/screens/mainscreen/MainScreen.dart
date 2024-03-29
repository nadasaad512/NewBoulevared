import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_boulevard/screens/Award/awards_.dart';
import 'package:new_boulevard/screens/homescreen/Home_Screen.dart';
import 'package:new_boulevard/screens/PARTBar/partScreen.dart';
import 'package:new_boulevard/screens/Profile/ProfileWidgt/profileScreen.dart';
import 'package:new_boulevard/screens/allAds/Ads.dart';

class MainScreen extends StatefulWidget {
  int current;

  MainScreen({this.current = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PartScreen(),
    AdsScreen(),
    AwardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.white,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(

              icon: Container(
                padding: EdgeInsets.only(
                  top: 10.h
                ),
                child: SvgPicture.asset(_selectedIndex == 0
                    ? "images/active_home.svg"
                    : "images/Vectorhome.svg"),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(
                    top: 10.h
                ),
                child: SvgPicture.asset(
                    _selectedIndex == 1?
                              "images/active_Part.svg":
                          "images/Vector.svg"),
              ),
              label: "",
            ),

            BottomNavigationBarItem(

              icon: Container(
                padding: EdgeInsets.only(
                    top: 10.h
                ),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors:
                      _selectedIndex == 2?
                      [
                        Color(0xff7B217E),
                        Color(0xff7B217E),
                        Color(0xff18499A),]:[Colors.grey,Colors.grey],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },

                  child: Icon(Icons.slow_motion_video_sharp,size: 35.sp,

                  ),
                ),
              ),
              label: "",
            ),

            BottomNavigationBarItem(
              icon:  Container(
                padding: EdgeInsets.only(
                    top: 10.h
                ),
                child: SvgPicture.asset(
                    _selectedIndex == 3?
                          "images/activAward.svg":
                          "images/Vectorrewiew.svg"


                      ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon:  Container(
                padding: EdgeInsets.only(
                    top: 10.h
                ),
                child: SvgPicture.asset(
                    _selectedIndex == 4?
                    "images/active_person.svg":
                          "images/profile-inactiveperson.svg"


                      ),
              ),
              label: "",
            ),
          ],
          type: BottomNavigationBarType.fixed,


          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.purple,
          iconSize: 25.sp,
          onTap: _onItemTapped,
          elevation: 5),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

// Container(
//           height: 85,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
//
//             boxShadow: [
//               BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10,),
//
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30.0),
//               topRight: Radius.circular(30.0),
//             ),
//
//             child: BottomAppBar(
//
//
//               child:  Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(child: InkWell(
//
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//
//                       onTap: (){
//
//                         _pageController.jumpToPage(0);
//                       },
//                       child: SvgPicture.asset(
//                           widget.current == 0?
//                         "images/active_home.svg":"images/Vectorhome.svg"
//
//
//                       )),),
//                   Expanded(child: InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                     onTap: (){
//                       _pageController.jumpToPage(1);
//                     },
//
//                       child: SvgPicture.asset(
//                           widget.current == 1?
//                               "images/active_Part.svg":
//                           "images/Vector.svg")),),
//                   InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                     onTap: (){
//                       _pageController.jumpToPage(2);
//                     },
//                       child: SvgPicture.asset("images/new.svg",width: 100.w,)),
//
//
//
//                   Expanded(child:InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                     onTap: (){
//                       _pageController.jumpToPage(3);
//                     },
//                       child: SvgPicture.asset(
//                           widget.current == 3?
//                           "images/activAward.svg":
//                           "images/Vectorrewiew.svg"
//
//
//                       )),),
//                   Expanded(child:  InkWell(
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                     onTap: (){
//                       _pageController.jumpToPage(4);
//                     },
//                       child: SvgPicture.asset(
//                           widget.current == 4?
//                           "images/active_person.svg":
//                           "images/profile-inactiveperson.svg"
//
//                       )),),
//                 ],
//               ),
//             ),
//
//           ),
//         ),
//       body:  PageView(
//
//         controller: _pageController,
//         onPageChanged: (int currentPage){
//           setState(() {
//             widget.current=currentPage;
//           });
//         }
//         ,children:
//       [
//         HomeScreen(),
//         PartScreen(),
//         AdsScreen(),
//
//         AwardScreen(),
//         ProfileScreen(),
//
//       ],
//       ),
//);
