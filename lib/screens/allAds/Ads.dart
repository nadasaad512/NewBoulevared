

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import '../../api/User_Controller.dart';
import '../../component/main_bac.dart';
import '../../loed/loed.dart';
import '../../models/ads.dart';
import '../../models/city.dart';
import '../../models/detalies.dart';
import '../../provider/app_provider.dart';
import '../../story/OneStory.dart';

class AdsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).getAllcity();
    Provider.of<AppProvider>(context, listen: false).getAllAdd();


  return
    Back_Ground(
      Bar: true,

      childTab: "الاعلانات",
      child:Consumer<AppProvider>(builder: (context, provider, _) {
      return
        provider.detalies==null?
        LoedWidget():


        Column(

        children: [
          SizedBox(height: 20.h,),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
              SizedBox(width: 10.w,),
              Text("كل المدن",style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
              ),),
              DropdownButton(
                underline: Container(),
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                onChanged: (newValue) {
                  provider.selected=newValue;
                  provider.filtter=true;
                  provider.notifyListeners();
                  provider.getAllAdd();
                },
                items: provider.cit.map<DropdownMenuItem<String>>((Cities value) {

                  return DropdownMenuItem<String>(
                    onTap: (){
                      provider.idcity=value.id;
                    },
                    value: value.name,
                    child: Text(value.name),
                  );
                }).toList(),
              )


            ],
          ),
          SizedBox(height: 5.h,),
          provider.detalies!.isEmpty?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.h,),
              SvgPicture.asset("images/ads.svg"),
              SizedBox(height: 30.h,),
              Text('لا يوجد اعلانات في الوقت الحالي ',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color:  Color(0xff7B217E)
                ),
              ),


            ],
          ):
          Expanded(
            child: Swiper(
              scrollDirection: Axis.vertical,
              itemCount: provider.detalies!.length,
              loop: false,

              itemBuilder: (context,index){
                return  provider.detalies![index].adType!.type=="special"?
                InkWell(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StoryPage(
                                AdId:provider.detalies![index].id!,

                              )
                      ),



                    );

                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                    width: 130.w,
                    decoration: BoxDecoration(
                      color:  Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(provider.detalies![index].image!.toString())
                      ),

                    ),

                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 30.sp,
                            backgroundColor: Colors.purple.shade700,

                            child:TextButton(onPressed: ()
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StoryPage(
                                          AdId:provider.detalies![index].id!,

                                        )
                                ),



                              );



                            }, child: Icon(

                              Icons.play_arrow_rounded ,

                              size: 30.sp,
                              color: Colors.white,
                            ),),
                          ),
                        ),
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
                              provider.detalies![index].advertiser!.imageProfile!=null?
                              CircleAvatar(radius: 14,
                                backgroundImage: NetworkImage(provider.detalies![index].advertiser!.imageProfile.toString()),):
                              CircleAvatar(radius: 12.sp,
                                  backgroundColor: Color(0xff7B217E),
                                  child: Icon(Icons.person_rounded,color: Colors.white,
                                    size: 15.sp,)),
                              SizedBox(width: 10.w,),
                              Text(
                                provider.detalies![index].advertiser!.name.toString(),style: TextStyle(
                                  color:  Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10.sp
                              ),),


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    :
                InkWell(
                  onTap: (){



                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StoryPage(
                                AdId:provider.detalies![index].id!,

                              )
                      ),



                    );


                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                      width: 165.w,
                      height: 170.h,
                      decoration: BoxDecoration(
                          color:Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(provider.detalies![index].image!)
                          )
                      ),
                      child:    Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 30.sp,
                              backgroundColor: Colors.purple.shade700,

                              child:TextButton(onPressed: ()
                              {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StoryPage(
                                            AdId:provider.detalies![index].id!,

                                          )
                                  ),



                                );


                              }, child: Icon(

                                Icons.play_arrow_rounded ,

                                size: 30.sp,
                                color: Colors.white,
                              ),),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10.h,
                                right: 5.w
                            ),
                            alignment: Alignment.bottomRight,
                            child:Row(

                              children: [
                                provider.detalies![index].advertiser!.imageProfile!=null?

                                CircleAvatar(radius: 14, backgroundImage:


                                NetworkImage(provider.detalies![index].advertiser!.imageProfile!)


                                ):
                                CircleAvatar(radius: 12.sp,
                                    backgroundColor: Color(0xff7B217E),
                                    child: Icon(Icons.person_rounded,color: Colors.white,
                                      size: 15.sp,)),
                                SizedBox(width: 10.w,),
                                Text(
                                  provider.detalies![index].advertiser!.name!,style: TextStyle(
                                    color:  Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10.sp
                                ),),


                              ],
                            ),
                          )
                        ],
                      )


                  ),
                );
              },


            ),
          ),


        ],
      );

      })



  );
  }
}