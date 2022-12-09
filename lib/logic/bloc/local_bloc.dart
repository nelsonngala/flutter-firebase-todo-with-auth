import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_event.dart';
part 'local_state.dart';

class LocalBloc extends HydratedBloc<LocalEvent, LocalState> {
  LocalBloc() : super(const LocalizedState(locale: Locale('en', ''))) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(LocalizedState(locale: event.locale));
    });
  }

  @override
  LocalState? fromJson(Map<String, dynamic> json) {
    return LocalizedState(locale: Locale(json['value']));
  }

  @override
  Map<String, dynamic>? toJson(LocalState state) {
    if (state is LocalizedState) {
      return {"value": state.locale.languageCode};
    }
    return null;
  }
}
