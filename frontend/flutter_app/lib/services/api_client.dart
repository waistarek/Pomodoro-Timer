import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import 'local_storage_service.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient({required this.localStorage, http.Client? client})
      : _client = client ?? http.Client();

  final LocalStorageService localStorage;
  final http.Client _client;

  Future<void> Function()? onUnauthorized;

  bool _handlingUnauthorized = false;

  Uri _uri(String path) => Uri.parse('${AppConfig.apiBaseUrl}$path');

  Map<String, String> _headers({bool auth = true}) {
    final headers = {'Content-Type': 'application/json'};
    final token = localStorage.token;

    if (auth && token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<dynamic> get(String path, {bool auth = true}) async {
    final response = await _client.get(
      _uri(path),
      headers: _headers(auth: auth),
    );

    return _handle(response, auth: auth);
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    final response = await _client.post(
      _uri(path),
      headers: _headers(auth: auth),
      body: jsonEncode(body),
    );

    return _handle(response, auth: auth);
  }

  Future<dynamic> put(
    String path,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    final response = await _client.put(
      _uri(path),
      headers: _headers(auth: auth),
      body: jsonEncode(body),
    );

    return _handle(response, auth: auth);
  }

  Future<void> delete(String path, {bool auth = true}) async {
    final response = await _client.delete(
      _uri(path),
      headers: _headers(auth: auth),
    );

    await _handle(response, auth: auth);
  }

  Future<dynamic> _handle(
    http.Response response, {
    required bool auth,
  }) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }

      return jsonDecode(response.body);
    }

    final hadToken = auth && localStorage.token != null;

    if (hadToken && _isAuthError(response.statusCode)) {
      await _handleUnauthorized();
    }

    throw ApiException(
      _extractMessage(response),
      statusCode: response.statusCode,
    );
  }

  bool _isAuthError(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }

  Future<void> _handleUnauthorized() async {
    if (_handlingUnauthorized) {
      return;
    }

    _handlingUnauthorized = true;

    try {
      final callback = onUnauthorized;

      if (callback != null) {
        await callback();
        return;
      }

      await localStorage.clearToken();
    } finally {
      _handlingUnauthorized = false;
    }
  }

  String _extractMessage(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data['detail']?.toString() ?? 'Fehler ${response.statusCode}';
    } catch (_) {
      return 'Fehler ${response.statusCode}';
    }
  }
}
