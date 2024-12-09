import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/screens/login/login.dart';
import 'package:cart/ui/screens/login/login_cubit.dart';
import 'package:cart/ui/screens/profile/profile_cubit.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LogoutPopUp extends StatelessWidget {
  const LogoutPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to logout ?",
                style: TextStyle(
                    color: Appcolors.primarycolor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () async {
                        CartRepository _repository = CartRepository();
                        _repository.signOut().then((val) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            LoginCubit(CartRepository()),
                                        child: LoginScreen(),
                                      )),
                              (route) => false);
                        }).onError(
                          (error, stackTrace) {
                            AppValidations.showToast("Please Try again");
                          },
                        );
                      },
                      child: Text(
                        "YES",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.textColor),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "NO",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.textColor),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
