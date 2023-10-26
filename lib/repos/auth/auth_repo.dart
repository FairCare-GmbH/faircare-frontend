import 'package:faircare/api/api.dart';
import 'package:faircare/models/user_model.dart';

class AuthRepo {
  final api = Api();

  Future<UserModel> loginUser(String username, String password) async {
    final result = await api.login(username, password);
    return result;
  }

  Future<Map> logoutUser() async {
    final result = await api.logout();
    return result;
  }
}
