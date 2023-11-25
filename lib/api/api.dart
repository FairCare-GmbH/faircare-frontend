import 'package:dio/dio.dart';

import 'package:faircare/features/users/register/register.model.dart';
import 'package:faircare/features/users/user.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_exception.dart';

class Api {
  static const _baseUrl =
      !kDebugMode ? 'https://app.getfaircare.de' : 'http://192.168.178.26:3000'; //68.104:3000'; //.26:3000';
  static final Dio _client = Dio(BaseOptions(
    connectTimeout: const Duration(milliseconds: 2000),
    receiveTimeout: const Duration(milliseconds: 4000),
    sendTimeout: const Duration(milliseconds: 3000),
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
        if (kDebugMode) {
          print('error in request: $e');
        }
        if (e.response?.statusCode == 401 && _jwt.isNotEmpty) {
          if (kDebugMode) {
            print('regenerating access token');
          }
          // If a 401 response is received, refresh the access token
          await login(_username, _password, false);
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

  static Future<T> request<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (kDebugMode) {
        print('requesting $path using data ${data ?? queryParameters}');
      }
      final response = await _client.request('$_baseUrl$path',
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      if (kDebugMode) {
        print('received ${response.statusCode} with data ${response.data}');
      }

      if (response.statusCode! < 300) {
        if (response.data is String) {
          throw ApiException(
              code: 500,
              messages: ['received poorly formed response from server']);
        }
        return response.data;
      } else if (path != _loginEndpoint &&
          response.statusCode == 401 &&
          _jwt.isNotEmpty) {
        if (kDebugMode) {
          print('regenerating access token');
        }
        // If a 401 response is received, refresh the access token
        await login(_username, _password, false);
        return await request(path,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            queryParameters: queryParameters);
      } //TODO handle errors related to connectvity, i.e. offline mode

      throw ApiException(
          code: response.statusCode!,
          messages: ((response.data['message'] is List
                  ? response.data['message']
                  : [response.data['message']]) as List<dynamic>)
              .map((e) => e.toString())
              .toList());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  static UserModel? _user;
  static const String _loginEndpoint = '/nurses/login';

  static Future<UserModel> login(
      String username, String password, bool stayLoggedIn) async {
    final response = await request<Map>(
      _loginEndpoint,
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
      if (stayLoggedIn) {
        const storage = FlutterSecureStorage(
            aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ));
        await storage.write(key: 'username', value: username);
        await storage.write(key: 'password', value: password);
      }
      return _user = UserModel.fromJson(response['nurse']);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  static UserModel? getUser() => _user;

  static Future<bool> isLoggedIn() async {
    if (_user != null) return true;

    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    await login(await storage.read(key: 'username') ?? '',
        await storage.read(key: 'password') ?? '', false);
    return _user != null;
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
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
    throw ApiException(code: 404, messages: ['Not implemented.']);
  }
}
