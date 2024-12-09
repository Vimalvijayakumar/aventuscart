import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cart/data/models/user_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final CartRepository _repository;
  ProfileCubit(this._repository) : super(ProfileInitial());

  void getprofile() async {
    try {
      emit(ProfileLoading());
      var res = await _repository.fetchUserData();
      emit(ProfileSuccess(res));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
