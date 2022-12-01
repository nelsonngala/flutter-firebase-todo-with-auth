part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoEmpty extends TodoState {
  @override
  List<Object> get props => [];
}

class TodosLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoAdded extends TodoState {
  @override
  List<Object> get props => [];
}

class TodosLoaded extends TodoState {
  final List<Todo> todos;
  const TodosLoaded({
    required this.todos,
  });
  @override
  List<Object> get props => [todos];
}

class TodosError extends TodoState {
  final String error;
  const TodosError({
    required this.error,
  });
  @override
  List<Object> get props => [];
}
