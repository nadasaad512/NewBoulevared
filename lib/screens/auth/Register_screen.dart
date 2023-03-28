import 'dart:io';
import 'package:new_boulevard/models/activity.dart';
import 'package:new_boulevard/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_boulevard/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../component/background.dart';
import '../../loed/loed.dart';
import '../../models/city.dart';
import '../../provider/app_provider.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers{


















  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, _) {
      Provider.of<AppProvider>(context, listen: false).getAllcity();
      Provider.of<AppProvider>(context, listen: false).getAllActivey();
   return   BackGround(
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
                    groupValue: provider.gender,
                    onChanged: (String? value) {
                      if (value != null)

                        provider.gender = value;
                      provider.notifyListeners();


                    },),

                  Text("مستخدم", style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp
                  ),),
                  SizedBox(width: 20.w,),
                  Radio(

                    activeColor: Colors.purple.shade800,

                    value: "advertiser",
                    groupValue: provider.gender,
                    onChanged: (String? value) {
                      if (value != null)

                          provider.gender = value;
                          provider.notifyListeners();



                    },),

                  Text("معلن", style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp
                  ),),


                ],
              ),

             provider. gender == "advertiser" ?
            provider. ActiveList==[]|| provider.cit==[]?
            LoedWidget():

            Column(
                children: [
                  SizedBox(height: 16.h,),
                  FieldScreen(
                      title: "الاسم التجاري", controller: provider.ANameTextController),
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

                      hint: Text("النشاط التجاري ", style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),),

                      iconEnabledColor: Colors.white,

                      value: provider.selectedActivity,
                      icon: Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.grey.shade500, size: 18,),
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.black, fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                      ),
                      onChanged: (newValue) {

                          provider.selectedActivity = newValue;
                          provider.notifyListeners();

                      },
                      items: provider.ActiveList.map<
                          DropdownMenuItem<String>>((Activity value) {
                        return DropdownMenuItem<String>(

                          onTap: () {

                              provider.idActive = value.id.toString();
                              provider.notifyListeners();

                          },
                          value: value.name,
                          child: Text(value.name!),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "البريد الالكتروني",
                      controller:provider. AemailTextController),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "رقم الجوال",
                    controller: provider.AphoneTextController,
                    type: TextInputType.phone,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "كلمة المرور",
                    security: true,
                    controller: provider.ApasswordTextController,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "تأكيد كلمة المرور",
                    security: true,
                    controller: provider.ASurepasswordTextController,),
                  SizedBox(height: 16.h,),
                  Container(
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

                      value: provider.selectedCity,
                      icon: Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.grey.shade500, size: 18,),
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.black, fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                      ),
                      onChanged: (newValue) {

                          provider.selectedCity = newValue;
                          provider.notifyListeners();

                      },
                      items: provider.cit.map<
                          DropdownMenuItem<String>>((Cities value) {
                        return DropdownMenuItem<String>(

                          onTap: () {

                              provider.id = value.id.toString();
                              provider.notifyListeners();

                          },
                          value: value.name,
                          child: Text(value.name),
                        );
                      }).toList(),
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
                        await provider.pickImage();
                        provider.notifyListeners();
                      },
                      child: Container(
                        height: 95.h,
                        width: 95.w,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(9),

                            image: provider.pickedFile != null ?
                            DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(provider.pickedFile!.path),


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
                      SizedBox(
                        height: 10.h,
                        width: 20.w,
                        child: Checkbox(
                          value: provider.check,
                          activeColor: Color(0xff7B217E),

                          onChanged: (bool? value) {

                              provider.check = value!;
                              provider.notifyListeners();

                          },

                        ),
                      ),
                      SizedBox(width: 20.h,),

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



                    ],
                  ),
                 Row(
                   children: [
                     Text("الخاصة بنا ", style: TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 13.sp,

                     ),),
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
                   ],
                 ),



                  SizedBox(height: 20.h,),
                  ElevatedButton(
                    onPressed: () async {

                      provider.Aprogss = true;
                      provider.notifyListeners();

                      provider.check&&
                          provider.ANameTextController.text.isNotEmpty&&
                          provider.AemailTextController.text.isNotEmpty&&
                          provider. AphoneTextController.text.isNotEmpty&&
                          provider. ApasswordTextController.text.isNotEmpty&&
                          provider.pickedFile!=null&&
                          provider.selectedCity!=null&&
                          provider.selectedActivity!=null ?
                      await provider.register_Advertiser(context):
                      showSnackBar( context,message: "أدخل البيانات المطلوبة  ",error: true) ;
                        provider.Aprogss = false;
                        provider.notifyListeners();

                    },
                    child: provider.Aprogss ? CircularProgressIndicator(
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
                    controller: provider.NameTextController,
                   ),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "البريد الالكتروني",
                    controller: provider.emailTextController,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "رقم الجوال",
                    controller: provider.phoneTextController,
                    type: TextInputType.phone,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "كلمة المرور",
                    security: true,
                    controller: provider.LpasswordTextController,),
                  SizedBox(height: 16.h,),
                  FieldScreen(title: "تأكيد كلمة المرور",
                    security: true,
                    controller: provider.SurepasswordTextController,),
                  SizedBox(height: 16.h,),
                  Row(


                    children: [
                      SizedBox(
                        height: 10.h,
                        width: 20.w,
                        child: Checkbox(
                          value: provider.check,
                          activeColor: Color(0xff7B217E),

                          onChanged: (bool? value) {

                              provider.check = value!;
                              provider.notifyListeners();

                          },

                        ),
                      ),
                      SizedBox(width: 20.h,),
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



                    ],
                  ),
                  Row(
                    children: [
                      Text("الخاصة بنا ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,

                      ),),
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

                    ],
                  ),
                  SizedBox(height: 20.h,),

                  ElevatedButton(
                    onPressed: () async {
                        provider.Uprogss = true;
                        provider.notifyListeners();

                        provider.check&&
                          provider.NameTextController.text.isNotEmpty&&
                          provider. emailTextController.text.isNotEmpty&&
                          provider.phoneTextController.text.isNotEmpty
                          ?
                      await provider.register_AsUser(context):
                      showSnackBar( context,message: "أدخل البيانات المطلوبة ",error: true) ;
                        provider.Uprogss = false;
                        provider.notifyListeners();
                    },
                    child: provider.Uprogss  ? CircularProgressIndicator(
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
    });
  }












}