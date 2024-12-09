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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  var filterItems = [];
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
          void filterSearchResults(String query) {
            setState(() {
              filterItems = data
                  .where((item) =>
                      item.title!.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            });
          }

          if (data.length > 0) {
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppConstants.commonPadding),
                    color: Appcolors.backgroundColor,
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Appcolors.hintcolor, width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Appcolors.backgroundColor,
                      ),
                      width: double.infinity,
                      height: 35,
                      child: Center(
                        child: TextFormField(
                            controller: searchController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 14),
                            onChanged: (value) {
                              setState(() {
                                filterSearchResults(value);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "search",
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: InputBorder.none,
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: Appcolors.primarycolor,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Appcolors.hintcolor,
                                ),
                                onPressed: () {},
                              ),
                            )),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.commonPadding),
                      child: filterItems.length > 0 ||
                              searchController.text.isNotEmpty
                          ? filterItems.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Text(
                                      'No Results Found',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Appcolors.hintcolor),
                                    ),
                                  ),
                                )
                              : GridView.extent(
                                  childAspectRatio: (1 / 1.2),
                                  maxCrossAxisExtent: 200.0,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  //   padding: EdgeInsets.all(8.0),
                                  children: filterItems.map((item) {
                                    return BlocProvider(
                                      create: (context) =>
                                          CartCubit(CartRepository()),
                                      child: ProductCard(
                                        pItem: item,
                                      ),
                                    );
                                  }).toList(),
                                )
                          : GridView.extent(
                              childAspectRatio: (1 / 1.2),
                              maxCrossAxisExtent: 200.0,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              //   padding: EdgeInsets.all(8.0),
                              children: data.map((item) {
                                return BlocProvider(
                                  create: (context) =>
                                      CartCubit(CartRepository()),
                                  child: ProductCard(
                                    pItem: item,
                                  ),
                                );
                              }).toList(),
                            )),
                ),
              ],
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
