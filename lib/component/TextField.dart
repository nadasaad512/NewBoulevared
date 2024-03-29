import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FieldScreen extends StatefulWidget {
  String title;
  bool security;
  bool vali;
  bool Drop;
  String? SELECTCITY;
  TextInputType type;
  TextEditingController? controller;
  Function? validation;
  bool isicon;
  String? icon;

  FieldScreen({
    this.controller,
    required this.title,
    this.validation,
    this.security = false,
    this.vali = false,
    this.Drop = false,
    this.isicon = false,
    this.icon,
    this.SELECTCITY,
    this.type = TextInputType.text,
  });
  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  bool _obscureText = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      width: 343.w,
      child: TextFormField(
        validator: (v) => widget.vali ? widget.validation!(v) : null,
        controller: widget.controller,
        style: TextStyle(
          fontSize: 15.sp
        ),
        scrollPhysics: ScrollPhysics(),

        keyboardType: widget.type,
        obscureText: _obscureText,
        cursorColor: Colors.black,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.title,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: _border,
          focusedBorder: _border,

          errorStyle: TextStyle(fontSize: 11.sp, color: Colors.red),
          prefixIcon: widget.isicon
              ? SvgPicture.asset(
                  widget.icon!,
                  fit: BoxFit.scaleDown,
                )
              : null,
          suffixIcon: widget.security
              ? InkWell(
                  onTap: () {
                    _toggle();
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade500,
                    size: 25,
                  ))
              : null,
        ),
      ),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.6,
        color: Colors.grey.shade500,
      ),
    );
  }
}
