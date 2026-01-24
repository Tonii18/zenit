class UserRegister {

  final String email;
  final String username;
  final String phone;
  final String password;

  UserRegister({required this.email, required this.username, required this.phone, required this.password});

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'username': username,
      'phone': phone,
      'password': password
    };
  }

}