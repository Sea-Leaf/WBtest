class Users{
  String Uid;
  String Login;

  Users({
    required this.Uid,
    required this.Login,
  });

  Map<String, dynamic> toMap() {
    return {
      'Uid': Uid,
      'Login': Login,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      Uid: map['Uid'] as String,
      Login: map['Login'] as String,
    );
  }
}