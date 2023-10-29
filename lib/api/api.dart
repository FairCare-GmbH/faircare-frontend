import 'package:dio/dio.dart';

import 'package:faircare/models/register_model.dart';
import 'package:faircare/models/user_model.dart';
import 'package:flutter/foundation.dart';

import 'api_exception.dart';

const condition = true;

class Api {
  static const _baseUrl =
      condition ? 'https://app.getfaircare.de' : 'http://127.0.0.1:3000';
  static final Dio _client = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 750),
    receiveTimeout: const Duration(milliseconds: 2000),
    sendTimeout: const Duration(milliseconds: 750),
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
    },
    validateStatus: (_) => true,
  ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_jwt.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_jwt';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401 && _jwt.isNotEmpty) {
          if (kDebugMode) {
            print('regenerating access token; $e');
          }
          // If a 401 response is received, refresh the access token
          await login(_username, _password);
          // Update the request header with the new access token
          e.requestOptions.headers['Authorization'] = 'Bearer $_jwt';

          // Repeat the request with the updated header
          return handler.resolve(await _client.fetch(e.requestOptions));
        }
        return handler.next(e);
      },
    ));

  static String _jwt = '';
  static String _username = '';
  static String _password = '';

  static Future<Map<String, dynamic>> request(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _client.request('$_baseUrl$path',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);

    if (response.statusCode != null && response.statusCode! < 300) {
      return response.data;
    } //TODO handle errors related to connectvity, i.e. offline mode
    if (kDebugMode) {
      print(response);
    }
    throw ApiException(
        code: response.statusCode!,
        messages: ((response.data['message'] is List
                ? response.data['message']
                : [response.data['message']]) as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }

  static Future<UserModel> login(String username, String password) async {
    final response = await request(
      '/nurses/login',
      options: Options(method: 'POST'),
      data: {
        'user': username,
        'password': password,
      },
    );
    _jwt = response['access_token'];
    _username = username;
    _password = password;

    try {
      return UserModel.fromJson(response['nurse']);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  static Future<UserModel> register(RegisterModel registerDto) async {
    return UserModel.fromJson(await request(
      '/nurses',
      options: Options(method: 'POST'),
      data: registerDto.toJson(),
    ));
  }

  static Future<Map> logout() async {
    _jwt = '';
    _username = '';
    _password = '';
    throw ApiException(code: 404, messages: ['Not implemented.']);
  }
}
