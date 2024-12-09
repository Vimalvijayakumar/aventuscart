import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/profile/profile_cubit.dart';
import 'package:cart/ui/screens/profile/widgets/address_popup.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:cart/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          AppValidations.showToast("Something went wrong, try again");
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return AppLoader();
        }
        if (state is ProfileSuccess) {
          var userdata = state.userData;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.commonPadding, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 25.w,
                          width: 25.w,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(
                                100.w,
                              ))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                              150.w,
                            )),
                            child: CachedNetworkImage(
                              imageUrl: "${userdata.imageurl}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => AppLoader(),
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              userdata.name.toString(),
                              softWrap: true,
                              style: TextStyle(
                                  color: Appcolors.primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                          ),
                          userdata.mobileNo == null
                              ? SizedBox()
                              : SizedBox(
                                  width: 60.w,
                                  child: Text(
                                    userdata.mobileNo.toString(),
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Appcolors.textColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.sp),
                                  ),
                                ),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              userdata.email.toString(),
                              softWrap: true,
                              style: TextStyle(
                                  color: Appcolors.textColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address:",
                        style: TextStyle(
                            fontSize: 16.sp, color: Appcolors.hintcolor),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Appcolors.hintcolor)),
                            child: SingleChildScrollView(
                              child: Text(
                                userdata.address ?? "",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 2,
                              right: 5,
                              child: InkWell(
                                  onTap: () {
                                    print("hii");
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Addresspopup();
                                      },
                                    ).then(
                                      (value) {
                                        if (value) {
                                          BlocProvider.of<ProfileCubit>(context)
                                              .getprofile();
                                        }
                                      },
                                    );
                                  },
                                  child: Icon(Icons.edit))),
                        ],
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Order List:",
                  //       style: TextStyle(
                  //           fontSize: 16.sp, color: Appcolors.hintcolor),
                  //     ),
                  //     SizedBox(
                  //       height: 5,
                  //     ),
                  //     ListView.separated(
                  //         physics: NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemBuilder: (context, index) => Text("heheh"),
                  //         separatorBuilder: (context, index) => Divider(),
                  //         itemCount: 5),
                  //   ],
                  // )
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
