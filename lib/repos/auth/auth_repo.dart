import 'package:faircare/api/api.dart';
import 'package:faircare/models/user_model.dart';

class AuthRepo {
  Future<UserModel> loginUser(String username, String password, bool stayLoggedIn) async {
    final result = await Api.login(username, password, stayLoggedIn);
    return result;
  }

  Future<Map> logoutUser() async {
    final result = await Api.logout();
    return result;
  }
}
