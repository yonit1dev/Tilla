import 'package:tilla_team/services/utils/token.dart';

abstract class ILocalToken {
  Future<JWToken> fetch();
  delete(JWToken token);
  Future<void> save(JWToken jwToken);
}
