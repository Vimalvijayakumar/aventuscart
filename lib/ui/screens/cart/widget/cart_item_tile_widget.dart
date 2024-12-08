import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/cart_model.dart';
import 'package:cart/ui/common_widgets/app_loader.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/utils/colors.dart';
import 'package:cart/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartTile extends StatefulWidget {
  final CartModel cartitem;
  const CartTile({super.key, required this.cartitem});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final _countController = TextEditingController();

  cartCoutIncrease() {
    setState(() {
      _countController.text = (int.parse(_countController.text) + 1).toString();
    });
    BlocProvider.of<CartCubit>(context)
        .addToCart(widget.cartitem.copyWith(count: "1"));
  }

  cartCoutDecrease() {
    setState(() {
      if (_countController.text != "1" && _countController.text != "") {
        _countController.text =
            (int.parse(_countController.text) - 1).toString();
        BlocProvider.of<CartCubit>(context)
            .addToCart(widget.cartitem.copyWith(count: "-1"));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countController.text = widget.cartitem.count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.commonPadding),
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
                            imageUrl: "${widget.cartitem.image}",
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
                                widget.cartitem.title.toString(),
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
                                "\u{20B9}${widget.cartitem.price.toString()}",
                                style: TextStyle(
                                    color: Appcolors.primarycolor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                            onTap: () {
                              BlocProvider.of<CartCubit>(context)
                                  .deleteCart(widget.cartitem);
                            },
                            child: Icon(Icons.delete_outline_rounded))
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => cartCoutDecrease(),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Appcolors.hintcolor),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            child: Center(
                                child: Text(
                              "-",
                              style: TextStyle(
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                          ),
                        ),
                        Container(
                            height: 30,
                            width: 20,
                            child: Center(
                              child: TextFormField(
                                  enabled: false,
                                  controller: _countController,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    border: InputBorder.none,
                                  )),
                            )),
                        InkWell(
                          onTap: () => cartCoutIncrease(),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Appcolors.hintcolor),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Center(
                                child: Text(
                              "+",
                              style: TextStyle(
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
