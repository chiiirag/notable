part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoadingState extends SplashState {}

final class SplashNavigateToLogin extends SplashState {}

final class SplashNavigateToNote extends SplashState {}

final class SplashErrorState extends SplashState {
  SplashErrorState({required String errorMessage});
}
