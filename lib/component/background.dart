import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  bool back;
  String rout;
  BackGround({
    required this.child,
    this.back = false,
    this.rout = "",
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [
                  Color(0xff7B217E),
                  Color(0xff7B217E),
                  Color(0xff18499A),
                ],
              ),
            ),
            child: back
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 60.h, horizontal: 20.w),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, rout);
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ))),
                      ),
                    ],
                  )
                : null),
        Container(

          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 156.h),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: child,
        ),
        Positioned(
            right: 110.w,
            left: 110.w,
            top: 78.h,
            child: CircleAvatar(
                radius: 77.sp,
                backgroundColor: Colors.white,
                backgroundImage:  ExactAssetImage("images/bv2.png")

            ))
      ],
    ));
  }
}
