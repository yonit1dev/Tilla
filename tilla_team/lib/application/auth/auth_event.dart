part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInAuth extends AuthEvent {
  final String username;
  final String password;
  final String authLevel;

  SignInAuth(this.username, this.password, this.authLevel);
}

class SignUpAuth extends AuthEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String authLevel;

  SignUpAuth(this.firstName, this.lastName, this.username, this.password,
      this.authLevel);
}
