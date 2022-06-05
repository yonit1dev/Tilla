import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tilla_team/services/local_storage/local_token.dart';
import 'package:tilla_team/services/local_storage/local_token_impl.dart';
import 'package:tilla_team/services/user_service/repo/user_repo.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<SignInAuth>(mapLoginEvent);
    on<SignUpAuth>(mapRegisterEvent);
  }

  mapLoginEvent(SignInAuth event, emit) async {
    emit(AuthLoading());

    final result = await userRepository.login(
      event.username,
      event.password,
      event.authLevel,
    );

    if (result == null) {
      emit(FailedAuth("Couldn't login here"));
    }
    emit(Authenticated(jsonDecode(result.body)['auth_token'].toString()));
  }

  mapRegisterEvent(SignUpAuth event, emit) async {
    emit(AuthLoading());

    final result = await userRepository.register(
      event.firstName,
      event.lastName,
      event.username,
      event.password,
      event.authLevel,
    );

    if (result == null) {
      emit(FailedAuth("Couldn't register here"));
    }

    emit(Authenticated(result));
  }
}
