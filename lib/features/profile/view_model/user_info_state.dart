import 'package:equatable/equatable.dart';
import 'package:food_for_health/core/models/user_info.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

class UserInfoInitialState extends UserInfoState {}

class UserInfoLoadingState extends UserInfoState {}

class UserInfoLoadedState extends UserInfoState {
  final UserInfo userInfo;

  const UserInfoLoadedState({required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

class UserInfoErrorState extends UserInfoState {
  final String errorMessage;

  const UserInfoErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
