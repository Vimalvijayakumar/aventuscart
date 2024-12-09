import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/ui/screens/home/home_cubit.dart';
import 'package:cart/ui/screens/home/widgets/product_view_widget.dart';
import 'package:cart/ui/screens/wishlist/wishlist_cubit.dart';
import 'package:cart/utils/colors.dart';
import 'package:cart/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class WishlistTile extends StatelessWidget {
  final ProductModel wishlidtitem;
  const WishlistTile({super.key, required this.wishlidtitem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.commonPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => HomeCubit(CartRepository())
                              ..addToFav(
                                  pid: wishlidtitem.id.toString(),
                                  fromCard: true),
                          ),
                          BlocProvider(
                            create: (context) => CartCubit(CartRepository()),
                          ),
                        ],
                        child: ProductView(productItem: wishlidtitem),
                      )));
        },
        child: Container(
          color: Appcolors.backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: "${wishlidtitem.image}",
                              fit: BoxFit.fill,
                              placeholder: (context, url) => SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: const AppLoader()),
                              errorWidget: (context, url, error) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  // color: Appcolo.hintColor,
                                );
                              }),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wishlidtitem.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Appcolors.textColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "\u{20B9}${wishlidtitem.price.toString()}",
                                  style: TextStyle(
                                      color: Appcolors.primarycolor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<WishlistCubit>(context)
                                    .removeWishlist(wishlidtitem.id.toString());
                              },
                              child: SizedBox(
                                  child: Icon(
                                Icons.favorite_rounded,
                                color: Appcolors.favcolor,
                                size: 30,
                              )))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
