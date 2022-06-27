import 'dart:convert';

import 'package:http/http.dart' as http;

const server = '192.168.1.12:3000';

final Map<String, String> _headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

class API {
  /// when user `logged in`, this method will be called to
  /// set the token for the headers.
  static set bearerToken(String value) {
    _headers['Authorization'] = 'Bearer $value';
  }

  static Future<http.Response> get({required String endPoint}) async {
    return await http.get(
      Uri.parse('http://$server/$endPoint'),
      headers: _headers,
    );
  }

  static Future<http.Response> post({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    return http.post(
      Uri.parse('http://$server/$endPoint'),
      headers: _headers,
      body: json.encode(data),
    );
  }

  static Future<http.Response> patch({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    return http.patch(
      Uri.parse('http://$server/$endPoint'),
      headers: _headers,
      body: json.encode(data),
    );
  }
}
