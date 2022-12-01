import 'package:flutter/material.dart';

class TodosLoadingWidget extends StatelessWidget {
  const TodosLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
