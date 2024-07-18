import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/src/view/login/bloc/login_cubit.dart';
import 'package:notable/src/view/note/view/note_view.dart';
import 'package:notable/src/widget/app_text.dart';

import '../../../core/const/app_string.dart';
import '../../../widget/app_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(
          AppString.login,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginNavigateToNote) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const NoteView()),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextFormField(
                      controller: loginCubit.userNameCtrl,
                      labelText: AppString.userNameLabel,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () => loginCubit.onLoginClick(context),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
