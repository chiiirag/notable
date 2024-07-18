import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/src/view/add_note/bloc/add_note_cubit.dart';
import 'package:notable/src/view/login/bloc/login_cubit.dart';
import 'package:notable/src/view/note/bloc/note_cubit.dart';
import 'package:notable/src/view/splash/bloc/splash_cubit.dart';
import 'package:notable/src/view/splash/view/splash_view.dart';

import 'core/const/app_string.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SplashCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => NoteCubit()),
        BlocProvider(create: (BuildContext context) => AddNoteCubit()),
      ],
      child: const MaterialApp(
        title: AppString.notable,
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
