import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter_firebase_todo/data/todo_model.dart';
import 'package:flutter_firebase_todo/logic/Todobloc/todo_bloc.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';

class UpdateTodoScreen extends StatefulWidget {
  final Todo todo;
  const UpdateTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  late TextEditingController todoController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late DateTime newTime = widget.todo.dateTime;

  @override
  void initState() {
    todoController = TextEditingController(text: widget.todo.todo);
    dateController = TextEditingController(
        text: newTime.isToday
            ? 'Today'
            : newTime.isTomorrow
                ? 'Tomorrow'
                : newTime.isYesterday
                    ? 'yesterday'
                    : DateFormat('E, d MMM yyyy').format(newTime));
    timeController =
        TextEditingController(text: DateFormat('h:mm a').format(newTime));
    super.initState();
  }

  @override
  void dispose() {
    timeController.dispose();
    dateController.dispose();
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.email!;
    const SnackBar snackBar =
        SnackBar(content: Text('What todo cannot be empty.'));
    Future<DateTime?> showdatePicker() async {
      DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      return dateTime;
    }

    Future<DateTime?> showtimePicker() async {
      // DateTime? newTime = await _showDatePicker();
      TimeOfDay? selectedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      DateTime timeTodo = DateTime(
        newTime.year,
        newTime.month,
        newTime.day,
        selectedTime!.hour,
        selectedTime.minute,
      );
      return timeTodo;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (todoController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
          Todo todo = Todo(
              id: widget.todo.id,
              isCompleted: false,
              uid: uid,
              todo: todoController.text,
              dateTime: newTime);
          BlocProvider.of<TodoBloc>(context).add(UpdateTodoEvent(todo: todo));

          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'What are you going to todo?',
            style: textStyle(context),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                controller: todoController,
                style: textStyle(context),
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              )),
          const SizedBox(
            height: 5.0,
          ),
          const Text('When to todo?'),
          const SizedBox(
            height: 5.0,
          ),
          Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                controller: dateController,
                readOnly: true,
                style: textStyle(context),
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                onTap: () async {
                  DateTime? updatedDate = await showdatePicker();
                  if (updatedDate != null) {
                    setState(() {
                      dateController = TextEditingController(
                          text: updatedDate.isToday
                              ? 'Today'
                              : updatedDate.isTomorrow
                                  ? 'Tomorrow'
                                  : DateFormat('E, d MMM yyyy')
                                      .format(updatedDate));
                    });
                    setState(() {
                      newTime = updatedDate;
                    });
                    setState(() {
                      timeController = TextEditingController(
                          text: DateFormat('h:mm a').format(updatedDate));
                    });
                  }
                },
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
              margin: const EdgeInsets.only(left: 10.0, right: 50.0),
              child: TextField(
                readOnly: true,
                controller: timeController,
                style: textStyle(context),
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.watch_later_outlined),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                onTap: () async {
                  DateTime? timeOfDay = await showtimePicker();
                  if (timeOfDay != null) {
                    setState(() {
                      newTime = timeOfDay;
                    });
                    setState(() {
                      timeController = TextEditingController(
                          text: DateFormat('h:mm a').format(timeOfDay));
                    });
                  }
                },
              )),
        ],
      ),
    );
  }
}
