import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/ui/screens/cart/widget/cart_item_tile_widget.dart';
import 'package:cart/ui/screens/home/home_nav.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:cart/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          AppValidations.showToast("Someting went wrong, Try again");
        }
        if (state is CartAddedSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeNavigation(
                        selectedIndex: 2,
                      )));
        }
        if (state is CartDeleteItemSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeNavigation(
                        selectedIndex: 2,
                      )));
        }
      },
      builder: (context, state) {
        if (state is CartLoading) {
          return AppLoader();
        }
        if (state is CartSuccess) {
          var cartList = state.cartList;
          var totalprice = 0;
          cartList.forEach((e) {
            totalprice = totalprice + e.totalPrice!.toInt();
          });
          return cartList.length <= 0
              ? Center(
                  child: Text("Cart is empty"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          final cartitem = cartList[index];
                          return CartTile(cartitem: cartitem);
                        },
                        separatorBuilder: (context, index) => Divider(
                          thickness: 0.2,
                          height: 2,
                          color: Appcolors.hintcolor,
                        ),
                      ),
                    ),
                    totalprice == 0
                        ? SizedBox()
                        : Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30.0)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: AppConstants.commonPadding,
                                    horizontal: AppConstants.commonPadding),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Total:"),
                                        Text(
                                          "\u{20B9} ${totalprice}",
                                          style: TextStyle(
                                              color: Appcolors.primarycolor,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      height: 40,
                                      // width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Appcolors.primarycolor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: const BorderSide(
                                                      color: Appcolors
                                                          .primarycolor))),
                                          onPressed: () {},
                                          child: Text(
                                            "Checkout",
                                            style: TextStyle(
                                                color: Appcolors.sectxtcolor,
                                                fontSize: 16.sp),
                                          )),
                                    ),
                                  ],
                                )),
                          )
                  ],
                );
        }
        return SizedBox();
      },
    );
  }
}
