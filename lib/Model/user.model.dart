class UserModel {
  String? uid;
  String? name;
  String? cellphone;

  UserModel({
    required this.name,
    required this.uid,
    required this.cellphone,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    uid = map['uid'];
    cellphone = map["cellphone"];
  }
}
