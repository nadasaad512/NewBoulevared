import 'package:new_boulevard/api/User_Controller.dart';
import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../loed/loed.dart';
import '../../models/special_ads.dart';
import '../../story/OneStory.dart';

class SpeciaScreen extends StatelessWidget{
  List<SpecialAds> _special_ads = [];
  @override
  Widget build(BuildContext context) {
      return Back_Ground(
        back: true,
        Bar: true,
        eror: true,
        childTab: "الإعلانات المميزة",
        child:FutureBuilder<List<SpecialAds>>(
          future: UserApiController().HSpecialAds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoedWidget();
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _special_ads = snapshot.data ?? [];
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _special_ads.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 98.w / 160.h,
                      crossAxisCount: 2,
                      mainAxisSpacing: 14.h

                  ),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext, index){
                    return  InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  storyPageScreen(
                                    AdId: _special_ads[index].id!,
                                  )

                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 5.w,
                          left: 5.w
                        ),
                        width: 130.w,
                        decoration: BoxDecoration(
                            color:   Color(0xff7B217E),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_special_ads[index].image!)
                            )
                        ),

                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(onPressed: (){}, icon:  Icon(Icons.star_rounded,color: Color(0xffFFCC46),size: 25.sp,),),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 10.h,
                                  right: 5.w
                              ),
                              alignment: Alignment.bottomRight,
                              child:Row(

                                children: [

                                  CircleAvatar(radius: 14,
                                    backgroundImage: NetworkImage(_special_ads[index].advertiser!.imageProfile.toString()),),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    _special_ads[index].advertiser!.name.toString()==null?
                                    "الاسم التجاري ":


                                    _special_ads[index].advertiser!.name.toString(),style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10.sp
                                  ),),



                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }


              );





            } else {
              return Center(
                child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
              );
            }
          },
        ),

      );
  }

}