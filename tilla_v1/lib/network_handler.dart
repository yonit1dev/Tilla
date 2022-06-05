import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiHandler {
  String baseUrl = 'http://10.0.2.2:8686';
  var log = Logger();

  Future<http.Response> get(String url) async {
    url = formatter(url);

    var response = await http.get(Uri.parse(url));
    log.i(response.body);
    log.i(response.statusCode);

    return response;
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );

    return response;
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
