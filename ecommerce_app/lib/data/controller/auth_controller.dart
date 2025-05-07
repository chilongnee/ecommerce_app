import 'package:ecommerce_app/data/models/result_model.dart';
import 'package:ecommerce_app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<ResultModel<User>> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return ResultModel(
        success: false,
        message: 'Email và Password không được để trống',
      );
    }

    try {
      final user = await _authService.login(email, password);
      return ResultModel(
        success: true,
        message: 'Đăng nhập thành công',
        data: user,
      );
    } catch (e) {
      return ResultModel(success: false, message: 'Lỗi: ${e.toString()}');
    }
  }

  Future<ResultModel<User>> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return ResultModel(
        success: false,
        message: 'Email và Password không được để trống',
      );
    }

    if (password.length < 6) {
      return ResultModel(
        success: false,
        message: 'Password phải có ít nhất 6 ký tự',
      );
    }

    try {
      final user = await _authService.register(email, password);
      return ResultModel(
        success: true,
        message: 'Đăng ký thành công',
        data: user,
      );
    } catch (e) {
      return ResultModel(success: false, message: 'Lỗi: ${e.toString()}');
    }
  }

  Future<bool> checkAccountExists(String email) async {
    if (email.isEmpty) return false;
    return await _authService.checkAccountExists(email);
  }
}
