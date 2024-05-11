part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckLoginAuthEvent extends AuthEvent {
  final BuildContext context;
  const CheckLoginAuthEvent(this.context);

  @override
  List<Object?> get props => [];
}

class LoginWithCredntialEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  const LoginWithCredntialEvent(
      {required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogleEvent extends AuthEvent {
  final BuildContext context;
  const LoginWithGoogleEvent({required this.context});
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  const SignUpEvent(
      {required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthupdateProfileImageEvent extends AuthEvent {
  final BuildContext context;
  final String imgPickerPath;
  const AuthupdateProfileImageEvent(
      {required this.context, required this.imgPickerPath});
  @override
  List<Object?> get props => [imgPickerPath];
}

/////////////////////////////////////////////////
class TaskUpdateEvent extends AuthEvent {
  final BuildContext context;
  final List<UserTask> userTaskList;
  const TaskUpdateEvent({required this.context, required this.userTaskList});
  @override
  List<Object?> get props => [userTaskList];
}

class TaskShareByEmailEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final UserTask userTask;
  const TaskShareByEmailEvent(
      {required this.context, required this.email, required this.userTask});
  @override
  List<Object?> get props => [email, userTask];
}
