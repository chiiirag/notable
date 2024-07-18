import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyB5oTEhbfCD8dERggW3Q6lcy8CjnIspplg",
            appId: "1:965155901108:android:47d439f659b214b51511e1",
            messagingSenderId: "965155901108",
            projectId: "notable-a3fc7",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    log("Bloc: ${bloc.runtimeType} ---Current: ${change.currentState.runtimeType}----Next: ${change.nextState.runtimeType}");
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    log("Bloc Created: ${bloc.runtimeType}");
    super.onCreate(bloc);
  }
}
