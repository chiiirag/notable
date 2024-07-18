part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginNavigateToNote extends LoginState {}

final class LoginLoading extends LoginState {}
