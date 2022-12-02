import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/data/todo_model.dart';
import 'package:flutter_firebase_todo/logic/Todobloc/todo_bloc.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';
import 'package:intl/intl.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController todoController = TextEditingController();
  late TextEditingController dateController;
  late TextEditingController timeController;
  DateTime now = DateTime.now();

  @override
  void initState() {
    dateController = TextEditingController(
        text: now.isToday
            ? 'Today'
            : now.isTomorrow
                ? 'Tomorrow'
                : now.isYesterday
                    ? 'yesterday'
                    : DateFormat('E, d MMM yyyy').format(now));
    timeController =
        TextEditingController(text: DateFormat('h:mm a').format(now));
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
        now.year,
        now.month,
        now.day,
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
          Todo todo =
              Todo.init(uid: uid, todo: todoController.text, dateTime: now);
          BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(todo: todo));

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
          Text(
            'When to todo?',
            style: textStyle(context),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
              //  color: Colors.blue,
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
                      now = updatedDate;
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
                      now = timeOfDay;
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
