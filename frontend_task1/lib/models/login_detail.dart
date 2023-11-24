class LoginDetail {
  String username;
  String password;

  LoginDetail(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
