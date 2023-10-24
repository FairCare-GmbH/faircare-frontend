import 'package:faircare/global/constants.dart';
import 'package:faircare/models/user_model.dart';

class UserRepo {
  Future<UserModel> getUserDetails() async {
    return userExample;
  }
}
