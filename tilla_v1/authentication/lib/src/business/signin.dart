import '../service/auth_service.dart';
import 'package:async/async.dart';
import '../service/auth_token.dart';

class SignIn {
  final AuthService _authService;

  SignIn(this._authService);

  Future<Result<AuthToken>> execute() async {
    return await _authService.signIn();
  }
}
