import 'dart:io';

import 'package:new_boulevard/api/User_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../component/TextField.dart';
import '../../../component/main_bac.dart';
import '../../../loed/loed.dart';
import '../../../models/activity.dart';
import '../../../models/city.dart';
import '../../../models/user.dart';



class EditAdmainScreen extends StatefulWidget{
  @override
  State<EditAdmainScreen> createState() => _EditAdmainScreenState();
}

class _EditAdmainScreenState extends State<EditAdmainScreen> {
  TextEditingController NameTextController=TextEditingController();
  TextEditingController emailTextController=TextEditingController();
  TextEditingController phoneTextController=TextEditingController();
  TextEditingController commercialActivities=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController domain=TextEditingController();
  TextEditingController face=TextEditingController();
  TextEditingController twita=TextEditingController();
  TextEditingController whatsup=TextEditingController();
  TextEditingController insta=TextEditingController();
  var _selected;
  ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedFile;
  String ? id;
  List<Cities> cit = [];
  var _selected1;
  String ? idActive;
  List<Activity> ActiveList = [];
  bool loed=true;
  int? idcity;
  int? idActiv;

  @override
  void initState() {
    super.initState();
    NameTextController = TextEditingController();
    emailTextController = TextEditingController();
    phoneTextController = TextEditingController();
    commercialActivities = TextEditingController();
    city = TextEditingController();
    domain = TextEditingController();
    face = TextEditingController();
    twita = TextEditingController();
    whatsup = TextEditingController();
    insta = TextEditingController();
    UserApiController().Commercial_Activities().then((value) {
      setState(() {
        ActiveList=value;
      });
    });
    UserApiController().getCity().then((value) {
      setState(() {
        cit=value;
      });
    });
    UserApiController().getProfile().then((value) {
      setState(() {
        user=value!;
        NameTextController.text=user.name;
        phoneTextController.text=user.mobile;
        emailTextController.text=user.email;
        city.text=user.city!.name!.toString();
        commercialActivities.text=user.commercialActivity!.name.toString();
        idActiv=user.commercialActivity!.id;
        idcity=user.city!.id;
        face.text=user.facebook.toString()=="null"?"":user.facebook.toString();
        insta.text=user.instagram.toString()=="null"?"":user.instagram.toString();
        whatsup.text=user.whatsapp.toString();
        twita.text=user.twitter.toString()=="null"?"":user.twitter.toString();
        domain.text=user.website.toString()=="null"?"":user.website.toString();
        loed=false;
      });
    });

  }
  bool progss=false;

  User user =User();
  @override
  Widget build(BuildContext context) {
    return
    loed?
      LoedWidget():
    Back_Ground(
        back: true,
        Bar: true,
        eror: true,

        childTab: "تعديل الملف الشخصي",
        child: Container(

            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            decoration: BoxDecoration(
                color: Colors.white,

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
                InkWell(
                  onTap: ()async{
                    await pickImage();
                  },
                  child: Center(
                    child: Container(
                      height: 132.h,
                      width: 132.w,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle ,
                          image: _pickedFile != null?
                          DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(_pickedFile!.path),


                              )
                          ): user.imageProfile==null?
                          null:
                          DecorationImage(
                            fit: BoxFit.cover,
                            image:  NetworkImage(user.imageProfile!),


                          )



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
                Text("المعلومات",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7B217E)
                ),),
                SizedBox(height: 24.h,),
                FieldScreen(title: "الاسم التجاري",controller: NameTextController,),
                SizedBox(height: 16.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 50.h,
                  width: 330.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.grey.shade400,
                      )
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    menuMaxHeight: 500.h,

                    hint: Text(commercialActivities.text.isEmpty?"النشاط التجاري ":commercialActivities.text, style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),),

                    iconEnabledColor: Colors.white,

                    value: _selected1,
                    icon: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade500, size: 18,),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.black, fontSize: 16.sp,
                        fontWeight: FontWeight.w400
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selected1 = newValue;
                      });
                    },
                    items: ActiveList.map<
                        DropdownMenuItem<String>>((Activity value) {
                      return DropdownMenuItem<String>(

                        onTap: () {
                          setState(() {
                            idActive = value.id.toString();
                          });
                        },
                        value: value.name,
                        child: Text(value.name!),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.h,),
                Directionality(
                  textDirection: TextDirection.ltr,
                    child: FieldScreen(title: "الهاتف",controller: phoneTextController,type: TextInputType.phone)),
                SizedBox(height: 16.h,),
                FieldScreen(title: "الايميل",controller: emailTextController,),
                SizedBox(height: 16.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 50.h,
                  width: 343.w,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,



                      border: Border.all(
                          color: Color(0xffC4C4C4)
                      )
                  ),

                  child: DropdownButton(


                    isExpanded: true,
                    underline: Container(),
                    menuMaxHeight: 500.h,

                    hint: Text(city.text.isEmpty?"المدينة":city.text,style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xffC4C4C4),

                        fontWeight: FontWeight.w400
                    ),),

                    iconEnabledColor:Colors.white ,

                    value: _selected,
                    icon: Icon(Icons.arrow_forward_ios_rounded,color: Color(0xffC4C4C4),size: 18,),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(color: Colors.black,  fontSize: 16.sp,
                        fontWeight: FontWeight.w400
                    ),
                    onChanged: (newValue) {


                      setState(() {
                        _selected=newValue;

                      });

                    },
                    items: cit.map<DropdownMenuItem<String>>((Cities value) {

                      return DropdownMenuItem<String>(

                        onTap: (){
                          setState(() {
                            id=value.id.toString();
                          });

                        },
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 16.h,),
                Text("مواقع التواصل",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7B217E)
                ),),
                SizedBox(height: 16.h,),
                FieldScreen(title: "الفيس بوك",controller: face,isicon: true,icon:"images/facebook.svg" ,),
                SizedBox(height: 16.h,),
                FieldScreen(title: "الانستجرام",controller: insta,isicon: true,icon:"images/instegram.svg"),
                SizedBox(height: 16.h,),
                FieldScreen(title: "تويتر",controller: twita,isicon: true,icon:"images/twitter.svg"),

                SizedBox(height: 28.h,),
                ElevatedButton  (
                  onPressed: () async {
                    setState(() {
                      progss=true;
                    });

                    await Edit_Admain();


                  },
                  child: progss?CircularProgressIndicator(color: Colors.white,):


                  Text('تعديل الملف الشخصي',style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    color: Colors.white
                  ),),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff7B217E),

                    minimumSize: Size(double.infinity, 50.h),
                  ),
                ),
                SizedBox(height: 300.h,),
              ],
            )
        )
    );


  }



  Future pickImage() async {

    _pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {});

    }
  }

  Future Edit_Admain() async {
 await UserApiController().EditAdmain(
        context,
        Name: NameTextController.text,
        mobile: phoneTextController.text,
        email: emailTextController.text,
         commercialActivities: idActive==null?idActiv.toString():idActive.toString(),
        city_id:id==null?idcity.toString(): id.toString(),
      facebook: face.text,
      instagram: insta.text,
      twitter: twita.text,
      whatsapp: whatsup.text,
        domain:domain.text,
       img:  _pickedFile!=null?
        _pickedFile!.path:
        null, uploadEvent: (status,massege){
          if(status){
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

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.6,
        color: Colors.grey.shade500,
      ),
    );
  }
}