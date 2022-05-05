import 'dart:io';
import 'package:caption_this/core/exceptions/api_exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  final String _baseUrl = "https://smaaaaaaaart.herokuapp.com";
  Future<dynamic> get(String url) async {
    var storage = const FlutterSecureStorage();

    print('Api Get, url $url');
    var responseJson;
    try {
      Uri uri = Uri.parse(_baseUrl + url);

      var authToken = await storage.read(key: "jwt");
      print("Bearer $authToken");
      final response = authToken != null
          ? await http.get(uri,
              headers: {HttpHeaders.authorizationHeader: 'Bearer $authToken'})
          : await http.get(uri);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    Uri uri = Uri.parse(_baseUrl + url);
    var storage = const FlutterSecureStorage();
    var authToken = await storage.read(key: "jwt");
    var res = authToken != null
        ? await http.post(uri, body: jsonEncode(body), headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $authToken"
          })
        : await http.post(uri,
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: jsonEncode(body));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return null;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
