import 'package:ecommerce_app/data/models/user_model.dart';
import 'package:ecommerce_app/data/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepo = UserRepository();

  // CREATE USER
  Future<void> createUser(UserModel user) async {
    await _userRepo.createUser(user);
  }

  // READ USER
  Future<UserModel?> getUser(UserModel user) async {
    return await _userRepo.getUser(user);
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.getAllUsers();
  }

  // UPDATE USER
  Future<void> updateUser(UserModel user) async {
    await _userRepo.updateUser(user);
  }

  // DELETE USER
  Future<void> deleteUser(UserModel user) async {
    await _userRepo.deleteUser(user);
  }
}
