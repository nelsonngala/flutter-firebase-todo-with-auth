part of 'local_bloc.dart';

abstract class LocalEvent extends Equatable {
  const LocalEvent();
}

class ChangeLocaleEvent extends LocalEvent {
  final Locale locale;
  const ChangeLocaleEvent({
    required this.locale,
  });
  @override
  List<Object> get props => [locale];
}
