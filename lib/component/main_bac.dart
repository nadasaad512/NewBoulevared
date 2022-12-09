import 'dart:io';

import 'package:new_boulevard/component/TextField.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


import '../screens/mainscreen/MainScreen.dart';
import '../api/User_Controller.dart';
import '../models/setting.dart';
import '../models/user.dart';

class Back_Ground extends StatefulWidget{
  final Widget child;
  final String childTab;
  final bool back;
  final bool Bar;
  final bool edit;
  final bool eror;
  final bool EditAdmain;
  final bool ad;
   String? backRout;

   Back_Ground({Key? key, required this.child, required this.childTab, this.back=false, this.Bar=false,this.eror=false, this.edit=false,this.EditAdmain=false,this.backRout,this.ad=false}) : super(key: key);


  @override
  State<Back_Ground> createState() => _Back_GroundState();
}

class _Back_GroundState extends State<Back_Ground> {
  int _current=0;
  bool select =false;

  late PageController _pageController;
  ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedFile;

   final GlobalKey<ScaffoldState> _key = GlobalKey();
   int _selectedIndex = 0;
   TextEditingController NameTextController=TextEditingController();
   TextEditingController emailTextController=TextEditingController();
   TextEditingController phoneTextController=TextEditingController();

   @override
   void initState() {

     super.initState();
     _pageController=PageController();
     NameTextController = TextEditingController();
     emailTextController = TextEditingController();
     phoneTextController = TextEditingController();
   }

   @override
   void dispose() {
     NameTextController.dispose();
     emailTextController.dispose();
     phoneTextController.dispose();
     _pageController.dispose();
     super.dispose();
   }
   bool progss=false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _key,


        drawer:


        Container(
         width: 280.w,
        child:  FutureBuilder<User?>(
          future: UserApiController().getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.purple,));
            } else if (snapshot.hasData)
            {
              return   Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 279.h,
                      child:  DrawerHeader(

                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  begin: AlignmentDirectional.centerStart,
                                  end: AlignmentDirectional.centerEnd,
                                  colors: [
                                    Color(0xff7B217E),
                                    Color(0xff7B217E),
                                    Color(0xff18499A),
                                  ]

                              )
                          ),
                          child: Column(
                            children:
                            [
                              CircleAvatar(
                                radius: 50.sp,

                                backgroundImage: snapshot.data!.imageProfile!=null?

                                NetworkImage(snapshot.data!.imageProfile!):null
                              ) ,
                              SizedBox(height: 22.h,),
                              Text(snapshot.data!.name,style:
                              TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white

                              ),),
                              SizedBox(height: 12.h,),
                              Text(snapshot.data!.followMeCount==null?"0":
                              snapshot.data!.type=="advertiser"?

                              "   ${snapshot.data!.followMeCount.toString()} متابع    ":
                              "   ${snapshot.data!.pointsCount.toString()} نقطة    "


                                ,style:
                              TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white

                              ),),
                            ],
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DraTex(context,titel: "الرئيسية",router:  '/MainScreen'),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "عن التطبيق",router: '/InfoScreen'),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "تواصل معنا",wh: true,),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "مشاركة التطبيق",share: true),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "تقييم التطبيق",reviw: true),
                          SizedBox(height: 20.h,),
                          snapshot.data!.type=="advertiser"?
                          DraTex(context,titel: "سياسات الاعلان",router: '/ConditionScreen'):SizedBox.shrink(),
                          snapshot.data!.type!="advertiser"?
                              SizedBox.shrink():
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "تغيير كلمة المرور",router:'/ChangePassword'),
                          SizedBox(height: 20.h,),
                          snapshot.data!.type=="advertiser"?
                          DraTex(context,titel: "إضافة اعلان",router:'/NewAdsScreen')
                          : DraTex(context,titel: "التسجيل كمعلن",router:'/register_screen'),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "تسجيل الخروج",log: true),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }

            else if (snapshot.hasError) {
              return  Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 279.h,
                      child:  DrawerHeader(

                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  begin: AlignmentDirectional.centerStart,
                                  end: AlignmentDirectional.centerEnd,
                                  colors: [
                                    Color(0xff7B217E),
                                    Color(0xff7B217E),
                                    Color(0xff18499A),
                                  ]

                              )
                          ),
                          child: Column(
                            children:
                            [
                              CircleAvatar(
                                radius: 50.sp,

                              ) ,
                              SizedBox(height: 22.h,),
                              Text('زائر',style:
                              TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white

                              ),),
                              SizedBox(height: 12.h,),
                              Text("  نقطة 0 ",style:
                              TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white

                              ),),
                            ],
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DraTex(context,titel: "الرئيسية",router:  '/MainScreen'),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "عن التطبيق",router: '/InfoScreen'),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "تواصل معنا"),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "مشاركة التطبيق",share: true),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "تقييم التطبيق",reviw: true),
                          SizedBox(height: 20.h,),
                          DraTex(context,titel: "سجل في تطبيقنا ",router:'/register_screen'),
                          SizedBox(height: 20.h,),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 279.h,
                    child:  DrawerHeader(

                        decoration: BoxDecoration(

                            gradient: LinearGradient(
                                begin: AlignmentDirectional.centerStart,
                                end: AlignmentDirectional.centerEnd,
                                colors: [
                                  Color(0xff7B217E),
                                  Color(0xff7B217E),
                                  Color(0xff18499A),
                                ]

                            )
                        ),
                        child: Column(
                          children:
                          [
                            CircleAvatar(
                              radius: 50.sp,
                            ) ,
                            SizedBox(height: 22.h,),
                            Text('زائر',style:
                            TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white

                            ),),
                            SizedBox(height: 12.h,),
                            Text("  نقطة 0 ",style:
                            TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white

                            ),),
                          ],
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DraTex(context,titel: "الرئيسية",router:  '/MainScreen'),
                        SizedBox(height: 20.h,),
                        DraTex(context,titel: "عن التطبيق",router: '/InfoScreen'),
                        SizedBox(height: 20.h,),
                        DraTex(context,titel: "تواصل معنا"),
                        SizedBox(height: 20.h,),
                        DraTex(context,titel: "مشاركة التطبيق",share: true),
                        SizedBox(height: 20.h,),
                        DraTex(context,titel: "تقييم التطبيق",reviw: true),
                        SizedBox(height: 20.h,),
                        DraTex(context,titel: "سجل في تطبيقنا ",router:'/register_screen'),
                        SizedBox(height: 20.h,),

                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),

      ),

        body:  Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
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
              child: Container(
                margin: EdgeInsets.only(
                    bottom:widget.eror?680.h:600.h,
                    left: 10.w,
                   right: 10.w
                ),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      _key.currentState!.openDrawer();
                      }, icon: Icon(Icons.menu,color: Colors.white,)),
                    Spacer(),
                    //SizedBox(width: 80.w,),
                    Text(widget.childTab,style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700
                    ),),
                    Spacer(),
                    //SizedBox(width: 80.w,),
                    widget.ad==true? FutureBuilder<User?>(
                      future: UserApiController().getProfile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center();
                        } else if (snapshot.hasData)
                        {
                          return   snapshot.data!.type=="advertiser"?
                          IconButton(onPressed: (){
                            Navigator.pushNamed(context,'/NewAdsScreen');

                          }, icon: Icon(Icons.add,color: Colors.white,)):
                          Container();

                        }


                        return Center(

                        );
                      },
                    ):Text(""),



                    //Spacer(),

                    widget.back==true? IconButton(onPressed: (){


                      //Navigator.pop(context);
                      //widget.backRout==null?Navigator.pop(context):
                     Navigator.pushNamed(context, '/MainScreen');
                    }, icon: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 20,)):Text(""),
                    widget.edit==true? FutureBuilder<User?>(
                      future: UserApiController().getProfile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center();
                        } else if (snapshot.hasData) {
                          return     IconButton(onPressed: ()
                          {
                            {
                              NameTextController.text=snapshot.data!.name;
                              phoneTextController.text=snapshot.data!.mobile;
                              emailTextController.text=snapshot.data!.email;

                            widget.EditAdmain==false?
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: 30.w,),

                                                Text("تعديل الملف الشخصي",style: TextStyle(
                                                    color: Color(0xff7B217E),
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600
                                                ),),

                                                IconButton(onPressed: (){
                                                  Navigator.pop(context);
                                                  select? Navigator.pop(context):null;
                                                }, icon: SvgPicture.asset("images/close.svg"),),

                                              ],
                                            ),



                                            InkWell(
                                              onTap: ()async{
                                                _pickedFile = await _imagePicker.getImage(source: ImageSource.gallery,);
                                                 if(_pickedFile!=null){
                                                   setState(() {});
                                                 }



                                              },
                                              child: Center(
                                                child: Container(
                                                  height: 132.h,
                                                  width: 132.w,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      shape: BoxShape.circle ,
                                                      image:  _pickedFile != null ?

                                                      DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: FileImage(
                                                            File(_pickedFile!.path),


                                                          )
                                                      ):
                                                      DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(snapshot.data!.imageProfile.toString())
                                                      )

                                                    //:null

                                                  ),
                                                  child:Align(
                                                      alignment: Alignment.bottomRight,

                                                      child:CircleAvatar(
                                                        backgroundColor: Color(0xff7B217E),
                                                        radius: 16.sp,
                                                        child: Icon(Icons.add,size: 16.sp,color: Colors.white,),
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 22.h,),
                                            FieldScreen(title: snapshot.data!.name,controller: NameTextController,),
                                            SizedBox(height: 16.h,),
                                            FieldScreen(title: snapshot.data!.mobile,controller: phoneTextController,),
                                            SizedBox(height: 16.h,),
                                            FieldScreen(title: snapshot.data!.email,controller: emailTextController,),
                                            SizedBox(height: 28.h,),
                                            ElevatedButton  (
                                              onPressed: () async {
                                                setState(() {
                                                  progss=true;
                                                });
                                                await Edit(

                                               image: _pickedFile!=null?
                                               _pickedFile!.path:
                                                   null



                                                );
                                                setState(() {});

                                              },
                                              child: progss?CircularProgressIndicator(color: Colors.white,):


                                              Text('تعديل الملف الشخصي',style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.sp
                                              ),),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(0xff7B217E),

                                                minimumSize: Size(double.infinity, 50.h),
                                              ),
                                            ),
                                            SizedBox(height: 300.h,),
                                          ],
                                        )
                                    );
                                  });


                                },
                              ):  Navigator.pushReplacementNamed(context, '/EditAdmainScreen');
                            }
                          }, icon: SvgPicture.asset("images/edit.svg"),);
                        } else if (snapshot.hasError) {
                          return Text('');
                        }
                        return Center(

                        );
                      },
                    ):Text(""),








                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(
                  top: 90.h
              ),
              decoration: BoxDecoration(
                color: Color(0xffFFF4FF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: widget.child



            ),

          ],
        )
    );

  }




   Future Edit({ String? image}) async {

      await UserApiController().EditProfile(context,
         Name: NameTextController.text,
         mobile: phoneTextController.text,
         email: emailTextController.text,
       img: image,
         uploadEvent: (status,massege){
           if(status){

             setState(() {});
             Navigator.pushReplacementNamed(context, '/MainScreen');

             NameTextController.clear();
             phoneTextController.clear();
             emailTextController.clear();
             setState(() {
               progss=false;
             });


           }else{

             setState(() {
               progss=false;
             });

           }

         }
     );




   }
  Widget DraTex(BuildContext context,{
    required String titel,String? router,bool log=false,bool share=false,bool wh=false,bool reviw=false}){
    return InkWell(
      hoverColor: Colors.purple.shade50,
      focusColor:Colors.purple.shade50 ,
      highlightColor: Colors.purple.shade50,
      splashColor: Colors.purple.shade50,
      onTap: ()async{
        Settings settings=await UserApiController().Setting();
        //url





       share? Share.share('check out my website ${settings.url}'):null;
       wh? await launch("whatsapp://send?phone=${settings.whatsapp}&text=${"Hi"}"):null;
       reviw? await launch(settings.url.toString()):null;


        log? await logout():null;
        router!=null? Navigator.pushNamed(context, router):null;
      },
      child: Text(titel,style: TextStyle(
          color: Color(0xff7B217E),
      fontSize: 16.sp,
      fontWeight: FontWeight.w600

      )),
    );
  }
   Future logout() async {
     bool loggedOut = await UserApiController().logout(context);
     if (loggedOut) Navigator.pushReplacementNamed(context, '/logain_screen');
   }


}