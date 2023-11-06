import 'package:equatable/equatable.dart';

abstract class SelectionBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectStringEvent extends SelectionBlocEvent {
  final String value;

  SelectStringEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIntEvent extends SelectionBlocEvent {
  final int value;

  SelectIntEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectBoolEvent extends SelectionBlocEvent {
  final bool value;

  SelectBoolEvent(this.value);
  @override
  List<Object?> get props => [value];
}
