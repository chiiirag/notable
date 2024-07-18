import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/src/view/login/view/login_view.dart';
import 'package:notable/src/view/note/bloc/note_cubit.dart';
import 'package:notable/src/view/note/view/note_view.dart';
import 'package:notable/src/view/splash/bloc/splash_cubit.dart';

import '../../../core/assets/app_asset.dart';
import '../../../widget/app_image_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).initialTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          } else if (state is SplashNavigateToNote) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NoteView()),
            );
          }
        },
        builder: (context, state) {
          return const Center(
            child: AppImageView(
              imagePath: AppAsset.note,
              imageType: ImageType.asset,
            ),
          );
        },
      ),
    );
  }
}
