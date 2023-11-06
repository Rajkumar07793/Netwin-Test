import 'package:equatable/equatable.dart';

abstract class SelectionBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectionBlocInitialState extends SelectionBlocState {}

class SelectionBlocLoadingState extends SelectionBlocState {}

class SelectionBlocErrorState extends SelectionBlocState {}

class SelectStringState extends SelectionBlocState {
  final String value;
  SelectStringState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIntState extends SelectionBlocState {
  final int value;
  SelectIntState(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectBoolState extends SelectionBlocState {
  final bool value;

  SelectBoolState(this.value);
  @override
  List<Object?> get props => [value];
}
