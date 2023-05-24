import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../../api/User_Controller.dart';
import '../../component/main_bac.dart';
import '../../loed/loed.dart';
import '../../models/categories.dart';
import '../../provider/app_provider.dart';
import 'detalies.dart';

class PartScreen extends StatelessWidget{
  bool fromnav ;
  PartScreen({this.fromnav=false});
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).getAllPartCategory();
    return Back_Ground(
      back: true,
      Bar: true,
     eror: fromnav,
      childTab: "الأقسام",
      child:  Consumer<AppProvider>(builder: (context, provider, _) {
         return
       provider.partCategories==null?
       LoedWidget():
       GridView.builder(
        itemCount: provider.partCategories!.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 165.w / 265.h,
            crossAxisCount: 2,
            mainAxisSpacing: 5.h

        ),
        itemBuilder: (BuildContext, index){
          return   InkWell(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(

                      builder: (context) => DetailesScreen(name:provider.partCategories![index].name.toString() ,idcat:provider.partCategories![index].id! ,)
                  ),



                );

              },
              child: Column(
                children: [
                  CachedNetworkImage(
                imageUrl: provider.partCategories![index].image.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  width: 165.w,
                  height: 250.h,
                  decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:imageProvider
                      )
                  ),

                ),),
                  SizedBox(height: 10.h,),
                  Center(
                    child:Text(provider.partCategories![index].name.toString(),style: TextStyle(
                        color:  Color(0xff7B217E),
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp
                    ),) ,
                  )
                ],
              )



          );
        },



      );
    })









    );
  }

}