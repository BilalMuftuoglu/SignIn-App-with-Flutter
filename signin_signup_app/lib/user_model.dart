class User {
  String userName;
  String email;
  String password;
  
  User({
    required this.userName,
    required this.email,
    required this.password,
  });
  
    User.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'password': password,
      };

}
