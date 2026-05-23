import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg_admin/core/constants/api_constants.dart';
import 'package:zewg_admin/core/errors/app_exception.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ),
  );
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(ref.watch(dioProvider)));

class ApiClient {
  final Dio _dio;
  String? _token;

  ApiClient(this._dio);

  void setToken(String? token) => _token = token;

  Options _authOptions() {
    if (_token == null) return Options();
    return Options(headers: {'Authorization': 'Bearer $_token'});
  }

  Future<Map<String, dynamic>> safePost(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post<dynamic>(path, data: body, options: _authOptions());
      return _asMap(response);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Map<String, dynamic>> safeGet(String path) async {
    try {
      final response = await _dio.get<dynamic>(path, options: _authOptions());
      return _asMap(response);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<dynamic>> safeGetList(String path) async {
    try {
      final response = await _dio.get<dynamic>(path, options: _authOptions());
      final data = response.data;
      if (data is List) return data;
      throw AppException('Expected a JSON array from $path');
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Map<String, dynamic>> safePut(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.put<dynamic>(path, data: body, options: _authOptions());
      return _asMap(response);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> delete(String path) async {
    try {
      await _dio.delete<dynamic>(path, options: _authOptions());
    } on DioException catch (e) {
      throw _mapError(e);
    }
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
