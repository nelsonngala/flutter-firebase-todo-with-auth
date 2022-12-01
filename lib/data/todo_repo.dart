import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_todo/data/todo_model.dart';

class TodoRepo {
  // final id = FirebaseAuth.instance.currentUser!.uid;
  Future<List<Todo>>? getTodos({required String id}) async {
    List<Todo> todoList = [];
    final resData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('Todos')
        .get();
    for (var element in resData.docs) {
      todoList.add(Todo.fromMap(element.data()));
    }

    return todoList;
  }

  Future<void> addTodo({required Todo todos}) async {
    final doc = FirebaseFirestore.instance
        .collection('Users')
        .doc(todos.uid)
        .collection('Todos')
        .doc();
    todos.id = doc.id;
    await doc.set(todos.toMap());
  }

  Future<void> updateTodo({required Todo todo}) async {
    final doc = FirebaseFirestore.instance
        .collection('Users')
        .doc(todo.uid)
        .collection('Todos')
        .doc(todo.id);
    // todo.id = doc.id;
    await doc.set(todo.toMap());
  }

  Future<void> toggleTodo({required Todo todo}) async {
    Todo toggledTodo = Todo(
        id: todo.id,
        uid: todo.uid,
        todo: todo.todo,
        isCompleted: !todo.isCompleted,
        dateTime: todo.dateTime);
    final doc = FirebaseFirestore.instance
        .collection('Users')
        .doc(todo.uid)
        .collection('Todos')
        .doc(todo.id);
    await doc.set(toggledTodo.toMap());
  }

  Future<void> deleteTodo({required Todo todo}) async {
    final doc = FirebaseFirestore.instance
        .collection('Users')
        .doc(todo.uid)
        .collection('Todos')
        .doc(todo.id);
    await doc.delete();
  }

  Future<void> deleteAllTodos({required String uid}) async {
    final todos = await getTodos(id: uid);
    if (todos != null) {
      final ids = todos.map((e) => e.id).toList();
      for (var i = 0; i <= ids.length - 1; i++) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection('Todos')
            .doc(ids[i])
            .delete();
      }
    }
    return;
  }
}
