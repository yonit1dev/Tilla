import 'dart:convert';

import 'package:async/src/result/result.dart';
import 'package:http/http.dart' as http;
import 'package:authentication/src/connections/api/auth_api.dart';
import 'package:authentication/src/service/user_credential.dart';

import 'mapper.dart';

class AuthLayer implements AuthApi {
  final http.Client client;
  String baseUrl;

  AuthLayer(this.client, this.baseUrl);

  @override
  Future<Result<String>> signIn(UserCredential userCredential) async {
    var endpoint = baseUrl + '/auth/signin';

    return await postCredential(Uri.parse(endpoint), userCredential);
  }

  @override
  Future<Result<String>> signUp(UserCredential userCredential) async {
    var endpoint = baseUrl + '/auth/register';

    return await postCredential(Uri.parse(endpoint), userCredential);
  }

  Future<Result<String>> postCredential(
      Uri endpoint, UserCredential credential) async {
    var response = await client.post(endpoint, body: Mapper.toJson(credential));

    if (response.statusCode != 200)
      return Result.error('Failed connection to server');

    var json = jsonDecode(response.body);

    return json['auth_token'] != null
        ? Result.value(json['auth_token'])
        : Result.error(json['message']);
  }
}
