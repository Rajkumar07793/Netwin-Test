import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_events.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_states.dart';

class SelectionBloc extends Bloc<SelectionBlocEvent, SelectionBlocState> {
  SelectionBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      SelectionBlocEvent event, Emitter<SelectionBlocState> emit) async {
    if (event is SelectStringEvent) {
      emit(SelectStringState(event.value));
    }

    if (event is SelectIntEvent) {
      emit(SelectIntState(event.value));
    }

    if (event is SelectBoolEvent) {
      emit(SelectBoolState(event.value));
    }
  }
}
