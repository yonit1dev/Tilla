import 'package:async/async.dart';
import '../service/signup_service.dart';
import '../service/auth_token.dart';

class SignUp {
  final SignUpService _signUpService;

  SignUp(this._signUpService);

  Future<Result<AuthToken>> execute(
    String fullName,
    String email,
    String password,
  ) async {
    return await _signUpService.signUp(fullName, email, password);
  }
}
