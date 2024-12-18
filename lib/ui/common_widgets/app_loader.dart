import 'package:cart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Appcolors.backgroundColor),
      width: 100.w,
      height: 100.h,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
