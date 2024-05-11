part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoadingForGoogle extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoaded extends AuthState {
  final UserProfile userProfile;
  final String imgPickerPath;
  const AuthLoaded(this.userProfile, this.imgPickerPath);
  @override
  List<Object> get props => [userProfile];
}

final class AuthError extends AuthState {
  final String errorMsg;
  const AuthError(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
