import 'package:application/registration/forgot_password/forgot_password_cubit.dart';
import 'package:application/registration/forgot_password/forgot_password_screen.dart';
import 'package:application/registration/login/login_cubit.dart';
import 'package:application/registration/login/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../authentication/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  late String email_phone, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    BlocProvider.of<AuthCubit>(context).loggedIn(state.token);
                    Navigator.pop(context);
                  }

                  if (state is LoginFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) => Column(
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    _emailPhoneField(
                        !(state is LoginSubmitting),
                        state is LoginFailed
                            ? state.message == "Incorrect Password"
                                ? null
                                : state.message
                            : null),
                    SizedBox(
                      height: 24,
                    ),
                    _passwordField(
                        !(state is LoginSubmitting),
                        state is LoginFailed
                            ? state.message != "Incorrect Password"
                                ? null
                                : state.message
                            : null),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: state is LoginSubmitting
                                ? null
                                : () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider<
                                                    ForgotPasswordCubit>(
                                                create: (_) =>
                                                    ForgotPasswordCubit(),
                                                child:
                                                    ForgotPasswordScreen())));
                                  },
                            child: Text("Forgot Password?"))),
                    SizedBox(
                      height: 24,
                    ),
                    if (state is LoginSubmitting) CircularProgressIndicator(),
                    SizedBox(
                      height: 28,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            elevation: MaterialStateProperty.all(0),
                            fixedSize: MaterialStateProperty.all(
                                Size(double.maxFinite, 50))),
                        onPressed: (state is LoginSubmitting)
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .login(email_phone, password);
                                }
                              },
                        child: Text('Login')),
                    SizedBox(
                      height: 48,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Don\'t have an account? Sign Up!'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailPhoneField(enableForm, error) {
    return TextFormField(
      enabled: enableForm,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required!";
        }
        if (value.length < 4) {
          return "Invalid credentials!";
        }
        email_phone = value;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter your Email or Phone",
          labelText: "Enter your Email or Phone number",
          suffixIcon: const Icon(Icons.account_circle)),
    );
  }

  Widget _passwordField(enableForm, error) {
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required!";
        }
        if (value.length < 8) {
          return "Incorrect Password";
        }
        password = value;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter your Password",
          labelText: "Password",
          suffixIcon: const Icon(Icons.lock)),
    );
  }
}
