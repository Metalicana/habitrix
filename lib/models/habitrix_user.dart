class HabitrixUser {

  final String uid;

  String? _email;

  String? _password;

  String? get getEmail{
    return _email;
  }

  String? get getPassword{
    return _password;
  }

  set setEmail(String? newEmail){
    _email = newEmail;
  }

  set setPassword(String? newPassword){
    _password = newPassword;
  }

  HabitrixUser({ required this.uid });

}