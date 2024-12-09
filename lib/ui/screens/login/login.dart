import 'package:cart/ui/addproduct.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/home/home_nav.dart';
import 'package:cart/ui/screens/login/login_cubit.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            AppValidations.showSnackBar(context, state.error.toString());
          }
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeNavigation(
                          selectedIndex: 0,
                        )),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoginSuccess) {
            return AppLoader();
          }
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Aventus Cart",
                    style: TextStyle(
                        color: Appcolors.primarycolor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screensize.height * 0.05,
                  ),
                  Text(
                    "Hi, Welcome back ",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screensize.height * 0.20,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<LoginCubit>(context).signInWithGoogle();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('assets/images/google.png')),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign In with Google',
                            style: TextStyle(
                                color: Appcolors.textColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
