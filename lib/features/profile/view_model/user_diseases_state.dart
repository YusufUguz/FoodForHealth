import 'package:equatable/equatable.dart';
import 'package:food_for_health/core/models/user_diseases.dart';

abstract class UserDiseasesState extends Equatable {
  const UserDiseasesState();

  @override
  List<Object> get props => [];
}

class UserDiseasesInitialState extends UserDiseasesState {}

class UserDiseasesLoadingState extends UserDiseasesState {}

class UserDiseasesLoadedState extends UserDiseasesState {
  final List<UserDisease> userDiseases;

  const UserDiseasesLoadedState({required this.userDiseases});

  @override
  List<Object> get props => [userDiseases];
}

class UserDiseasesErrorState extends UserDiseasesState {
  final String errorMessage;

  const UserDiseasesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
