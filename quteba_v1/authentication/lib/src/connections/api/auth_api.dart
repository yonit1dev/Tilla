import 'package:authentication/src/service/user_credential.dart';
import 'package:async/async.dart';

abstract class AuthApi {
  Future<Result<String>> signUp(UserCredential userCredential);
  Future<Result<String>> signIn(UserCredential userCredential);
}
