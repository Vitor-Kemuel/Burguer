class AddressModel {
  String? district;
  String? zipCode;
  String? city;
  String? complement;
  String? publicPlace;
  String? name;
  String? number;
  String? uid;

  AddressModel({
    required this.district,
    required this.zipCode,
    required this.city,
    required this.complement,
    required this.publicPlace,
    required this.name,
    required this.number,
    required this.uid,
  });

  AddressModel.fromJson(Map<String, dynamic> map) {
    district = map['district'];
    zipCode = map['zipCode'];
    city = map['city'];
    complement = map['complement'];
    publicPlace = map['publicPlace'];
    name = map["name"];
    number = map['number'];
    uid = map['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["district"] = district;
    data["zipCode"] = zipCode;
    data["city"] = city;
    data["complement"] = complement;
    data["publicPlace"] = publicPlace;
    data["name"] = name;
    data["number"] = number;
    data["uid"] = uid;
    return data;
  }
}
