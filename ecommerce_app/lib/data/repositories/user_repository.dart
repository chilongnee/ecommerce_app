import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREAT USER
  Future<void> createUser(UserModel user) async {
    await _db.collection('user').doc(user.id).set(user.toJson());
  }

  // READ USER
  Future<UserModel?> getUser(UserModel user) async {
    final doc = await _db.collection('user').doc(user.id).get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!, doc.id);
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db.collection('user').get();
    return snapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  // UPDATE USER
  Future<void> updateUser(UserModel user) async {
    await _db.collection('user').doc(user.id).update(user.toJson());
  }

  // DELETE USER
  Future<void> deleteUser(UserModel user) async {
    await _db.collection('user').doc(user.id).delete();
  }
}
