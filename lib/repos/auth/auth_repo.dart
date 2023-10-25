import 'package:faircare/api/api.dart';

class AuthRepo {
  final api = Api();

  Future<Map> loginUser(String username, String password) async {
    final result = await api.login(username, password);
    return result;
  }

  Future<Map> logoutUser() async {
    final result = await api.logout();
    return result;
  }
}
