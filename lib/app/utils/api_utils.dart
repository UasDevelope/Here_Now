import 'dart:convert';
import 'dart:developer';
import 'package:here_now/app/utils/pref_util.dart';
import 'package:http/http.dart' as http;

class ApiEndPoints {
  static const auth = "/api/user/auth";
  static const login = "$auth/login";
  static const register = "$auth/register";
  static const userDetail = "$auth/user";
}

class ApiClient {
  static const String _baseUrl = "https://here-now-nine.vercel.app";

  // Dynamic headers
  Map<String, String> _getHeaders() {
    final String token = PrefUtil.getString(PrefUtil.token);
    return {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> _processResponse(http.Response response) async {
    log("Response: ${response.body}, Status Code: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final errorResponse = jsonDecode(response.body);
      log("Error: Status Code: ${response.statusCode}, Body: $errorResponse");
      throw Exception(errorResponse['msg'] ??
          errorResponse["message"] ??
          "An unknown error occurred");
    }
  }

  Future<dynamic> get(String endpoint) async {
    final url = '$_baseUrl$endpoint';
    log("GET Request: $url");
    final response = await http.get(
      Uri.parse(url),
      headers: _getHeaders(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = '$_baseUrl$endpoint';
    log("POST Request: $url, Data: $data");
    final response = await http.post(
      Uri.parse(url),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final url = '$_baseUrl$endpoint';
    log("PUT Request: $url, Data: $data");
    final response = await http.put(
      Uri.parse(url),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final url = '$_baseUrl$endpoint';
    log("DELETE Request: $url");
    final response = await http.delete(
      Uri.parse(url),
      headers: _getHeaders(),
    );
    return _processResponse(response);
  }
}
