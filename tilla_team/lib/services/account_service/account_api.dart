import 'dart:convert';

import 'package:http/http.dart' as http;

class AccountApi {
  final String baseUrl = 'http://10.0.2.2:7070';

  final String accountUrl = '/accounts';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<http.Response> getAll() async {
    try {
      http.Response result = await http.get(
          Uri.parse(baseUrl + accountUrl + '/?page=1&limit=10'),
          headers: headers);

      return result;
    } on Exception {
      throw Exception("Couldn't fetch account - API");
    }
  }

  Future<http.Response> addAccount(
      {required String bankName,
      required double balance,
      required String type,
      required String assocCard,
      required String assocCardExp}) async {
    var body = jsonEncode({
      'bankName': bankName,
      'balance': balance,
      'type': type,
      'assocCard': assocCard,
      'assocCardExp': assocCardExp,
    });

    final http.Response result = await http.post(
        Uri.parse(baseUrl + accountUrl + '/add'),
        headers: headers,
        body: body);

    if (result.statusCode != 200) {
      throw Exception("Couldn't connect to server");
    }

    return result;
  }
}
