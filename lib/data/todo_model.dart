import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class Todo {
  String id;
  final String uid;
  final String todo;
  final bool isCompleted;
  final DateTime dateTime;
  Todo({
    this.id = '',
    required this.uid,
    required this.todo,
    required this.isCompleted,
    required this.dateTime,
  });
  //initialize some Todo properties
  factory Todo.init(
          {required String todo,
          required String uid,
          required DateTime dateTime}) =>
      Todo(
          uid: FirebaseAuth.instance.currentUser!.email!,
          todo: todo,
          isCompleted: false,
          dateTime: dateTime);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'todo': todo,
      'isCompleted': isCompleted,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      todo: map['todo'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }
}
