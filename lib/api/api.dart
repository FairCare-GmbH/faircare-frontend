import 'package:faircare/api/api_urls.dart';
import 'package:dio/dio.dart';

class Api {
  late Dio client = Dio(options);
  var options = BaseOptions(
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
    },
    validateStatus: (_) => true,
  );

  Future<dynamic> endpoint() async {
    Map data = {};

    final response = await client.post(
      ApiUrl.baseUrl,
      data: data,
    );
    return response.data;
  }
}
