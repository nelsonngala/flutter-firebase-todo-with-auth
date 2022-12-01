import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';

class TodosEmptyWidget extends StatelessWidget {
  const TodosEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'No todo created.',
      style: textStyle(context),
    );
  }
}
