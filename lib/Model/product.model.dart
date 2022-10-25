class ProductModel {
  String? category;
  String? name;
  String? status;
  String? uid;
  double? price;

  ProductModel({
    required this.category,
    required this.name,
    required this.status,
    required this.uid,
    required this.price,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    category = map['category'];
    name = map['name'];
    status = map['status'];
    uid = map['uid'];
    price = map['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['name'] = name;
    data['status'] = status;
    data['uid'] = uid;
    data['price'] = price;
    return data;
  }
}
