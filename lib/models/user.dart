class UserNew {
  final String uid;
  UserNew({required this.uid});
}

class UserData {
  final String? uid;
  final String? name;
  final String? dilution;
  final int? strength;

  UserData({this.uid, this.name, this.dilution, this.strength});
}
