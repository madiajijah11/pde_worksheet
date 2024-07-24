class UserState {
  int id;
  String username;
  String password;
  String name;
  String titles;
  String degrees;
  String accessRight;
  bool isTechnician;

  UserState({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.titles,
    required this.degrees,
    required this.accessRight,
    required this.isTechnician,
  });
}

// {id: 2, fullName:  Aldhy Friyanto S.Kom, accessRight: USER, isTechnician: true, iat: 1721781327, exp: 1722386127}