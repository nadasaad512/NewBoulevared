import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../loed/loed.dart';
import '../../story/OneStory.dart';
import '../../api/User_Controller.dart';
import '../../component/main_bac.dart';

import '../../models/city.dart';
import '../../models/detalies.dart';

class DetailesScreen extends StatefulWidget{
  int  idcat;
  String  name;

  DetailesScreen({required this.idcat, required this.name});

  @override
  State<DetailesScreen> createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {
  List<Ads> _detalies = [];
  int ? id;
  bool filt=false;
  List<Cities> cit = [];
  var _selected;

  @override
  Widget build(BuildContext context) {
    return Back_Ground(
      back: true,
      eror: true,
      backRout: '/PartScreen',
      childTab: ' ${widget.name}',
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          children: [
            Row(

              children: [

                IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Color(0xff7B217E),size: 30.sp,)),
                SizedBox(width: 10.w,),

                Text("كل المدن",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                ),),
                FutureBuilder<List<Cities>>(
                  future: UserApiController().getCity(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      cit = snapshot.data ?? [];
                      return  DropdownButton(

                        underline: Container(),
                        //value: _selected,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        onChanged: (newValue) {
                          setState(() {
                            _selected=newValue;
                            filt=true;
                          });
                          },
                        items: snapshot.data!.map<DropdownMenuItem<String>>((Cities value) {

                          return DropdownMenuItem<String>(
                            onTap: (){
                              setState(() {
                                id=value.id;
                              });

                            },
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(

                      );
                    }
                  },
                ),


              ],
            ),
            SizedBox(height: 10.h,),
            FutureBuilder<List<Ads>>(
              future:
              filt==false?
             UserApiController().getDetailes(idcat: widget.idcat):
              UserApiController().FiltterCity(catId: widget.idcat, cityid: id!),


              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoedWidget();
                }
                else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  _detalies = snapshot.data ?? [];
                  return  GridView.builder(
                    scrollDirection: Axis.vertical,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 165.w / 170.h,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.w,
                        mainAxisSpacing: 14.h

                    ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _detalies.length,
                    itemBuilder: (BuildContext, index){
                      return    _detalies[index].adType!.type=="special"?
                      InkWell(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           StoryPage1(
                          //             data:_detalies[index].id!=null?
                          //             _detalies[index].id!:
                          //             2,
                          //
                          //           )
                          //   ),
                          //
                          //
                          //
                          // );


                        },

                        child: Container(
                          margin: EdgeInsets.only(
                              right: 5.w,
                              left: 5.w
                          ),
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_detalies[index].image.toString())
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
                                      backgroundImage:
                                      _detalies[index].advertiser!.imageProfile!=null?

                                      NetworkImage(_detalies[index].advertiser!.imageProfile!):
                                      null,),
                                    SizedBox(width: 10.w,),
                                    Text(



                                      _detalies[index].advertiser!.name!,style: TextStyle(
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
                      ):


                      InkWell(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           StoryPage1(
                          //             data:_detalies[index].id!=null?
                          //             _detalies[index].id!:
                          //             2,
                          //
                          //           )
                          //   ),
                          //
                          //
                          //
                          // );
                          //

                        },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            width: 165.w,
                            height: 98.h,
                            decoration: BoxDecoration(
                                color:   Color(0xff7B217E),
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(_detalies[index].image!)
                                )
                            ),
                            child:  Container(
                              margin: EdgeInsets.only(
                                  bottom: 10.h,
                                  right: 5.w
                              ),
                              alignment: Alignment.bottomRight,
                              child:Row(

                                children: [

                                  CircleAvatar(radius: 14,
                                    backgroundImage:_detalies[index].advertiser!.imageProfile!=null?

                                    NetworkImage(_detalies[index].advertiser!.imageProfile!):
                                  null
                                  ),
                                  SizedBox(width: 10.w,),
                                  Text(



                                    _detalies[index].advertiser!.name!,style: TextStyle(
                                      color:  Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10.sp
                                  ),),


                                ],
                              ),
                            )
                      ),
                        );
                    },



                  );
                }

                else if(snapshot.data!.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80.h,),


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
                  );
                }


                else {
                  return Center(
                    child: Icon(Icons.wifi_off_rounded, size: 80,color: Colors.purple,),
                  );
                }
              },
            ),
          ],
        ),
      )
    );
  }
}