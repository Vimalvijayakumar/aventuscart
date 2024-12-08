import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/cart_model.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/ui/screens/home/home_cubit.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:cart/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class ProductView extends StatelessWidget {
  final ProductModel productItem;
  const ProductView({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        actions: [
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FavFlag) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<HomeCubit>(context).addToFav(
                      pid: productItem.id.toString(),
                    );
                  },
                  child: SizedBox(
                    child: state.favflag
                        ? Icon(
                            Icons.favorite_rounded,
                            color: Appcolors.favcolor,
                            size: 30,
                          )
                        : Icon(
                            Icons.favorite_border_rounded,
                            color: Appcolors.hintcolor,
                            size: 30,
                          ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
          SizedBox(
            width: AppConstants.commonPadding,
          )
        ],
      ),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartAddedSuccess) {
            AppValidations.showToast("Item added to cart");
          }
          if (state is CartFailure) {
            AppValidations.showToast("Failed, try again ");
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.commonPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                            height: 75.w,
                            width: 75.w,
                            imageUrl: productItem.image.toString(),
                            fit: BoxFit.fill,
                            placeholder: (context, url) => SizedBox(
                                height: 40, width: 35, child: AppLoader()),
                            errorWidget: (context, url, error) {
                              return Icon(
                                Icons.image_not_supported,
                                color: Appcolors.hintcolor,
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        productItem.title.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: Appcolors.textColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        productItem.description.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.sp,
                            color: Appcolors.hintcolor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "₹ " + productItem.price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Appcolors.primarycolor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            itemSize: 15,
                            ignoreGestures: true,
                            initialRating:
                                double.parse(productItem.rating!.toString()),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolors.primarycolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Appcolors.primarycolor))),
                      onPressed: () {
                        CartModel cartData = CartModel(
                            category: productItem.category,
                            description: productItem.description,
                            image: productItem.image,
                            itemId: productItem.id,
                            price: productItem.price,
                            title: productItem.title,
                            rating: productItem.rating,
                            count: "1");

                        BlocProvider.of<CartCubit>(context).addToCart(cartData);
                      },
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                            color: Appcolors.backgroundColor, fontSize: 16.sp),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
