import 'package:application/registration/forgot_password/forgot_password_cubit.dart';
import 'package:application/registration/forgot_password/forgot_password_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  late String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if(state is ForgotPasswordFailed){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red,));
                  }
                },
                builder: (context, state)=> Column(
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    Image.asset(state is ForgotPasswordSuccess?
                      "assets/images/inbox.png"
                      :'assets/images/forgot_password.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      state is ForgotPasswordSuccess?
                      "Check your Inbox!":"Forgot Password?",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(state is ForgotPasswordSuccess?
                      "Password reset email has been send successfully to your registered email address, so please check your inbox to set your new password."
                      :
                      "Don\'t woory we just need your registered Email address and its done.",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    _emailField(!(state is ForgotPasswordSubmitting) && !(state is ForgotPasswordSuccess), state is ForgotPasswordFailed?state.message:null),
                    SizedBox(
                      height: 48,
                    ),
                    if(state is ForgotPasswordSubmitting)
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 48,
                    ),
                    if(!(state is ForgotPasswordSuccess))
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
                        onPressed: (state is ForgotPasswordSubmitting)
                            ? null
                            : () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .resetPassword(_email);
                          }
                        },
                        child: Text('Reset Password')),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
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
          hintText: "Enter your Registerd Email Address",
          labelText: "Email Address",
          suffixIcon: const Icon(Icons.email)),
    );
  }
}
