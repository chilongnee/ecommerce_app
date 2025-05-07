import 'package:ecommerce_app/data/models/result_model.dart';
import 'package:ecommerce_app/data/models/user_model.dart';
import 'package:ecommerce_app/data/services/user_service.dart';

class UserController {
  final UserService _userService = UserService();

  // CREATE USER
  Future<ResultModel<void>> createUser(UserModel user) async {
    try {
      await _userService.createUser(user);
      return ResultModel(success: true, message: "Tạo user thành công");
    } catch (e) {
      return ResultModel(success: false, message: "Lỗi khi tạo user: $e");
    }
  }

  // READ USER
  Future<ResultModel<UserModel?>> getUser(UserModel user) async {
    try {
      final userData = await _userService.getUser(user);
      if (userData != null) {
        return ResultModel(success: true, data: userData);
      } else {
        return ResultModel(success: false, message: "Không tìm thấy người dùng");
      }
    } catch (e) {
      return ResultModel(success: false, message: "Lỗi khi lấy user: $e");
    }
  }

  // READ ALL USERS
  Future<ResultModel<List<UserModel>>> getAllUsers() async {
    try {
      final users = await _userService.getAllUsers();
      return ResultModel(success: true, data: users);
    } catch (e) {
      return ResultModel(success: false, message: "Lỗi khi lấy danh sách user: $e");
    }
  }

  // UPDATE USER
  Future<ResultModel<void>> updateUser(UserModel user) async {
    try {
      await _userService.updateUser(user);
      return ResultModel(success: true, message: "Cập nhật thành công");
    } catch (e) {
      return ResultModel(success: false, message: "Lỗi khi cập nhật user: $e");
    }
  }

  // DELETE USER
  Future<ResultModel<void>> deleteUser(UserModel user) async {
    try {
      await _userService.deleteUser(user);
      return ResultModel(success: true, message: "Xoá thành công");
    } catch (e) {
      return ResultModel(success: false, message: "Lỗi khi xoá user: $e");
    }
  }
}
