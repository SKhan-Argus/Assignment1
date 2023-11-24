class User {
  int id;
  String username;
  String firstname;
  String lastname;
  String email;
  String password;

  User(this.id,this.username, this.firstname, this.lastname, this.email, this.password);

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        username = json['username'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'id':id.toString(),
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
  }) {
    return User(
      id ?? this.id,
      username ?? this.username,
      firstname ?? this.firstname,
      lastname ?? this.lastname,
      email ?? this.email,
      password ?? this.password,
    );
  }

}