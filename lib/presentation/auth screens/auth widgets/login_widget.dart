import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo/logic/AuthBloc/auth_bloc.dart';
import 'package:flutter_firebase_todo/presentation/auth%20screens/sign_up_screen.dart';

import 'package:flutter_firebase_todo/presentation/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../reset_password.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
      child: Center(
        child: Scaffold(
          backgroundColor: Utils.bgColor,
          body: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Login',
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, bottom: 15.0, top: 8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const ResetPasswordScreen())));
                          },
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.lato(color: Utils.btnColor),
                          )),
                    ),
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
                              BlocProvider.of<AuthBloc>(context).add(
                                  SignInEvent(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim()));
                            }
                            return;
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.lato(fontSize: 20),
                          )),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2,
                          top: 2.0),
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
                                height: 15,
                                width: 15,
                                child: Image.network(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                'Sign in with Google',
                                style:
                                    GoogleFonts.lato(color: Utils.titleColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New here?',
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const SignUpScreen())));
                              },
                              child: Text(
                                'register',
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
            ],
          ),
        ),
      ),
    );
  }
}
