
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../api/User_Controller.dart';
import '../../../component/main_bac.dart';
import '../../../loed/loed.dart';
import '../../../models/Folllowers_Advertiser.dart';
import '../../../provider/app_provider.dart';

class AllFollower extends StatefulWidget{
 late int id ;
  AllFollower({required this.id});

  @override
  State<AllFollower> createState() => _AllFollowerState();
}

class _AllFollowerState extends State<AllFollower> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getAdmainFollower(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
   return Back_Ground(
     Bar: true,
     backRout: '',
     eror: true,
     childTab: "المتابعين    ",
     back: true,
     child: Consumer<AppProvider>(builder: (context, provider, _) {
     return
       provider.FolowAdmain==null?
           LoedWidget():
       provider.FolowAdmain==[]?
       Center(
         child:  Text(
           'لا يوجد متابعين   ',
           style: TextStyle(fontSize: 26),
         ),
       ):
       ListView.builder(
        shrinkWrap: true,
        itemCount: provider.FolowAdmain!.length,
        itemBuilder: (context, index) {
          return Container(
              height: 71.h,
              width: 343.w,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),

              ),
              child: Card(

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Container(
                        width: 55.w,
                        height: 51.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: provider.FolowAdmain![index].imageProfile==null?
                                null:

                            DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(provider.FolowAdmain![index].imageProfile.toString())
                            ),
                        ),
                        child: provider.FolowAdmain![index].imageProfile==null?
                       Icon(Icons.person_outline):null,
                      ),
                      SizedBox(width:19.w ,),
                      Text(provider.FolowAdmain![index].name.toString(),style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400
                      ),)
                    ],
                  ),
                ),
              )
          );
        },
      );


  })

   );
  }
}