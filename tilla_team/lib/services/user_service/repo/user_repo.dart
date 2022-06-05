import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tilla_team/services/user_service/authApi.dart';

class UserRepository {
  AuthApi authApi = AuthApi();

  Future<http.Response> login(
      String username, String password, String authLevel) async {
    try {
      http.Response result = await authApi.login(username, password, authLevel);

      if (result.statusCode != 200) {
        throw Exception("Here, Couldn't login");
      }
      return result;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<String> register(String firstName, String lastName, String username,
      String password, String authLevel) async {
    try {
      var result = await authApi.signUp(
          firstName, lastName, username, password, authLevel);

      if (result.statusCode != 200) {
        String errorMsg = "Couldn't register user";
        return errorMsg;
      }
      return jsonDecode(result.body)['auth_token'];
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
