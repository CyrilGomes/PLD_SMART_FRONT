//TO DO: implement the loginInfo class
class LoginInfo {
  String username = "";
  String password = "";

  LoginInfo({required String username, required String password}) {
    username = username;
    password = password;
  }

  LoginInfo.fromjson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
