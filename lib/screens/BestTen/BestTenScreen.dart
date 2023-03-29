import 'package:new_boulevard/api/User_Controller.dart';
import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../loed/loed.dart';
import '../../models/special_ads.dart';
import '../../provider/app_provider.dart';
import '../../story/OneStory.dart';

class BestTenScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).getAllBestTenAds();
    return Consumer<AppProvider>(builder: (context, provider, _) {
    return
      Back_Ground(
        back: true,
        Bar: true,
        eror: true,
        childTab: "أفضل إعلانات الشهر",
        child:  provider.BestAds==null?
        LoedWidget():
        GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount:  provider.BestAds!.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 98.w / 160.h,
              crossAxisCount: 2,
              mainAxisSpacing: 14.h

          ),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  right: 5.w
              ),
              child: InkWell(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StoryPage(
                              AdId: provider.BestAds![index].id!,

                            )
                    ),
                  );

                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: 12.w
                  ),
                  width: 130.w,
                  //height: 190.h,
                  decoration: BoxDecoration(
                      color:  Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),

                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              provider.BestAds![index].image.toString())
                      )
                  ),

                  child: Stack(
                    children: [

                      Container(
                        margin: EdgeInsets.only(
                            bottom: 10.h,
                            right: 5.w
                        ),
                        alignment: Alignment.bottomRight,
                        child:Row(

                          children: [
                            provider.BestAds![index].advertiser!.imageProfile!=null?

                            CircleAvatar(radius: 14,
                              backgroundImage: NetworkImage(

                                  provider.BestAds![index].advertiser!.imageProfile!.toString()),):
                            CircleAvatar(radius: 12.sp,
                                backgroundColor: Color(0xff7B217E),
                                child: Icon(Icons.person_rounded,color: Colors.white,
                                  size: 15.sp,)),
                            SizedBox(width: 10.w,),
                            Text(



                              provider.BestAds![index].advertiser!.name.toString(),style: TextStyle(
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
              ),
            );
          },
        ),


      );

    });
  }

}