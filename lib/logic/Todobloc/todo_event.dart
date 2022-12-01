part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  const AddTodoEvent({
    required this.todo,
  });
  @override
  List<Object> get props => [todo];
}

class GetTodosEvent extends TodoEvent {
  final String id;
  const GetTodosEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}

class ToggleTodoEvent extends TodoEvent {
  final Todo todo;
  const ToggleTodoEvent({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  const UpdateTodoEvent({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;
  const DeleteTodoEvent({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

class DeleteAllTodosEvent extends TodoEvent {
  final String uid;
  const DeleteAllTodosEvent({
    required this.uid,
  });
  @override
  List<Object?> get props => [uid];
}
