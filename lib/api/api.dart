import 'package:dio/dio.dart';
import 'package:faircare/models/register_model.dart';
import 'package:faircare/models/user_model.dart';

import 'api_exception.dart';

class Api {
  // static const _baseUrl =
  //     true ? 'https://app.getfaircare.de' : 'http://127.0.0.1:3000';
  static const _baseUrl = 'https://app.getfaircare.de';
  late final Dio _client = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 750),
      receiveTimeout: const Duration(milliseconds: 2000),
      sendTimeout: const Duration(milliseconds: 750),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
      validateStatus: (_) => true,
    ),
  );

  Future<Map<String, dynamic>> request(
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

    if (response.statusCode == 200) {
      return response.data;
    } //TODO handle errors related to connectvity, i.e. offline mode

    throw ApiException(
        code: response.statusCode!,
        messages: ((response.data['message'] is List
                ? response.data['message']
                : [response.data['message']]) as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }

  Future<UserModel> login(String username, String password) async {
    final response = await request(
      '/nurses/login',
      options: Options(method: 'POST'),
      data: {
        'user': username,
        'password': password,
      },
    );
    // TODO handle JWT
    // var jwt = response['access_token'];
    return UserModel.fromJson(response['nurse']);
  }

  Future<UserModel> register(RegisterModel registerDto) async {
    return UserModel.fromJson(await request(
      '/nurses',
      options: Options(method: 'POST'),
      data: registerDto.toJson(),
    ));
  }

  Future<Map> logout() async {
    throw ApiException(
      code: 404,
      messages: ['Not implemented.'],
    );
  }
}
