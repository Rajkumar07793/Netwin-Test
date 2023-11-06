import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_events.dart';
import 'package:netwin_test/bloc/selection_bloc/selection_bloc_states.dart';
import 'package:netwin_test/globals/widgets/loader.dart';

class DropDownBtn extends StatelessWidget {
  final SelectionBloc bloc;
  final List<String> items;
  const DropDownBtn({super.key, required this.bloc, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is SelectStringState) {
            return DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                value: state.value,
                items: items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  bloc.add(SelectStringEvent(value!));
                });
          }
          return const Loader();
        });
  }
}
