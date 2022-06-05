import 'dart:convert';

import 'package:http/http.dart' as http;

class BudgetApi {
  final String baseUrl = 'http://10.0.2.2:7070';

  final String budgetUrl = '/budgets';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<http.Response> getAll() async {
    try {
      http.Response result = await http.get(
          Uri.parse(baseUrl + budgetUrl + '/?page=1&limit=10'),
          headers: headers);

      return result;
    } on Exception {
      throw Exception("Couldn't fetch budget - API");
    }
  }

  Future<http.Response> addBudget(
      {required String type,
      required String accountID,
      required String utilized,
      required double goalAmount,
      required String endDate,
      required String description}) async {
    var body = jsonEncode({
      'type': type,
      'accountID': accountID,
      'utilized': utilized,
      'goalAmount': goalAmount,
      'endDate': endDate,
      'description': description,
    });

    final http.Response result = await http.post(
        Uri.parse(baseUrl + budgetUrl + '/add'),
        headers: headers,
        body: body);

    if (result.statusCode != 200) {
      throw Exception("Couldn't connect to server");
    }

    return result;
  }
}
