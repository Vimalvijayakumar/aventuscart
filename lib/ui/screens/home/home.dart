import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/main.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/ui/screens/home/home_cubit.dart';
import 'package:cart/ui/screens/home/widgets/product_card_widget.dart';
import 'package:cart/utils/app_validators.dart';
import 'package:cart/utils/colors.dart';
import 'package:cart/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          AppValidations.showToast(state.error);
        }
      },
      builder: (context, state) {
        if (state is Homeloading) {
          return AppLoader();
        }
        if (state is HomeSuccess) {
          var data = state.productList;
          if (data.length > 0) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.commonPadding),
              child: GridView.extent(
                childAspectRatio: (1 / 1.2),
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                //   padding: EdgeInsets.all(8.0),
                children: data.map((item) {
                  return BlocProvider(
                    create: (context) => CartCubit(CartRepository()),
                    child: ProductCard(
                      pItem: item,
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
