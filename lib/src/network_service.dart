import 'dart:convert';
import 'dart:developer';

import 'network_exception.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService();
  static const defaultTimeout = Duration(seconds: 20);

  /// Makes a GET request to the given endpoint
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    log('GET request to $url');
    final uri = Uri.parse(url);
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(defaultTimeout);

      return _getBody(response);
    } catch (e) {
      log('Error in GET request to $uri: $e');
      // check if the error isa network exception
      if (e.toString().contains('Failed host lookup')) {
        throw NetworkException.noInternet();
      }
      rethrow;
    }
  }

  /// Makes a POST request to the given endpoint
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String>? headers,
    String? body,
  }) async {
    final uri = Uri.parse(url);
    try {
      final response = await http
          .post(uri, headers: headers, body: body)
          .timeout(defaultTimeout);

      return _getBody(response);
    } catch (e) {
      log('Error in POST request to $uri: $e');
      // check if the error is network exception
      if (e.toString().contains('Failed host lookup')) {
        throw NetworkException.noInternet();
      }
      rethrow;
    }
  }

  Map<String, dynamic> _getBody(http.Response response) {
    if ((response.statusCode ~/ 100) != 2) {
      throw NetworkException(response.body, response.statusCode);
    }

    if (response.body.isEmpty) return {};

    try {
      final body = jsonDecode(response.body);
      if (body is List || body is String) return {'data': body};

      return body as Map<String, dynamic>;
    } catch (_) {
      // body was not a List or a String or a Map
      return {'data': response.body};
    }
  }
}
