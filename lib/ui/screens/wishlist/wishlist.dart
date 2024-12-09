import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/wishlist/widgets/wishlist_tile_widget.dart';
import 'package:cart/ui/screens/wishlist/wishlist_cubit.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if (state is WishlistFailure) {
          AppValidations.showToast("Something went wrong, Try Again");
        }
      },
      builder: (context, state) {
        if (state is WishlistLoading) {
          return AppLoader();
        }
        if (state is WishlistSuccess) {
          var wishlistData = state.data;
          return wishlistData.length <= 0
              ? Center(
                  child: Text("No Data"),
                )
              : ListView.separated(
                  itemCount: wishlistData.length,
                  itemBuilder: (context, index) =>
                      WishlistTile(wishlidtitem: wishlistData[index]),
                  separatorBuilder: (context, index) => Divider(
                    thickness: 0.2,
                    height: 2,
                    color: Appcolors.hintcolor,
                  ),
                );
        }
        return SizedBox();
      },
    );
  }
}
