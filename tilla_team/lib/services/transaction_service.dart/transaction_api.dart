import 'dart:convert';

import 'package:http/http.dart' as http;

class TransactionApi {
  final String baseUrl = 'http://10.0.2.2:7070';

  final String transactionUrl = '/transactions';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<http.Response> getAll() async {
    try {
      http.Response result = await http.get(
          Uri.parse(baseUrl + transactionUrl + '/?page=1&limit=10'),
          headers: headers);

      return result;
    } on Exception {
      throw Exception("Couldn't fetch transactions");
    }
  }

  Future<http.Response> addTransaction({
    required String date,
    required String accountID,
    required String type,
    required double amount,
    required String description,
    required String categoryID,
  }) async {
    var body = jsonEncode({
      'date': date,
      'accountID': accountID,
      'type': type,
      'amount': amount.toString(),
      'description': description,
      'categoryID': categoryID,
    });

    final http.Response result = await http.post(
        Uri.parse(baseUrl + transactionUrl + '/add'),
        headers: headers,
        body: body);

    if (result.statusCode != 200) {
      throw Exception("Couldn't connect to server");
    }

    return result;
  }

  Future<http.Response> deleteTransaction() {
    throw Exception("Couldn't delete transaction");
  }
}
