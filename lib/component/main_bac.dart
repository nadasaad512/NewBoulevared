import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:new_boulevard/component/TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Shared_Preferences/User_Preferences.dart';
import '../api/User_Controller.dart';
import '../loed/loed.dart';
import '../models/setting.dart';
import '../models/user.dart';
import '../provider/app_provider.dart';
import '../screens/homescreen/widget/ImageRotater.dart';

class Back_Ground extends StatefulWidget {
  final Widget child;
  final String childTab;
  final bool back;
  final bool ispart;
  final bool Bar;
  final bool edit;
  final bool eror;
  final bool home;
  final bool EditAdmain;
  final bool ad;
  String? backRout;

  Back_Ground(
      {Key? key,
      required this.child,
      required this.childTab,
      this.back = false,
      this.ispart = false,
      this.Bar = false,
      this.eror = false,
      this.edit = false,
      this.home = false,
      this.EditAdmain = false,
      this.backRout,
      this.ad = false})
      : super(key: key);

  @override
  State<Back_Ground> createState() => _Back_GroundState();
}

class _Back_GroundState extends State<Back_Ground> {
  bool select = false;

  late PageController _pageController;
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedFile;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController NameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getProfile();
    _pageController = PageController();
    NameTextController = TextEditingController();
    emailTextController = TextEditingController();
    phoneTextController = TextEditingController();
  }


  final ScrollController scrollController = ScrollController();
  bool progss = false;

  @override
  Widget build(BuildContext context) {
    return  Consumer<AppProvider>(builder: (context, provider, _) {
     return  Scaffold(
         backgroundColor: Colors.white,
         resizeToAvoidBottomInset: true,
         key: _key,
         drawer: SizedBox(
           width: 280.w,
           child:   provider.user==null?
           Drawer(
             child: ListView(
               padding: EdgeInsets.zero,
               children: [
                 SizedBox(
                   height: 279.h,
                   child: DrawerHeader(
                       decoration: const BoxDecoration(
                           gradient: LinearGradient(
                               begin: AlignmentDirectional.centerStart,
                               end: AlignmentDirectional.centerEnd,
                               colors: [
                                 Color(0xff7B217E),
                                 Color(0xff7B217E),
                                 Color(0xff18499A),
                               ])),
                       child: Column(
                         children: [
                           CircleAvatar(
                             radius: 50.sp,
                           ),
                           SizedBox(
                             height: 22.h,
                           ),
                           Text(
                             'زائر',
                             style: TextStyle(
                                 fontSize: 16.sp,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white),
                           ),
                           SizedBox(
                             height: 12.h,
                           ),

                         ],
                       )),
                 ),
                 Container(
                   margin: EdgeInsets.symmetric(horizontal: 16.w),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       DraTex(context,
                           titel: "الرئيسية", router: '/MainScreen'),
                       SizedBox(
                         height: 20.h,
                       ),
                       DraTex(context,
                           titel: "عن التطبيق", router: '/InfoScreen'),
                       SizedBox(
                         height: 20.h,
                       ),
                       DraTex(context, titel: "تواصل معنا",contact: true),
                       SizedBox(
                         height: 20.h,
                       ),
                       DraTex(context,
                           titel: "مشاركة التطبيق", share: true),
                       SizedBox(
                         height: 20.h,
                       ),
                       DraTex(context,
                           titel: "تقييم التطبيق", reviw: true),
                       SizedBox(
                         height: 20.h,
                       ),
                       DraTex(context,
                           titel: "سجل في تطبيقنا ",
                           router: '/register_screen'),
                       SizedBox(
                         height: 20.h,
                       ),
                     ],
                   ),
                 )
               ],
             ),
           ):
           Drawer(
             child: ListView(
               padding: EdgeInsets.zero,
               children: [
                 SizedBox(
                   height: 279.h,
                   child: DrawerHeader(
                       decoration: const BoxDecoration(
                           gradient: LinearGradient(
                               begin: AlignmentDirectional.centerStart,
                               end: AlignmentDirectional.centerEnd,
                               colors: [
                                 Color(0xff7B217E),
                                 Color(0xff7B217E),
                                 Color(0xff18499A),
                               ])),
                       child: Column(
                         children: [
                           CircleAvatar(
                               radius: 50.sp,
                               backgroundImage:
                               provider.user!.imageProfile != null
                                   ? NetworkImage(
                                   provider.user!.imageProfile!)
                                   : null),
                           SizedBox(
                             height: 22.h,
                           ),
                           Text(
                             provider.user!.name,
                             style: TextStyle(
                                 fontSize: 16.sp,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white),
                           ),
                           SizedBox(
                             height: 12.h,
                           ),
                           Text(
                             provider.user!.followMeCount == null
                                 ? "0"
                                 : provider.user!.type == "advertiser"
                                 ? "   ${provider.user!.followMeCount.toString()} متابع    "
                                 : "   ${provider.user!.pointsCount.toString()} نقطة    ",
                             style: TextStyle(
                                 fontSize: 16.sp,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white),
                           ),
                         ],
                       )),
                 ),
                 Container(
                   margin: EdgeInsets.symmetric(horizontal: 16.w),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       DraTex(context, titel: "الرئيسية",router: '/MainScreen'),
                       SizedBox(
                         height: 15.h,
                       ),
                       DraTex(context, titel: "عن التطبيق",router: '/InfoScreen'),
                       SizedBox(
                         height: 15.h,
                       ),
                       DraTex(
                           context,
                           titel: "تواصل معنا",
                           contact: true
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                       DraTex(context, titel: "مشاركة التطبيق", share: true),
                       SizedBox(
                         height: 15.h,
                       ),
                       DraTex(context, titel: "تقييم التطبيق", reviw: true),
                       SizedBox(
                         height: 15.h,
                       ),
                       provider.user!.type == "advertiser"
                           ? DraTex(context,
                           titel: "سياسات الاعلان",
                           router: '/ConditionScreen'
                       )
                           : const SizedBox.shrink(),
                       provider.user!.type != "advertiser"
                           ? const SizedBox.shrink()
                           : SizedBox(
                         height: 15.h,
                       ),
                       DraTex(context,
                           titel: "تغيير كلمة المرور",
                           router: '/ChangePassword'
                       ),
                       SizedBox(
                         height: 15.h,
                       ),
                       provider.user!.type == "advertiser"
                           ? DraTex(context, titel: "إضافة اعلان",router: '/NewAdsScreen')
                           : InkWell(

                           child: DraTex(context, titel: "التسجيل كمعلن", router: '/register_screen')),
                       SizedBox(
                         height: 15.h,
                       ),
                       provider.user!.type == "advertiser"|| provider.user!.type =="user"
                           ? DeleTAccount()
                           : const SizedBox.shrink(),
                       SizedBox(
                         height: 15.h,
                       ),
                       DraTex(context, titel: "تسجيل الخروج",log: true),
                     ],
                   ),
                 )
               ],
             ),
           ),
         ),
         body: Stack(
           children: [
             Container(
               width: double.infinity,
               height: double.infinity,
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                   begin: AlignmentDirectional.centerStart,
                   end: AlignmentDirectional.centerEnd,
                   colors: [
                     Color(0xff7B217E),
                     Color(0xff7B217E),
                     Color(0xff18499A),
                   ],
                 ),
               ),
               child:
               widget.home==true?
                   SizedBox.shrink():
               Container(
                 margin: EdgeInsets.only(
                     bottom: widget.eror ? 680.h : 600.h,
                     left: 10.w,
                     right: 10.w),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(
                         onPressed: () {
                           _key.currentState!.openDrawer();
                         },
                         icon: const Icon(
                           Icons.menu,
                           color: Colors.white,
                         )),
                     SizedBox(width: 80.w,),
                     Text(
                       widget.childTab,
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 16.sp,
                           fontWeight: FontWeight.w700),
                     ),
                     const Spacer(),

                     widget.ad == true
                         ?
                     provider.user!=null?
                     provider.user!.type == "advertiser"
                         ? IconButton(
                         onPressed: () {
                           Navigator.pushNamed(
                               context, '/NewAdsScreen');
                         },
                         icon: const Icon(
                           Icons.add,
                           color: Colors.white,
                         ))
                         :SizedBox.shrink()
                         : SizedBox.shrink():
                     SizedBox.shrink(),


                     widget.back == true
                         ? IconButton(
                         onPressed: () {
                           widget.ispart?
                          Navigator.pushNamed(context, '/PartScreen'):
                          Navigator.pushNamed(context, '/MainScreen');
                         },
                         icon: const Icon(
                           Icons.arrow_forward_ios_rounded,
                           color: Colors.white,
                           size: 20,
                         ))
                         : const Text(""),
                     widget.edit == true
                         ? IconButton(
                       onPressed: () {
                         {
                           NameTextController.text =
                              provider.user!.name;
                           phoneTextController.text =
                               provider.user!.mobile;
                           emailTextController.text =
                               provider.user!.email;

                           widget.EditAdmain == false
                               ? showModalBottomSheet(
                             context: context,
                             shape:
                             const RoundedRectangleBorder(
                               // <-- SEE HERE
                                 borderRadius:
                                 BorderRadius.only(
                                   topRight: Radius.circular(15),
                                   topLeft: Radius.circular(15),
                                 )),
                             builder: (context) {
                               return StatefulBuilder(builder:
                                   (BuildContext context,
                                   StateSetter setState) {
                                 return Container(
                                     margin:
                                     EdgeInsets.symmetric(
                                         horizontal: 16.w,
                                         vertical: 16.h),
                                     decoration:
                                     const BoxDecoration(
                                         borderRadius:
                                         BorderRadius
                                             .only(
                                           topRight:
                                           Radius.circular(15),
                                           topLeft:
                                           Radius.circular(15),
                                         )),
                                     height: 520.h,
                                     width: double.infinity,
                                     alignment:
                                     Alignment.center,
                                     child: ListView(
                                       children: [
                                         Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment
                                               .spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: 30.w,
                                             ),
                                             Text(
                                               "تعديل الملف الشخصي",
                                               style: TextStyle(
                                                   color: const Color(
                                                       0xff7B217E),
                                                   fontSize:
                                                   18.sp,
                                                   fontWeight:
                                                   FontWeight
                                                       .w600),
                                             ),
                                             IconButton(
                                               onPressed: () {
                                                 Navigator.pop(
                                                     context);
                                                 select
                                                     ? Navigator
                                                     .pop(
                                                     context)
                                                     : null;
                                               },
                                               icon: SvgPicture
                                                   .asset(
                                                   "images/close.svg"),
                                             ),
                                           ],
                                         ),
                                         InkWell(
                                           onTap: () async {
                                             _pickedFile =
                                             await _imagePicker
                                                 .getImage(
                                               source:
                                               ImageSource
                                                   .gallery,
                                             );
                                             if (_pickedFile !=
                                                 null) {
                                               setState(() {});
                                             }
                                           },
                                           child: Center(
                                             child: Container(
                                               height: 132.h,
                                               width: 132.w,
                                               decoration: BoxDecoration(
                                                   color:Color(0xff7B217E),
                                                   shape: BoxShape.circle,
                                                   image: _pickedFile != null
                                                       ? DecorationImage(
                                                       fit: BoxFit.cover,
                                                       image: FileImage(
                                                         File(_pickedFile!.path),
                                                       ))
                                                       : DecorationImage(fit: BoxFit.cover, image: NetworkImage(provider.user!.imageProfile.toString()))

                                                 //:null

                                               ),
                                               child: Align(
                                                   alignment:
                                                   Alignment
                                                       .bottomRight,
                                                   child:
                                                   CircleAvatar(
                                                     backgroundColor:
                                                     const Color(
                                                         0xff7B217E),
                                                     radius:
                                                     16.sp,
                                                     child:
                                                     Icon(
                                                       Icons
                                                           .add,
                                                       size: 16
                                                           .sp,
                                                       color: Colors
                                                           .white,
                                                     ),
                                                   )),
                                             ),
                                           ),
                                         ),
                                         SizedBox(
                                           height: 22.h,
                                         ),
                                         FieldScreen(
                                           title: provider.user!.name,
                                           controller:
                                           NameTextController,
                                         ),
                                         SizedBox(
                                           height: 16.h,
                                         ),
                                         FieldScreen(
                                           title: provider.user!.mobile,
                                           controller:
                                           phoneTextController,
                                         ),
                                         SizedBox(
                                           height: 16.h,
                                         ),
                                         FieldScreen(
                                           title:provider.user!.email,
                                           controller:
                                           emailTextController,
                                         ),
                                         SizedBox(
                                           height: 28.h,
                                         ),
                                         ElevatedButton(
                                           onPressed:
                                               () async {
                                             setState(() {
                                               progss = true;
                                             });
                                             await Edit(
                                                 image: _pickedFile !=
                                                     null
                                                     ? _pickedFile!
                                                     .path
                                                     : null);
                                             setState(() {});
                                           },
                                           style:
                                           ElevatedButton
                                               .styleFrom(
                                             backgroundColor:
                                             const Color(
                                                 0xff7B217E),
                                             minimumSize: Size(
                                                 double
                                                     .infinity,
                                                 50.h),
                                           ),
                                           child: progss
                                               ? const CircularProgressIndicator(
                                             color: Colors
                                                 .white,
                                           )
                                               : Text(
                                             'تعديل الملف الشخصي',
                                             style: TextStyle(
                                               color: Colors.white,
                                                 fontWeight:
                                                 FontWeight
                                                     .w700,
                                                 fontSize:
                                                 18.sp),
                                           ),
                                         ),
                                         SizedBox(
                                           height: 300.h,
                                         ),
                                       ],
                                     ));
                               });
                             },
                           )
                               : Navigator.pushReplacementNamed(
                               context, '/EditAdmainScreen');
                         }
                       },
                       icon: SvgPicture.asset("images/edit.svg"),
                     )
                         : const Text(""),
                   ],
                 ),
               ),
             ),

            widget.home==true?
             provider.banners.isNotEmpty
                 ? SizedBox(
                     height: 300.h,
                     child: CasualImageSlider(
                         scrollController: scrollController,
                         imageUrls: provider.banners))
                 : SizedBox.shrink():
                   SizedBox.shrink(),
             widget. home==true?
             Container(
               margin: EdgeInsets.only(
                   bottom: widget.eror ? 680.h : 600.h,
                   left: 10.w,
                   right: 10.w,
                 top: 35
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   IconButton(
                       onPressed: () {
                         _key.currentState!.openDrawer();
                       },
                       icon: const Icon(
                         Icons.menu,
                         color: Colors.white,
                         size: 30,
                       )),
                   SizedBox(width: 80.w,),
                   Text(
                     widget.childTab,
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w700),
                   ),
                   const Spacer(),

                   widget.ad == true
                       ?
                   provider.user!=null?
                   provider.user!.type == "advertiser"
                       ? IconButton(
                       onPressed: () {
                         Navigator.pushNamed(
                             context, '/NewAdsScreen');
                       },
                       icon: const Icon(
                         Icons.add,
                         color: Colors.white,
                       ))
                       :SizedBox.shrink()
                       : SizedBox.shrink():
                   SizedBox.shrink(),



                   widget.back == true
                       ? IconButton(
                       onPressed: () {

                         Navigator.pushNamed(context, '/MainScreen');
                       },
                       icon: const Icon(
                         Icons.arrow_forward_ios_rounded,
                         color: Colors.white,
                         size: 20,
                       ))
                       : const Text(""),
                   widget.edit == true
                       ? IconButton(
                     onPressed: () {
                       {
                         NameTextController.text =
                             provider.user!.name;
                         phoneTextController.text =
                             provider.user!.mobile;
                         emailTextController.text =
                             provider.user!.email;

                         widget.EditAdmain == false
                             ? showModalBottomSheet(
                           context: context,
                           shape:
                           const RoundedRectangleBorder(
                             // <-- SEE HERE
                               borderRadius:
                               BorderRadius.only(
                                 topRight: Radius.circular(15),
                                 topLeft: Radius.circular(15),
                               )),
                           builder: (context) {
                             return StatefulBuilder(builder:
                                 (BuildContext context,
                                 StateSetter setState) {
                               return Container(
                                   margin:
                                   EdgeInsets.symmetric(
                                       horizontal: 16.w,
                                       vertical: 16.h),
                                   decoration:
                                   const BoxDecoration(
                                       borderRadius:
                                       BorderRadius
                                           .only(
                                         topRight:
                                         Radius.circular(15),
                                         topLeft:
                                         Radius.circular(15),
                                       )),
                                   height: 520.h,
                                   width: double.infinity,
                                   alignment:
                                   Alignment.center,
                                   child: ListView(
                                     children: [
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment
                                             .spaceBetween,
                                         children: [
                                           SizedBox(
                                             width: 30.w,
                                           ),
                                           Text(
                                             "تعديل الملف الشخصي",
                                             style: TextStyle(
                                                 color: const Color(
                                                     0xff7B217E),
                                                 fontSize:
                                                 18.sp,
                                                 fontWeight:
                                                 FontWeight
                                                     .w600),
                                           ),
                                           IconButton(
                                             onPressed: () {
                                               Navigator.pop(
                                                   context);
                                               select
                                                   ? Navigator
                                                   .pop(
                                                   context)
                                                   : null;
                                             },
                                             icon: SvgPicture
                                                 .asset(
                                                 "images/close.svg"),
                                           ),
                                         ],
                                       ),
                                       InkWell(
                                         onTap: () async {
                                           _pickedFile =
                                           await _imagePicker
                                               .getImage(
                                             source:
                                             ImageSource
                                                 .gallery,
                                           );
                                           if (_pickedFile !=
                                               null) {
                                             setState(() {});
                                           }
                                         },
                                         child: Center(
                                           child: Container(
                                             height: 132.h,
                                             width: 132.w,
                                             decoration: BoxDecoration(
                                                 color:Color(0xff7B217E),
                                                 shape: BoxShape.circle,
                                                 image: _pickedFile != null
                                                     ? DecorationImage(
                                                     fit: BoxFit.cover,
                                                     image: FileImage(
                                                       File(_pickedFile!.path),
                                                     ))
                                                     : DecorationImage(fit: BoxFit.cover, image: NetworkImage(provider.user!.imageProfile.toString()))

                                               //:null

                                             ),
                                             child: Align(
                                                 alignment:
                                                 Alignment
                                                     .bottomRight,
                                                 child:
                                                 CircleAvatar(
                                                   backgroundColor:
                                                   const Color(
                                                       0xff7B217E),
                                                   radius:
                                                   16.sp,
                                                   child:
                                                   Icon(
                                                     Icons
                                                         .add,
                                                     size: 16
                                                         .sp,
                                                     color: Colors
                                                         .white,
                                                   ),
                                                 )),
                                           ),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 22.h,
                                       ),
                                       FieldScreen(
                                         title: provider.user!.name,
                                         controller:
                                         NameTextController,
                                       ),
                                       SizedBox(
                                         height: 16.h,
                                       ),
                                       FieldScreen(
                                         title: provider.user!.mobile,
                                         controller:
                                         phoneTextController,
                                       ),
                                       SizedBox(
                                         height: 16.h,
                                       ),
                                       FieldScreen(
                                         title:provider.user!.email,
                                         controller:
                                         emailTextController,
                                       ),
                                       SizedBox(
                                         height: 28.h,
                                       ),
                                       ElevatedButton(
                                         onPressed:
                                             () async {
                                           setState(() {
                                             progss = true;
                                           });
                                           await Edit(
                                               image: _pickedFile !=
                                                   null
                                                   ? _pickedFile!
                                                   .path
                                                   : null);
                                           setState(() {});
                                         },
                                         style:
                                         ElevatedButton
                                             .styleFrom(
                                           backgroundColor:
                                           const Color(
                                               0xff7B217E),
                                           minimumSize: Size(
                                               double
                                                   .infinity,
                                               50.h),
                                         ),
                                         child: progss
                                             ? const CircularProgressIndicator(
                                           color: Colors
                                               .white,
                                         )
                                             : Text(
                                           'تعديل الملف الشخصي',
                                           style: TextStyle(
                                               fontWeight:
                                               FontWeight
                                                   .w700,
                                               fontSize:
                                               18.sp),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 300.h,
                                       ),
                                     ],
                                   ));
                             });
                           },
                         )
                             : Navigator.pushReplacementNamed(
                             context, '/EditAdmainScreen');
                       }
                     },
                     icon: SvgPicture.asset("images/edit.svg"),
                   )
                       : const Text(""),
                 ],
               ),
             ):SizedBox.shrink(),
             Container(
                 width: double.infinity,
                 height: double.infinity,
                 margin:
                 widget.home==true? EdgeInsets.only(top: 300.h):
                EdgeInsets.only(top: 90.h),
                 decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(
                     topRight: Radius.circular(5),
                     topLeft: Radius.circular(5),
                   ),
                 ),
                 child: widget.child),
           ],
         ));
    });
  }

  Future Edit({String? image}) async {
    await UserApiController().EditProfile(context,
        Name: NameTextController.text,
        mobile: phoneTextController.text,
        email: emailTextController.text,
        img: image, uploadEvent: (status, massege) {
      if (status) {
        setState(() {});
        Navigator.pushReplacementNamed(context, '/MainScreen');

        NameTextController.clear();
        phoneTextController.clear();
        emailTextController.clear();
        setState(() {
          progss = false;
        });
      } else {
        setState(() {
          progss = false;
        });
      }
    });
  }

  Widget DraTex(BuildContext context,
      {required String titel,
      bool share = false,
      bool contact = false,
      bool log = false,
        String? router,
      bool reviw = false}) {
    return InkWell(
      hoverColor: Colors.purple.shade50,
      focusColor: Colors.purple.shade50,
      highlightColor: Colors.purple.shade50,
      splashColor: Colors.purple.shade50,
      onTap: () async {
        final box = context.findRenderObject() as RenderBox?;
        Settings settings =
            router != null||log==true?
            Settings():
        await UserApiController().Setting();

        if (share && defaultTargetPlatform == TargetPlatform.iOS && MediaQuery.of(context).size.height > 700) {
          await Share.share(
            settings.url.toString(),
            subject: "check out my website",
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          );
        }else if(share){
          await Share.share('check out my website ${settings.url}');
        }
          log? await logout():null;

        if(reviw){
          Platform.isIOS?
          await launch(settings.instagram.toString()):
          await launch(settings.linked_in.toString());
        }
        print(settings.whatsapp);
        contact? _launchWhatsapp( number: settings.whatsapp):null;




        router != null ? Navigator.pushNamed(context, router) : null;
      },
      child: Text(titel,
          style: TextStyle(
              color: const Color(0xff7B217E),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget DeleTAccount() {
    bool isdelet=false;
    return InkWell(
      hoverColor: Colors.purple.shade50,
      focusColor: Colors.purple.shade50,
      highlightColor: Colors.purple.shade50,
      splashColor: Colors.purple.shade50,
      onTap: () async {
        setState(() {
          isdelet=true;
        });

       await UserApiController().DeletAccount(context);
        setState(() {
          isdelet=false;
        });
      },
      child:
      isdelet==true?
          CircularProgressIndicator(color: Colors.white,):
      Text("حذف الحساب ",
          style: TextStyle(
              color: const Color(0xff7B217E),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600)),
    );
  }

  Future logout() async {

    bool loggedOut = await UserApiController().logout(context);
    if (loggedOut) {
      Navigator.pushReplacementNamed(context, '/logain_screen');
      await  UserPreferences().logout();
    }
  }
}

_launchWhatsapp({number}) async {
  final url = "whatsapp://send?phone=$number";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
