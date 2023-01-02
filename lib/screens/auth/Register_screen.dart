import 'dart:io';
import 'package:new_boulevard/models/activity.dart';
import 'package:new_boulevard/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_boulevard/utils/helpers.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/background.dart';
import '../../models/city.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers{
  bool progss = false;
  bool Aprogss = false;
  String gender = "user";



  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> AregisterFormKey = GlobalKey<FormState>();

  TextEditingController ANameTextController = TextEditingController();
  TextEditingController AemailTextController = TextEditingController();
  TextEditingController ApasswordTextController = TextEditingController();
  TextEditingController ASurepasswordTextController = TextEditingController();
  TextEditingController AphoneTextController = TextEditingController();


  TextEditingController NameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController SurepasswordTextController = TextEditingController();

  var _selected;
  String ? id;
  List<Cities> cit = [];
  var _selected1;
  String ? idActive;
  List<Activity> ActiveList = [];
  bool check = false;

  @override
  void initState() {
    super.initState();
    ANameTextController = TextEditingController();
    AemailTextController = TextEditingController();
    ApasswordTextController = TextEditingController();
    ASurepasswordTextController = TextEditingController();
    AphoneTextController = TextEditingController();


    NameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    phoneTextController = TextEditingController();
    SurepasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    ANameTextController.dispose();
    AemailTextController.dispose();
    ApasswordTextController.dispose();
    ASurepasswordTextController.dispose();
    AphoneTextController.dispose();


    NameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    phoneTextController.dispose();
    SurepasswordTextController.dispose();
    super.dispose();
  }

  ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return BackGround(
      back: true,
      rout: '/logain_screen',
      child: Container(
          margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 50.h
          ),
          child: ListView(

            children: [
              Center(
                child: Text("تسجيل جديد", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),),
              ),
              SizedBox(height: 30.h,),
              Row(

                children: [


                  Text("نوع المستخدم  :", style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp
                  ),),
                  SizedBox(width: 5.w,),

                  Radio(
                    activeColor: Colors.purple.shade800,
                    value: "user",
                    groupValue: gender,
                    onChanged: (String? value) {
                      if (value != null)
                        setState(() {
                          gender = value;
                        });
                      print(gender);
                    },),

                  Text("مستخدم", style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp
                  ),),
                  SizedBox(width: 20.w,),
                  Radio(

                    activeColor: Colors.purple.shade800,

                    value: "advertiser",
                    groupValue: gender,
                    onChanged: (String? value) {
                      if (value != null)
                        setState(() {
                          gender = value;
                        });

                      print(gender);
                    },),

                  Text("معلن", style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp
                  ),),


                ],
              ),

              gender == "advertiser" ?
              Column(
                children: [
                  SizedBox(height: 16.h,),
                  FieldScreen(
                      title: "الاسم التجاري", controller: ANameTextController),
                  SizedBox(height: 16.h,),
                  FutureBuilder<List<Activity>>(
                    future: UserApiController().Commercial_Activities(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(
                          color: Colors.purple,));
                      } else
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        ActiveList = snapshot.data ?? [];
                        return Container(
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

                            hint: Text("النشاط التجاري ", style: TextStyle(
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
                            items: snapshot.data!.map<
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
                        );
                      } else {
                        return Center(
                          child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "البريد الالكتروني",
                      controller: AemailTextController),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "رقم الجوال",
                    controller: AphoneTextController,
                    type: TextInputType.phone,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "كلمة المرور",
                    security: true,
                    controller: ApasswordTextController,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "تأكيد كلمة المرور",
                    security: true,
                    controller: ASurepasswordTextController,),
                  SizedBox(height: 16.h,),
                  Center(
                    child: FutureBuilder<List<Cities>>(
                      future: UserApiController().getCity(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(
                            color: Colors.purple,));
                        } else
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          cit = snapshot.data ?? [];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            height: 50.h,
                            width: 330.w,
                            decoration: BoxDecoration(
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

                              hint: Text("المدينة", style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),),

                              iconEnabledColor: Colors.white,

                              value: _selected,
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
                                  _selected = newValue;
                                });
                              },
                              items: snapshot.data!.map<
                                  DropdownMenuItem<String>>((Cities value) {
                                return DropdownMenuItem<String>(

                                  onTap: () {
                                    setState(() {
                                      id = value.id.toString();
                                    });
                                  },
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          return Center(
                            child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                          );
                        }
                      },
                    ),


                  ),
                  SizedBox(height: 16.h,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text("اللوجو التجاري الخاص بك", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp
                      ),),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await pickImage();
                      },
                      child: Container(
                        height: 95.h,
                        width: 95.w,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(9),

                            image: _pickedFile != null ?


                            DecorationImage(
                                fit: BoxFit.cover,
                                image:

                                FileImage(
                                  File(_pickedFile!.path),


                                )
                            ) : null

                        ),
                        child: Align(
                            alignment: Alignment.bottomRight,


                            child: CircleAvatar(
                              backgroundColor: Color(0xff7B217E),
                              radius: 15,
                              child: Icon(
                                Icons.add, size: 20, color: Colors.white,),
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),


                  Row(
                    children: [

                      Text("من خلال التسجيل انت توافق على ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,

                      ),),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/TermsandConditions');
                        },
                        child: Text("الشروط والأحكام ", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,

                            color: Colors.blue.shade900
                        ),),
                      ),
                      Text("الخاصة بنا ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,

                      ),),


                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/privacypolicies');
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text("و سياسة الخصوصية", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,

                              color: Colors.blue.shade900
                          ),),
                        ),
                      ),
                      Checkbox(
                        value: check,
                        activeColor: Color(0xff7B217E),

                        onChanged: (bool? value) {
                          setState(() {
                            check = value!;
                          });
                        },

                      ),
                    ],
                  )
                 ,
                  SizedBox(height: 20.h,),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        Aprogss = true;
                      });
                      check?
                      await register_Advertiser():
                      showSnackBar( context,message: "تحقق من الشروط وسياسة الخصوصية ",error: true) ;
                      setState(() {
                        Aprogss = false;
                      });
                    },
                    child: Aprogss ? CircularProgressIndicator(
                      color: Colors.white,) : Text(
                      'تسجيل جديد', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff7B217E),

                      minimumSize: Size(double.infinity, 50.h),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, '/logain_screen');
                      }, child: Text("تسجيل الدخول", style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,

                          color: Color(0xff7B217E)
                      ),)),
                      Text("لديك حساب ؟", style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,

                      ),),

                    ],
                  )
                ],
              ) :
              Column(
                children: [
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "اسم المستخدم",
                    controller: NameTextController,
                   ),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "البريد الالكتروني",
                    controller: emailTextController,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "رقم الجوال",
                    controller: phoneTextController,
                    type: TextInputType.phone,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "كلمة المرور",
                    security: true,
                    controller: passwordTextController,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "تأكيد كلمة المرور",
                    security: true,
                    controller: SurepasswordTextController,),
                  SizedBox(height: 16.h,),
                  Row(


                    children: [
                      Text("من خلال التسجيل انت توافق على ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,

                      ),),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/TermsandConditions');
                        },
                        child: Text("الشروط والأحكام ", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,

                            color: Colors.blue.shade900
                        ),),
                      ),
                      Text("الخاصة بنا ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,

                      ),),


                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/privacypolicies');
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text("و سياسة الخصوصية", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,

                              color: Colors.blue.shade900
                          ),),
                        ),
                      ),
                      Checkbox(
                        value: check,
                        activeColor: Color(0xff7B217E),

                        onChanged: (bool? value) {
                          setState(() {
                            check = value!;
                          });
                        },

                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),

                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        progss = true;
                      });
                      check?
                      await register_AsUser():
                      showSnackBar( context,message: "تحقق من الشروط وسياسة الخصوصية ",error: true) ;
                      setState(() {
                        progss = false;
                      });
                    },
                    child: progss ? CircularProgressIndicator(
                      color: Colors.white,) : Text(
                      'تسجيل جديد', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp
                    ),),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff7B217E),

                      minimumSize: Size(double.infinity, 50.h),
                    ),
                  ),

                  SizedBox(height: 21.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: ()  {
                        Navigator.pushNamed(context, '/logain_screen');

                      }, child: Text("تسجيل الدخول", style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,

                          color: Color(0xff7B217E)
                      ),)),

                      Text("لديك حساب ؟", style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,

                      ),),

                    ],
                  ),
                  SizedBox(height: 300.h,),

                ],
              ),


            ],
          )


      ),
    );
  }


  User get user {
    User user = User();
    user.name = NameTextController.text;
    user.email = emailTextController.text;
    user.password = passwordTextController.text;
    user.mobile = phoneTextController.text;
    user.type = gender;
    user.rememberToken = SurepasswordTextController.text;

    return user;
  }

  Future register_AsUser() async {
    bool loggedIn = await UserApiController().register_AsUser(context, user);
    if (loggedIn) {
      Navigator.pushNamed(context, '/logain_screen');
      NameTextController.clear();
      emailTextController.clear();
      passwordTextController.clear();
      phoneTextController.clear();
      NameTextController.clear();
      SurepasswordTextController.clear();
    } else {
      setState(() {
        progss = false;
      });
    }

    return loggedIn;
  }




  Future register_Advertiser() async {


    await UserApiController().register_As_Advertiser(
        context,
        name: ANameTextController.text,
        email :AemailTextController.text,
        password : ApasswordTextController.text,
        mobile : AphoneTextController.text,
         type : gender,
       commercialActivities:idActive!,
        cityId: id!,
       image:_pickedFile!.path,
      surpassword: ASurepasswordTextController.text,
      uploadEvent: (status,massege){
          if(status){
            Navigator.pushNamed(context, '/logain_screen');
            ANameTextController.clear();
            AemailTextController.clear();
            ApasswordTextController.clear();
            AphoneTextController.clear();
            ANameTextController.clear();
            ASurepasswordTextController.clear();
            setState(() {
              Aprogss=false;
            });


          }else{

            setState(() {
              Aprogss=false;
            });

          }

      }



    );


  }
  Future pickImage() async {
    _pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {});
      print(_pickedFile);
    }
  }


}