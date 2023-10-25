import 'package:dio/dio.dart';
import 'package:faircare/api/api_urls.dart';

class Api {
  late Dio client = Dio(options);
  var options = BaseOptions(
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
    },
    validateStatus: (_) => true,
  );

  Future<Map> login(String username, String password) async {
    Map data = {
      'user': username,
      'password': password,
    };

    final response = await client.post(
      ApiUrl.login,
      data: data,
    );
    return response.data;
  }

  Future<Map> logout() async {
    final response = await client.post(ApiUrl.logout);
    return response.data;
  }
}
