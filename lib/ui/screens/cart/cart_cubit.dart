import 'package:bloc/bloc.dart';
import 'package:cart/data/models/cart_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;
  CartCubit(this._repository) : super(CartInitial());
  void addToCart(CartModel item) async {
    emit(CartLoading());
    try {
      await _repository.addToCart(item);
      emit(CartAddedSuccess());
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  void getcart() async {
    emit(CartLoading());
    try {
      var cartList = await _repository.getCartList();
      emit(CartSuccess(cartList));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  void deleteCart(CartModel item) async {
    emit(CartLoading());
    try {
      await _repository.deleteCartItem(item);
      emit(CartDeleteItemSuccess());
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }
}
