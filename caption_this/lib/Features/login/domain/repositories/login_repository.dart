//dart class that is a repository of the login data
import 'package:caption_this/core/network/api_base_helper.dart';

import '../entities/login_info.dart';

class LoginRepository {
  Future<LoginInfo> getLogin() async {
    //http request to get the login info

    ApiBaseHelper helper = ApiBaseHelper();

    LoginInfo loginInfo = LoginInfo.fromjson(await helper.get('login'));

    return loginInfo;
  }
}
