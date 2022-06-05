import 'package:shared_preferences/shared_preferences.dart';
import 'package:tilla_team/services/local_storage/local_token.dart';
import 'package:tilla_team/services/utils/token.dart';

const cachedToken = 'CACHED_TOKEN';

class LocalToken implements ILocalToken {
  final SharedPreferences sharedPreferences;

  LocalToken(this.sharedPreferences);

  @override
  delete(JWToken token) {
    sharedPreferences.remove(cachedToken);
  }

  @override
  Future<JWToken> fetch() {
    final token = sharedPreferences.getString(cachedToken);
    if (token != null) return Future.value(JWToken(token));

    throw Exception("Couldn't find token");
  }

  @override
  Future<void> save(JWToken jwToken) {
    return sharedPreferences.setString(cachedToken, jwToken.value);
  }
}
