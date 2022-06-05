// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthApi {
  final String baseUrl = 'http://10.0.2.2:7070';

  final String authUrl = '/authentication';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<http.Response> login(
      String username, String password, String authLevel) async {
    try {
      var body = jsonEncode(
        {'username': username, 'password': password, 'authLevel': authLevel},
      );

      http.Response response = await http.post(
          Uri.parse(baseUrl + authUrl + '/login'),
          headers: headers,
          body: body);
      return response;
    } on Exception {
      throw Exception("Couldn't login here Api");
    }
  }

  Future<http.Response> signUp(String firstName, String lastName,
      String username, String password, String authLevel) async {
    var body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'authLevel': authLevel,
    });

    http.Response response = await http.post(
        Uri.parse(baseUrl + authUrl + '/signup'),
        headers: headers,
        body: body);

    return response;
  }
}
