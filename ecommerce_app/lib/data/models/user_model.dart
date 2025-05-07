class UserModel {
  String id;
  String email;
  String fullName;
  String address;
  String? linkImage;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.address,
    this.linkImage,
  });

  // Dùng để chuyển thành Json đẩy dữ liệu lên Firebase
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'address': address,
      'linkImage': linkImage
    };
  }

  // Dùng để chuyển từ Json sang Object để Flutter đọc dữ liệu
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      address: json['address'] ?? '',
      linkImage: json['linkImage'] ?? '',
    );
  }
}
