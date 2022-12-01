import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/data/auth_repo.dart';
import 'package:flutter_firebase_todo/data/profile_image_repo.dart';
import 'package:flutter_firebase_todo/data/todo_repo.dart';
import 'package:flutter_firebase_todo/logic/Imagebloc/image_bloc.dart';
import 'package:flutter_firebase_todo/logic/Themebloc/theme_bloc.dart';
import 'package:flutter_firebase_todo/presentation/theme/theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/AuthBloc/auth_bloc.dart';
import 'logic/Todobloc/todo_bloc.dart';
import 'presentation/auth screens/login_screen.dart';
import 'presentation/todos screens/todos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(TodoRepo())
            ..add(GetTodosEvent(id: FirebaseAuth.instance.currentUser!.email!)),
        ),
        BlocProvider(
            create: ((context) =>
                ImageBloc(ProfileImage())..add(UploadImageEvent()))),
        BlocProvider(create: ((context) => ThemeBloc()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: appThemeData[state.appTheme],
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const TodosScreen();
                  }
                  return const LoginScreen();
                }),
          );
        },
      ),
    );
  }
}
