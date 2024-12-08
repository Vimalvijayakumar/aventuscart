import 'package:bloc/bloc.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CartRepository _repository;
  HomeCubit(this._repository) : super(HomeInitial());
  void getProductList() async {
    try {
      emit(Homeloading());
      var productlist = await _repository.getProductList();
      emit(HomeSuccess(productlist));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  void addToFav({required String pid, bool fromCard = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('favitems');
    print(items);
    if (fromCard) {
      if (items == null) {
        emit(FavFlag(false));
      } else {
        if (items.contains(pid)) {
          emit(FavFlag(true));
        } else {
          emit(FavFlag(false));
        }
      }
    } else {
      if (items == null) {
        await prefs.setStringList('favitems', <String>[pid.toString()]);
      } else {
        if (items.contains(pid)) {
          items.remove(pid);
          await prefs.setStringList('favitems', items);
        } else {
          items.add(pid.toString());
          await prefs.setStringList('favitems', items);
        }
      }
      print(items);
      emit(FavFlag(items!.contains(pid)));
    }
  }
}
