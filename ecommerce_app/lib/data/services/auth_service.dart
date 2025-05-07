import 'package:ecommerce_app/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final AuthRepository _authRepo = AuthRepository();

  Future<User?> login(String email, String password) async {
    return await _authRepo.signIn(email: email, password: password);
  }

  Future<User?> register(String email, String password) async {
    return await _authRepo.signUp(email: email, password: password);
  }

  Future<bool> checkAccountExists(String email) async {
    return await _authRepo.checkAccountExists(email);
  }
}
