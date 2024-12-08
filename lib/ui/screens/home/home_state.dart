part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class Homeloading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ProductModel> productList;

  HomeSuccess(this.productList);
}

final class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);
}

final class FavFlag extends HomeState {
  final bool favflag;

  FavFlag(this.favflag);
}
