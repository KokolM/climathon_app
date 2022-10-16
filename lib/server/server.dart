import 'dart:convert';
import 'dart:io';

import 'package:climathon_admin/config.dart';
import 'package:climathon_admin/exceptions/http.dart';
import 'package:http/http.dart';

class ServerResponse {
  final int statusCode;
  final dynamic data;

  ServerResponse(this.statusCode, {this.data});
}

class Server {
  static final Client _client = Client();

  static const String _server = Config.server;

  Server._internal();

  static final _singleton = Server._internal();

  factory Server() => _singleton;

  static final Map<String, String> _globalHeaders = {
    'Accept': 'application/json; charset=UTF-8',
    'Referrer-Policy': 'origin',
    'content-type': 'application/json',
  };

  static Response _handleServerErrors(
    Response response,
    Uri uri,
    int expectedStatusCode,
  ) {
    var statusCode = response.statusCode;
    if (statusCode < 400) {
      if (statusCode == expectedStatusCode) {
        return response;
      } else {
        throw StatusCodeException(uri, statusCode, expectedStatusCode);
      }
    }
    throw ClimathonHttpException(uri, statusCode);
  }

  static Map<String, String> _setHeaders(
      Map<String, String>? headers, String? token) {
    var allHeaders = Map.of(_globalHeaders);
    if (headers != null) {
      allHeaders.addAll(headers);
    }
    if (token != null) {
      allHeaders[HttpHeaders.authorizationHeader] = token;
    }
    return allHeaders;
  }

  static Future<Response> get(
    String endPoint,
    int expectedStatusCode, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    String? token,
    int? timeout,
    String service = 'api',
  }) async {
    Uri uri = Uri.https(_server, '/$service/$endPoint', body);
    return await _client
        .get(uri, headers: _setHeaders(headers, token))
        .then((response) {
      return _handleServerErrors(response, uri, expectedStatusCode);
    }).timeout(Duration(seconds: timeout ?? Config.timeout));
  }

  static Future<Response> post(
    String endPoint,
    int expectedStatusCode, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    String? token,
    int? timeout,
    String service = 'api',
  }) async {
    Uri uri = Uri.https(_server, '/$service/$endPoint');
    return await _client
        .post(uri,
            headers: _setHeaders(headers, token),
            body: body == null ? '' : jsonEncode(body))
        .then((response) {
      return _handleServerErrors(response, uri, expectedStatusCode);
    }).timeout(Duration(seconds: timeout ?? Config.timeout));
  }

  static Future<Response> put(
    String endPoint,
    int expectedStatusCode, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    String? token,
    int? timeout,
    String service = 'api',
  }) async {
    Uri uri = Uri.https(_server, '/$service/$endPoint');
    return await _client
        .put(uri,
            headers: _setHeaders(headers, token),
            body: body == null ? '' : jsonEncode(body))
        .then((response) {
      return _handleServerErrors(response, uri, expectedStatusCode);
    }).timeout(Duration(seconds: timeout ?? Config.timeout));
  }

  static Future<Response> delete(
    String endPoint,
    int expectedStatusCode, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    String? token,
    int? timeout,
    String service = 'api',
  }) async {
    Uri uri = Uri.https(_server, '/$service/$endPoint');
    return await _client
        .delete(uri,
            headers: _setHeaders(headers, token),
            body: body == null ? '' : jsonEncode(body))
        .then((response) {
      return _handleServerErrors(response, uri, expectedStatusCode);
    }).timeout(Duration(seconds: timeout ?? Config.timeout));
  }
}
