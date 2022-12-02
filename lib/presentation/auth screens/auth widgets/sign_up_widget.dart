import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/logic/AuthBloc/auth_bloc.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_screen.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.bgColor,
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.rubik(
                          color: Utils.titleColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 25.0),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.montserrat(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Utils.labelColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 25.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (password) =>
                          password != null && password.length < 6
                              ? 'Password should be greater than 6 characters'
                              : null,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.montserrat(),
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: Utils.labelColor,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Utils.btnColor),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim()));
                          }
                          return;
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.lato(fontSize: 20),
                        )),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2, top: 2.0),
                    child: const Text(
                      'or',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Utils.googleBtnColor,
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignInWithGoogleEvent());
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                              ),
                            ),
                            Text(
                              'Sign up with Google',
                              style: GoogleFonts.lato(color: Utils.titleColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.lato(fontSize: 18),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const LoginScreen())));
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.lato(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
