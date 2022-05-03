//dart class that is a repository of the login data
import 'dart:ffi';

import 'package:caption_this/core/network/api_base_helper.dart';

import '../entities/login_info.dart';

class AuthRepository {
  Future<String> attemptLogin(String username, String password) async {
    //http request to get the login info

    ApiBaseHelper helper = ApiBaseHelper();

    var res = await helper.post("/login", {
      "username": username,
      "password": password,
    });
    print(res);
    return res["token"];
  }

  Future<bool> attemptSignup(
      String email, String username, String password) async {
    //http request to get the login info

    ApiBaseHelper helper = ApiBaseHelper();

    var res = await helper.post("/register", {
      "username": username,
      "email": email,
      "password": password,
    });

    if (res == null) throw Exception("Signup failed");
    return res != null;
  }
}
