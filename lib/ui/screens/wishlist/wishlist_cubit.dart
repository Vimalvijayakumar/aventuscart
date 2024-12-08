import 'package:bloc/bloc.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final CartRepository _repository;
  WishlistCubit(this._repository) : super(WishlistInitial());

  void getProductList() async {
    try {
      emit(WishlistLoading());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? wishlistItemId = prefs.getStringList('favitems');
      if (wishlistItemId == null) {
        emit(WishlistSuccess([]));
      } else {
        var productlist = await _repository.getProductList();
        var wishlist =
            productlist.map((e) => wishlistItemId.contains(e.id.toString()));
        print(wishlist);
        emit(WishlistSuccess(productlist));
      }
    } catch (e) {
      emit(WishlistFailure(e.toString()));
    }
  }
}
