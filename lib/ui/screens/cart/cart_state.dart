part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<CartModel> cartList;

  CartSuccess(this.cartList);
}

final class CartFailure extends CartState {
  final String error;

  CartFailure(this.error);
}

final class CartAddedSuccess extends CartState {}

final class CartDeleteItemSuccess extends CartState {}
