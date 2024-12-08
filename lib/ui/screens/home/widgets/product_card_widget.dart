import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/cart_model.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/ui/screens/home/home_cubit.dart';
import 'package:cart/ui/screens/home/widgets/product_view_widget.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel pItem;
  const ProductCard({
    super.key,
    required this.pItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CartAddedSuccess) {
          AppValidations.showToast("Item added to cart");
        }
        if (state is CartFailure) {
          AppValidations.showToast("Failed, try again ");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Appcolors.bordercolor, width: 0.5),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  //color: secondaryColorlight,

                  borderRadius: BorderRadius.circular(4)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        HomeCubit(CartRepository())
                                          ..addToFav(
                                              pid: pItem.id.toString(),
                                              fromCard: true),
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        CartCubit(CartRepository()),
                                  ),
                                ],
                                child: ProductView(productItem: pItem),
                              )));
                },
                child: CachedNetworkImage(
                    height: 25.w,
                    width: 25.w,
                    imageUrl: "${pItem.image}",
                    fit: BoxFit.fill,
                    placeholder: (context, url) => SizedBox(
                        height: 25.w, width: 25.w, child: const AppLoader()),
                    errorWidget: (context, url, error) {
                      return const Icon(
                        Icons.image_not_supported,
                        // color: Appcolo.hintColor,
                      );
                    }),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  "${pItem.title}",
                  style: TextStyle(fontSize: 16.sp, color: Appcolors.textColor),
                ),
                Text(
                  "₹ ${pItem.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Appcolors.textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  // width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolors.primarycolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Appcolors.primarycolor))),
                      onPressed: () {
                        CartModel cartData = CartModel(
                            category: pItem.category,
                            description: pItem.description,
                            image: pItem.image,
                            itemId: pItem.id,
                            price: pItem.price,
                            title: pItem.title,
                            rating: pItem.rating,
                            count: "1");

                        BlocProvider.of<CartCubit>(context).addToCart(cartData);
                      },
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                            color: Appcolors.sectxtcolor, fontSize: 15.sp),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
