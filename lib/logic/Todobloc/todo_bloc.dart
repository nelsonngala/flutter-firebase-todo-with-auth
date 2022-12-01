import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_todo/data/todo_model.dart';
import 'package:flutter_firebase_todo/data/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo _todoRepo;
  TodoBloc(
    this._todoRepo,
  ) : super(TodoEmpty()) {
    on<GetTodosEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        List<Todo>? todos = await _todoRepo.getTodos(id: event.id);

        if (todos == null) {
          return emit(TodoEmpty());
        } else {
          if (todos.isEmpty) {
            return emit(TodoEmpty());
          }
          todos.sort(((a, b) => a.dateTime.compareTo(b.dateTime)));
          return emit(TodosLoaded(todos: todos));
        }
      } on FirebaseException catch (e) {
        return emit(TodosError(error: '$e'));
      } catch (e) {
        return emit(TodosError(error: '$e'));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        await _todoRepo.addTodo(todos: event.todo);
        // emit(TodoAdded());
        add(GetTodosEvent(id: event.todo.uid));
      } catch (e) {
        emit(TodosError(error: '$e'));
      }
    });
    on<UpdateTodoEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        await _todoRepo.updateTodo(todo: event.todo);
        add(GetTodosEvent(id: event.todo.uid));
      } catch (e) {
        emit(TodosError(error: '$e'));
      }
    });

    on<ToggleTodoEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        await _todoRepo.toggleTodo(todo: event.todo);
        add(GetTodosEvent(id: event.todo.uid));
      } catch (e) {
        emit(TodosError(error: '$e'));
      }
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        await _todoRepo.deleteTodo(todo: event.todo);
        add(GetTodosEvent(id: event.todo.uid));
      } catch (e) {
        emit(TodosError(error: '$e'));
      }
    });

    on<DeleteAllTodosEvent>((event, emit) async {
      emit(TodosLoading());
      try {
        await _todoRepo.deleteAllTodos(uid: event.uid);
        add(GetTodosEvent(id: event.uid));
      } catch (e) {
        emit(TodosError(error: '$e'));
      }
    });
  }
}
