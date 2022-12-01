import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_todo/presentation/theme/theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(appTheme: AppTheme.lightTheme)) {
    on<ThemeChangeEvent>((event, emit) {
      emit(ThemeState(
          appTheme: state.appTheme == AppTheme.lightTheme
              ? AppTheme.darkTheme
              : AppTheme.lightTheme));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(appTheme: AppTheme.values[json['value'] as int]);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'value': state.appTheme.index};
  }
}
