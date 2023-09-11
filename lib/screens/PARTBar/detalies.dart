import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../loed/loed.dart';
import '../../provider/app_provider.dart';
import '../../story/OneStory.dart';
import '../../component/main_bac.dart';
import '../../models/city.dart';


class DetailesScreen extends StatefulWidget{
  int  idcat;
  String  name;

  DetailesScreen({required this.idcat, required this.name});

  @override
  State<DetailesScreen> createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).getAllcity();
    Provider.of<AppProvider>(context, listen: false).getPartAds(idcat:widget.idcat );
    Provider.of<AppProvider>(context, listen: false).PartAdLoed=false;
    print(widget.idcat);
    return Back_Ground(
      back: true,
      eror: true,
      backRout: '/PartScreen',
      childTab: ' ${widget.name}',
      child:  Consumer<AppProvider>(builder: (context, provider, _) {
      return
      provider.PartAd==null?
        LoedWidget():
        Container(
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
                DropdownButton(

                  underline: Container(),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  onChanged: (newValue) {
                    provider.selectedPart=newValue;
                    provider.filtterPart=true;
                    provider.notifyListeners();
                  },
                  items: provider.cit.map<DropdownMenuItem<String>>((Cities value) {

                    return DropdownMenuItem<String>(
                      onTap: (){
                        provider.idpartcity=value.id;
                        provider.notifyListeners();
                        provider.getPartAds(idcat:widget.idcat );

                      },
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                )


              ],
            ),
            SizedBox(height: 10.h,),
            provider.PartAd!.isNotEmpty?
            GridView.builder(
              scrollDirection: Axis.vertical,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 165.w / 170.h,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 14.h

              ),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: provider.PartAd!.length,
              itemBuilder: (BuildContext, index){
                return    provider.PartAd![index].adType!.type=="special"?
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              storyPageScreen(
                                  AdId:provider.PartAd![index].id!
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
                        color: Colors.grey[300]!,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(provider.PartAd![index].image.toString())
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
                                provider.PartAd![index].advertiser!.imageProfile!=null?

                                NetworkImage(provider.PartAd![index].advertiser!.imageProfile.toString()):
                                null,),
                              SizedBox(width: 10.w,),
                              Text(
                                provider.PartAd![index].advertiser!.name.toString(),style: TextStyle(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              storyPageScreen(
                                  AdId:provider.PartAd![index].id!
                              )

                      ),
                    );

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
                              image: NetworkImage(provider.PartAd![index].image.toString())
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
                                backgroundImage:provider.PartAd![index].advertiser!.imageProfile!=null?

                                NetworkImage(provider.PartAd![index].advertiser!.imageProfile.toString()):
                                null
                            ),
                            SizedBox(width: 10.w,),
                            Text(



                              provider.PartAd![index].advertiser!.name.toString(),style: TextStyle(
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



            ):
            Column(
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
            )
          ],
        ),
      );

      })

    );
  }
}