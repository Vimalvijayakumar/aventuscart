import 'dart:async';

import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/screens/home/home_nav.dart';
import 'package:cart/ui/screens/login/login.dart';
import 'package:cart/ui/screens/login/login_cubit.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (CartRepository().authInstance.currentUser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeNavigation(
                      selectedIndex: 0,
                    )),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => LoginCubit(CartRepository()),
                      child: LoginScreen(),
                    )),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Aventus Cart",
          style: TextStyle(
              color: Appcolors.primarycolor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
