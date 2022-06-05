import 'package:async/async.dart';
import '../../service/user_credential.dart';
import '../../service/auth_service.dart';
import '../../service/auth_token.dart';
import '../../service/signup_service.dart';

import '../api/auth_api.dart';

class EmailAuthentication implements AuthService, SignUpService {
  UserCredential _userCredential;
  final AuthApi _authApi;

  EmailAuthentication(this._authApi, this._userCredential);

  void credential(
      {String? fullName, required String email, required String password}) {
    _userCredential = UserCredential(fullName, email, password);
  }

  @override
  Future<Result<AuthToken>> signIn() async {
    try {
      var result = await _authApi.signIn(_userCredential);
      return Result.value(AuthToken(result.asValue!.value));
    } catch (err) {
      return Result<AuthToken>.error(err);
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthToken>> signUp(
      String fullName, String email, String password) async {
    UserCredential _credential = UserCredential(fullName, email, password);

    try {
      var result = await _authApi.signUp(_credential);
      return Result.value(AuthToken(result.asValue!.value));
    } catch (err) {
      return Result.error(err);
    }
  }
}
