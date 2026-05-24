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
    final response =
        await _client.get(_uri(path), headers: _headers(auth: auth));
    return _handle(response);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body,
      {bool auth = true}) async {
    final response = await _client.post(_uri(path),
        headers: _headers(auth: auth), body: jsonEncode(body));
    return _handle(response);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body,
      {bool auth = true}) async {
    final response = await _client.put(_uri(path),
        headers: _headers(auth: auth), body: jsonEncode(body));
    return _handle(response);
  }

  Future<void> delete(String path, {bool auth = true}) async {
    final response =
        await _client.delete(_uri(path), headers: _headers(auth: auth));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(_extractMessage(response),
          statusCode: response.statusCode);
    }
  }

  dynamic _handle(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }
    throw ApiException(_extractMessage(response),
        statusCode: response.statusCode);
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
