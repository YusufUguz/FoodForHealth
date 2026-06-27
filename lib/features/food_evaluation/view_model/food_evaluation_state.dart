import 'package:equatable/equatable.dart';
import 'package:food_for_health/core/models/food.dart';

abstract class FoodEvaluationState extends Equatable {
  const FoodEvaluationState();

  @override
  List<Object> get props => [];
}

class FoodEvaluationInitialState extends FoodEvaluationState {}

class FoodEvaluationLoadingState extends FoodEvaluationState {}

class FoodEvaluationLoadedState extends FoodEvaluationState {
  final Food food;

  const FoodEvaluationLoadedState({required this.food});

  @override
  List<Object> get props => [food];
}

class FoodEvaluationErrorState extends FoodEvaluationState {
  final String errorMessage;

  const FoodEvaluationErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
