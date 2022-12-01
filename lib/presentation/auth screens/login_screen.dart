import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/logic/AuthBloc/auth_bloc.dart';
import 'package:flutter_firebase_todo/presentation/auth%20screens/auth%20widgets/login_widget.dart';
import 'package:flutter_firebase_todo/presentation/todos%20screens/todos_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // const SnackBar snackBar = SnackBar(content: Te)
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            // LoginScreen();
            return;
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return const Center(child: LoginWidget());
            }

            if (state is AuthenticatedState) {
              return const TodosScreen();
            }
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuthenticationError) {
              return const Center(child: LoginWidget());
            }

            return Container();
          },
        ),
      ),
    );
  }
}
