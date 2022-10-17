import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../api/User_Controller.dart';
import '../../component/main_bac.dart';
import '../../models/categories.dart';
import 'detalies.dart';

class PartScreen extends StatelessWidget{
  bool fromnav ;
  PartScreen({this.fromnav=false});
  List<Categories> _categories = [];
  @override
  Widget build(BuildContext context) {

    return Back_Ground(
      back: true,
      Bar: true,
     eror: fromnav,
      childTab: "الأقسام",
      child:  FutureBuilder<List<Categories>>(
        future: UserApiController().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.purple,));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _categories = snapshot.data ?? [];
            return    GridView.builder(
              itemCount: _categories.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 165.w / 98.h,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 14.h

              ),
              itemBuilder: (BuildContext, index){
                return   InkWell(
                  onTap: (){


                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(

                        builder: (context) => DetailesScreen(name:_categories[index].name! ,idcat:_categories[index].id! ,)
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
                          image: NetworkImage(_categories[index].image!)
                        )
                      ),
                      child: Center(
                        child:  Text(_categories[index].name!,style: TextStyle(
                            color:  Color(0xffFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp
                        ),) ,
                      )
                  ),
                );
              },



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