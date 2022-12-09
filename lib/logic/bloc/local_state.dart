part of 'local_bloc.dart';

abstract class LocalState extends Equatable {
  const LocalState();
}

class LocalInitial extends LocalState {
  @override
  List<Object> get props => [];
}

class LocalizedState extends LocalState {
  final Locale locale;
  const LocalizedState({
    required this.locale,
  });
  @override
  List<Object> get props => [locale];
}
