import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:here_now/app/utils/pref_util.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiEndPoints {
  static const cloudinaryBaseUrl = "https://api.cloudinary.com/v1_1";
  static const auth = "/api/user/auth";
  static const login = "$auth/login";
  static const register = "$auth/register";
  static const userDetail = "$auth/user";
  static const updateUser = "$auth/update";

  ///Events Post Creation
  static const events = "/api/events";
  static const allEvent = "$events/allEvent";
  static const createEvent = "$events/add";
  static const addEventRating = "$events/rating";
  static const addComment = "$events/addComments";
  ///News Creation Post
  static const String  News="/api/news";
  static String  addNews="$News/addNews";
  static  String getComments(String eventId){
    return "$events/getComments/$eventId";
  }
  static String uploadImage(String cloudName) {
    return '/$cloudName/upload/';
  }
}

class ApiClient {
  static const String _defaultBaseUrl = "https://here-now-nine.vercel.app";
  final String baseUrl;

  ApiClient({this.baseUrl = _defaultBaseUrl});
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

  Future<dynamic> postFormData(
      String endpoint, Map<String, dynamic> data) async {
    log("$baseUrl$endpoint");
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));

    // Do not set Content-Type here; it's managed by the library.

    // Add the fields to the request
    for (var key in data.keys) {
      var value = data[key];
      if (value is List<File>) {
        for (var file in value) {
          var fileStream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(
            key,
            fileStream,
            length,
            filename: basename(file.path),
          );
          request.files.add(multipartFile);
        }
      } else {
        request.fields[key] = value.toString();
      }
    }

    log("Data is $data");
    // Send the request
    var response = await request.send();
    final responseBody = await http.Response.fromStream(response);
    log("Response Status: ${responseBody.statusCode}");
    log("Response Body: ${responseBody.body}");

    return _processResponse(responseBody);
  }

  Future<dynamic> get(String endpoint) async {
    final url = '$baseUrl$endpoint';
    log("GET Request: $url");
    final response = await http.get(
      Uri.parse(url),
      headers: _getHeaders(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl$endpoint';
    log("POST Request: $url, Data: $data");
    final response = await http.post(
      Uri.parse(url),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl$endpoint';
    log("PUT Request: $url, Data: $data");
    final response = await http.put(
      Uri.parse(url),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final url = '$baseUrl$endpoint';
    log("DELETE Request: $url");
    final response = await http.delete(
      Uri.parse(url),
      headers: _getHeaders(),
    );
    return _processResponse(response);
  }
}
