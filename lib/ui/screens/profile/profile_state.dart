part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel userData;

  ProfileSuccess(this.userData);
}

final class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}
