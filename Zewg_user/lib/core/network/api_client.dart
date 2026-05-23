import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zewg/core/constants/api_constants.dart';
import 'package:zewg/core/errors/app_exception.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ),
  );
  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});

class ApiClient {
  final Dio _dio;
  String? _token;

  ApiClient(this._dio);

  void setToken(String? token) => _token = token;

  String? get token => _token;

  Future<Map<String, dynamic>> get(String path) async {
    final response = await _dio.get<dynamic>(path, options: _authOptions());
    return _asMap(response);
  }

  Future<List<dynamic>> getList(String path) async {
    final response = await _dio.get<dynamic>(path, options: _authOptions());
    final data = response.data;
    if (data is List) return data;
    throw AppException('Expected a JSON array from $path');
  }

  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? body}) async {
    final response = await _dio.post<dynamic>(path, data: body, options: _authOptions());
    return _asMap(response);
  }

  Future<Map<String, dynamic>> put(String path, {Map<String, dynamic>? body}) async {
    final response = await _dio.put<dynamic>(path, data: body, options: _authOptions());
    return _asMap(response);
  }

  Future<void> delete(String path) async {
    try {
      await _dio.delete<dynamic>(path, options: _authOptions());
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Options _authOptions() {
    if (_token == null) return Options();
    return Options(headers: {'Authorization': 'Bearer $_token'});
  }

  Map<String, dynamic> _asMap(Response<dynamic> response) {
    final data = response.data;
    if (data is Map<String, dynamic>) return data;
    if (data == null && response.statusCode == 204) return {};
    throw AppException('Expected a JSON object');
  }

  static AppException _mapError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return AppException(data['message'].toString(), statusCode: e.response?.statusCode);
    }
    return AppException(e.message ?? 'Network error', statusCode: e.response?.statusCode);
  }
}

extension ApiClientCalls on ApiClient {
  Future<Map<String, dynamic>> safePost(String path, {Map<String, dynamic>? body}) async {
    try {
      return await post(path, body: body);
    } on DioException catch (e) {
      throw ApiClient._mapError(e);
    }
  }

  Future<Map<String, dynamic>> safeGet(String path) async {
    try {
      return await get(path);
    } on DioException catch (e) {
      throw ApiClient._mapError(e);
    }
  }

  Future<List<dynamic>> safeGetList(String path) async {
    try {
      return await getList(path);
    } on DioException catch (e) {
      throw ApiClient._mapError(e);
    }
  }

  Future<Map<String, dynamic>> safePut(String path, {Map<String, dynamic>? body}) async {
    try {
      return await put(path, body: body);
    } on DioException catch (e) {
      throw ApiClient._mapError(e);
    }
  }
}
