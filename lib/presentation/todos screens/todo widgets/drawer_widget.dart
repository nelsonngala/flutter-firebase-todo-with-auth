import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/logic/AuthBloc/auth_bloc.dart';
import 'package:flutter_firebase_todo/logic/Imagebloc/image_bloc.dart';
import 'package:flutter_firebase_todo/logic/Themebloc/theme_bloc.dart';
import 'package:flutter_firebase_todo/logic/Todobloc/todo_bloc.dart';
import 'package:flutter_firebase_todo/presentation/theme/theme.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/profile_image_repo.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String userEmail = FirebaseAuth.instance.currentUser!.email!;
    return Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountEmail: Text(
                userEmail,
                style: GoogleFonts.lato(),
              ),
              accountName: Text(
                'Task Manager',
                style: GoogleFonts.lato(),
              ),
              currentAccountPicture: CircleAvatar(
                //  backgroundImage: NetworkImage(),
                child: BlocBuilder<ImageBloc, ImageState>(
                    builder: ((context, state) {
                  if (state is ImageUploaded) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(state.imgUrl.imgPath),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                  if (state is ImageLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Text(
                    userEmail.substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontSize: 15.0),
                  );
                })),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Set profile picture.',
                style: textStyle(context),
              ),
              onTap: () async {
                ProfileImage profileImage = ProfileImage();
                await profileImage.getImage().then((value) =>
                    BlocProvider.of<ImageBloc>(context)
                        .add(UploadImageEvent()));
                // BlocProvider.of<ImageBloc>(context).add(UploadImageEvent());
              },
            ),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ListTile(
                  leading: Switch(
                      value: state.appTheme == AppTheme.darkTheme,
                      onChanged: (value) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ThemeChangeEvent());
                      }),
                  title: Text(
                    state.appTheme == AppTheme.lightTheme
                        ? 'Change to dark theme.'
                        : 'Change to light mode.',
                    style: textStyle(context),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Delete All Tasks.',
                style: textStyle(context),
              ),
              onTap: () {
                BlocProvider.of<TodoBloc>(context)
                    .add(DeleteAllTodosEvent(uid: userEmail));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app_sharp,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Log Out.',
                style: textStyle(context),
              ),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              },
            ),
          ],
        ));
  }
}
