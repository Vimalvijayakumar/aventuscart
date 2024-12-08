part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistSuccess extends WishlistState {
  final List<ProductModel> data;

  WishlistSuccess(this.data);
}

final class WishlistFailure extends WishlistState {
  final String error;

  WishlistFailure(this.error);
}
