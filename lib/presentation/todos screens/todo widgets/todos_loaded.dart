import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_todo/data/todo_model.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/update_todo_screen.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../../logic/Todobloc/todo_bloc.dart';

class TodosLoadedWidget extends StatelessWidget {
  final List<Todo> todos;
  const TodosLoadedWidget({
    Key? key,
    required this.todos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final todayTodos = todos.where((e) => e.dateTime.isToday).toList();
    if (todos.isEmpty) {
      return Center(
        child: Text(
          'Nothing to show here.',
          style: textStyle(context),
        ),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: ((direction) {
            BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(todo: todo));
          }),
          child: Card(
            margin:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 5),
            color: index.isOdd
                ? Theme.of(context).cardColor
                : Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => UpdateTodoScreen(todo: todo))));
              },
              title: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  todo.todo,
                  style: textStyle(context),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 25,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.event,
                          size: 16,
                        ),
                        Text(todo.dateTime.isToday
                            ? 'Today'
                            : todo.dateTime.isTomorrow
                                ? 'Tomorrow'
                                : todo.dateTime.isYesterday
                                    ? 'Yesterday'
                                    : DateFormat('E MMM d, yyyy')
                                        .format(todo.dateTime))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  SizedBox(
                    height: 25,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        Text(DateFormat('h:mm a').format(todo.dateTime))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              trailing: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                    shape: const CircleBorder(),
                    value: todo.isCompleted,
                    onChanged: (value) {
                      BlocProvider.of<TodoBloc>(context)
                          .add(ToggleTodoEvent(todo: todo));
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}
