import 'package:bloc/bloc.dart';
import 'package:cart/data/models/user_model.dart';
import 'package:cart/data/repositories/cart_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final CartRepository _repository;
  LoginCubit(this._repository) : super(LoginInitial());

  void signInWithGoogle() async {
    emit(LoginLoading());
    try {
      User? userData = await _repository.signInWithGoogle();

      print(userData?.displayName.toString());
      UserModel user = UserModel(
          userId: userData?.uid,
          name: userData?.displayName,
          email: userData?.email,
          mobileNo: userData?.phoneNumber,
          imageurl: userData?.photoURL);
      saveUserToDb(user);

      //  emit(LoginSuccess());
    } catch (e) {
      print(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  void saveUserToDb(UserModel user) async {
    var data = await _repository
        .addUser(user)
        .then((value) => emit(LoginSuccess()))
        .catchError((e) => emit(LoginError(e.toString())));
  }
}
