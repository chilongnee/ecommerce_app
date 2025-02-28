class CategoryModel {
  String? id;
  String name;
  String? imageUrl;

  CategoryModel({this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json, String docId) {
    return CategoryModel(
      id: docId,
      name: json["name"],
      imageUrl: json["imageUrl"] ?? "",
    );
  }
}
