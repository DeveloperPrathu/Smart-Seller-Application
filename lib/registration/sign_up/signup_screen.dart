import 'package:application/registration/login/login_cubit.dart';
import 'package:application/registration/otp/otp_cubit.dart';
import 'package:application/registration/sign_up/signup_cubit.dart';
import 'package:application/registration/sign_up/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../login/login_screen.dart';
import '../otp/otp_screen.dart';

class SignUpScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  late String _email;
  late String _phone;
  late String _name;
  late String _password;
  late String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BlocProvider<OtpCubit>(create: (_)=>OtpCubit() ,child: OtpScreen(_email, _phone, _name, _password))));
                  }
                  if (state is SignUpFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) {
                  return Column(
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
                      _emailField(
                          !(state is SignUpSubmitting),
                          state is SignUpFailed
                              ? state.message == 'email already exists'
                                  ? state.message
                                  : null
                              : null),
                      SizedBox(
                        height: 24,
                      ),
                      _phoneField(
                          !(state is SignUpSubmitting),
                          state is SignUpFailed
                              ? state.message == 'phone already exists'
                                  ? state.message
                                  : null
                              : null),
                      SizedBox(
                        height: 24,
                      ),
                      _nameField(!(state is SignUpSubmitting)),
                      SizedBox(
                        height: 24,
                      ),
                      _passwordField(!(state is SignUpSubmitting)),
                      SizedBox(
                        height: 24,
                      ),
                      _confirmPasswordField(!(state is SignUpSubmitting)),
                      SizedBox(
                        height: 28,
                      ),
                      if (state is SignUpSubmitting)
                        CircularProgressIndicator(),
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
                          onPressed: (state is SignUpSubmitting)
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<SignUpCubit>(context)
                                        .requestOtp(_email, _phone);
                                  }
                                },
                          child: Text('Create Account')),
                      SizedBox(
                        height: 48,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider<LoginCubit>(create:(_)=>LoginCubit(),child: LoginScreen())));
                          },
                          child: Text('Already have an account? Login'))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(enableForm, error) {
    return TextFormField(
      enabled: enableForm,
      validator: (value) {
        if (!RegExp(
                EMAIL_REGEX)
            .hasMatch(value!)) {
          return "Please Enter A Valid Email Address!";
        }
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
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
          hintText: "Enter your Email Address",
          labelText: "Email Address",
          suffixIcon: const Icon(Icons.email)),
    );
  }

  Widget _phoneField(enableForm, error) {
    return TextFormField(
      maxLength: 10,
      enabled: enableForm,
      validator: (value) {
        if (value!.length != 10) {
          return "Please Enter A Valid Phone Number!";
        }
        _phone = value;
      },
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 14),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter your Phone Number",
          labelText: "Phone Number",
          suffixIcon: const Icon(Icons.smartphone)),
    );
  }

  Widget _nameField(enableForm) {
    return TextFormField(
      enabled: enableForm,
      validator: (value) {
        if (value!.length <= 1) {
          return "Please Enter A Valid Name!";
        }
        _name = value;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter your Full Name",
          labelText: "Fullname",
          suffixIcon: const Icon(Icons.person)),
    );
  }

  Widget _passwordField(enableForm) {
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value) {
        if (value!.length < 8) {
          return "Please Enter Atleast 8 character";
        }
        _password = value;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter your Password",
          labelText: "Password",
          suffixIcon: const Icon(Icons.lock)),
    );
  }

  Widget _confirmPasswordField(enableForm) {
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value) {
        if (value != _password) {
          return "Password Doesn't Matched";
        }
        _confirmPassword = value!;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: const TextStyle(height: 1),
          hintText: "Confirm Your Password",
          labelText: "Confirm Password",
          suffixIcon: const Icon(Icons.lock)),
    );
  }
}
