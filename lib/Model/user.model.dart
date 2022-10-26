class UserModel {
  String? uid;
  String? name;
  String? cellphone;
  bool? admin;

  UserModel({
    required this.name,
    required this.uid,
    required this.cellphone,
    required this.admin,
  });

  UserModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    uid = map['uid'];
    cellphone = map["cellphone"];
    admin = map["admin"];
  }
}
