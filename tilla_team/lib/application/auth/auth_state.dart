part of 'auth_bloc.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String authToken;

  Authenticated(this.authToken);
}

class FailedAuth extends AuthState {
  final String errorMsg;

  FailedAuth(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
