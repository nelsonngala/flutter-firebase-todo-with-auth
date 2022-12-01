import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/logic/Themebloc/theme_bloc.dart';
import 'package:flutter_firebase_todo/logic/Todobloc/todo_bloc.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/todo%20widgets/drawer_widget.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/todo%20widgets/todos_loaded.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/todo%20widgets/todos_empty.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/todo%20widgets/todos_error.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/todo%20widgets/todos_loading.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_todo_screen.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            foregroundColor: Theme.of(context).primaryColor,
            title: const Text('Task Manager'),
            elevation: 0.0,
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).unselectedWidgetColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AddTodoScreen())));
            },
            child: const Icon(Icons.add),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: TabBar(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        indicatorPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        isScrollable: true,
                        labelColor: const Color(0xff1d6983),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color.fromARGB(255, 17, 15, 13),
                        indicatorWeight: 3,
                        labelStyle: GoogleFonts.lato(
                            fontSize: 18,
                            color: const Color(0xff0d1b21),
                            fontWeight: FontWeight.bold),
                        tabs: const [
                          Tab(
                            text: 'Today',
                          ),
                          Tab(
                            text: 'Pending',
                          ),
                          Tab(
                            text: 'Completed',
                          )
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      BlocBuilder<TodoBloc, TodoState>(
                          builder: ((context, state) {
                        if (state is TodosLoaded) {
                          final todayTodos = state.todos
                              .where((e) =>
                                  e.isCompleted == false && e.dateTime.isToday)
                              .toList();
                          return TodosLoadedWidget(todos: todayTodos);
                        }
                        if (state is TodoEmpty) {
                          return const Center(child: TodosEmptyWidget());
                        }
                        if (state is TodosLoading) {
                          return const Center(child: TodosLoadingWidget());
                        }
                        if (state is TodosError) {
                          return Center(
                              child: TodosErrorWidget(error: state.error));
                        }
                        return const SizedBox();
                      })),
                      BlocBuilder<TodoBloc, TodoState>(
                          builder: ((context, state) {
                        if (state is TodosLoaded) {
                          final pendingTodos = state.todos
                              .where((e) =>
                                      e.isCompleted == false &&
                                      e.dateTime.isToday == false
                                  //&&
                                  //  e.dateTime.isBefore(DateTime.now()) == false
                                  )
                              .toList();
                          return TodosLoadedWidget(todos: pendingTodos);
                        }
                        if (state is TodoEmpty) {
                          return const Center(child: TodosEmptyWidget());
                        }
                        if (state is TodosLoading) {
                          return const Center(child: TodosLoadingWidget());
                        }
                        if (state is TodosError) {
                          return Center(
                              child: TodosErrorWidget(error: state.error));
                        }
                        return const SizedBox();
                      })),
                      BlocBuilder<TodoBloc, TodoState>(
                          builder: ((context, state) {
                        if (state is TodosLoaded) {
                          final completedTodos = state.todos
                              .where((e) => e.isCompleted == true)
                              .toList();
                          return TodosLoadedWidget(todos: completedTodos);
                        }
                        if (state is TodoEmpty) {
                          return const Center(child: TodosEmptyWidget());
                        }
                        if (state is TodosLoading) {
                          return const Center(child: TodosLoadingWidget());
                        }
                        if (state is TodosError) {
                          return Center(
                              child: TodosErrorWidget(error: state.error));
                        }
                        return const SizedBox();
                      })),
                    ]),
                  )
                ],
              )),
        );
      },
    );
  }
}
