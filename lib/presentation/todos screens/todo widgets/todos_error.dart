import 'package:flutter/material.dart';

class TodosErrorWidget extends StatelessWidget {
  final String error;
  const TodosErrorWidget({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(error);
  }
}
