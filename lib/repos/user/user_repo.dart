import 'package:faircare/models/user_model.dart';

import '../../api/api.dart';

class UserRepo {
  Future<UserModel> getUserDetails() async {
    return Api.getUser()!;
  }
}
