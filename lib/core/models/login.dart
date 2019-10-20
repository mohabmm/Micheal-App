class Login {
  String password;
  String email;

  Login({
    this.email,
    this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    return map;
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
