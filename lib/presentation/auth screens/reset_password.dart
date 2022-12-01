import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/logic/AuthBloc/auth_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _resetController = TextEditingController();

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: _resetController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email associated with your account'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: ElevatedButton(
                  onPressed: () {
                    if (_resetController.text.trim().isNotEmpty) {
                      BlocProvider.of<AuthBloc>(context).add(
                          ResetPasswordEvent(email: _resetController.text));
                    }
                    return;
                  },
                  child: const Text('Send recovery password')),
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
              if (state is PasswordResetState) {
                return const Text(
                    'Password reset link has been sent to your inbox,');
              }
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }
              if (state is AuthenticationError) {
                return const Text(
                    'Could not send recovery link, try again later,');
              }
              return Container();
            }))
          ],
        ),
      ),
    );
  }
}
