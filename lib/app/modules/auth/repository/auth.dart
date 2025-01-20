import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/widgets.dart';

class AuthRepo {
  Future<http.Response> authPost(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("URL=======>>>>>${url}");
      // // Handle only status codes outside the 2xx range as errors
      // if (response.statusCode < 200 || response.statusCode >= 300) {
      //   throw Exception("Failed to load data: ${response.statusCode}");
      // }

      return response; // Return the successful response
    } catch (e) {
      // Log and rethrow exceptions
      debugPrint("Error during HTTP request: $e");
      throw Exception("Error during HTTP request: $e");
    }
  }
}
