class ProductModel {
  String? category;
  String? name;
  String? status;
  String? uid;

  ProductModel({
    required this.category,
    required this.name,
    required this.status,
    required this.uid,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    category = map['category'];
    name = map['name'];
    status = map['status'];
    uid = map['uid'];
  }
}