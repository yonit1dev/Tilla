import 'auth_token.dart';
import 'package:async/async.dart';

// Abstraction for authentication service
abstract class AuthService {
  // Returns a token if signed in succesfully or error result if failed
  Future<Result<AuthToken>> signIn();

  Future<void> signOut();
}
