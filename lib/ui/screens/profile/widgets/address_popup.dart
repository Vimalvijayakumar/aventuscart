import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/screens/profile/profile_cubit.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Addresspopup extends StatelessWidget {
  const Addresspopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _addressController = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),

      // Returning SizedBox instead of a Container
      contentPadding: EdgeInsets.zero,
      content: Padding(
          padding: EdgeInsets.zero,
          //  EdgeInsets.only(
          //     bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              // mainAxisAlignment:
              //     MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                          color: Appcolors.textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            size: 15,
                            Icons.close,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    // decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Form(
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 10,
                    style: const TextStyle(color: Appcolors.textColor),
                    controller: _addressController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Appcolors.textColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Enter address"),
                  ),
                )),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Appcolors.primarycolor,
                  onPressed: () {
                    if (_addressController.text.isNotEmpty) {
                      CartRepository _repository = CartRepository();
                      _repository
                          .updateUserAddress(_addressController.text)
                          .onError(
                        (error, stackTrace) {
                          AppValidations.showToast(
                              "Something Wrong in updating Address, Try again");
                        },
                      ).then(
                        (value) => Navigator.of(context).pop(true),
                      );
                    } else {
                      AppValidations.showToast("Please Enter address");
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
