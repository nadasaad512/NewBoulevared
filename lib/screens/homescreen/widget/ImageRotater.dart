import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../../models/setting.dart';

class CasualImageSlider extends StatefulWidget {
  final List<Banners> imageUrls;

  CasualImageSlider({required this.imageUrls});

  @override
  _CasualImageSliderState createState() => _CasualImageSliderState();
}

class _CasualImageSliderState extends State<CasualImageSlider> {
  final _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {

        if (_currentIndex == widget.imageUrls.length - 1) {
          _currentIndex = 0;
        } else {
          _currentIndex++;
        }
        _controller.animateToPage(
          _currentIndex,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
        );

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children:
          widget.imageUrls.map((url) => Image.network(url.image.toString(),fit: BoxFit.fill,)).toList(),
        ),
        Positioned(
          bottom: 5.h,
          right: 10.w,
          left: 10.w,
          child: Container(
            height: 5,
            alignment: Alignment.bottomCenter,
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:  widget.imageUrls.length ,
                itemBuilder:(BuildContext, int){
                  return Container(
                    height: 5.h,
                    width: 20.w,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:int==_currentIndex? Colors.purple:Colors.white,
                      //  shape: BoxShape.rectangle
                    ),
                  );
                },
              separatorBuilder: (BuildContext, int){
                  return SizedBox(width: 5.w,);
              },
            ),
          ),
        )


      ],
    );
  }


}
