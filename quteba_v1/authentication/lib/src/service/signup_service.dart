import 'package:async/async.dart';
import 'auth_token.dart';

// Abstraction for signup service
abstract class SignUpService {
  Future<Result<AuthToken>> signUp(
    String fullName,
    String email,
    String password,
  );
}
