import 'dart:io';
import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
// MODEL
import 'package:ecommerce_app/models/user_model.dart';
// REPO
import 'package:ecommerce_app/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final UserRepository _userRepo = UserRepository();

  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  String? _email;
  String? _linkImage;
  bool _isEditing = false;
  bool _isLoading = false;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (userData.exists) {
        UserModel userModel = UserModel.fromJson(userData.data()!, user!.uid);
        setState(() {
          _email = userModel.email;
          _fullNameController.text = userModel.fullName;
          _addressController.text = userModel.address;
          _linkImage = userModel.linkImage ?? "";
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _updateUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (user != null) {
        UserModel updatedUser = UserModel(
          id: user!.uid,
          email: _email!,
          fullName: _fullNameController.text.trim(),
          address: _addressController.text.trim(),
          linkImage:
              _linkImage,
        );

        await _userRepo.updateUser(user!.uid, updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật thông tin thành công!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi cập nhật: $e')),
      );
    }

    setState(() {
      _isLoading = false;
      _isEditing = false;
    });
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng xuất thành công!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi đăng xuất: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        TextFormField(
          controller: TextEditingController(text: _email),
          keyboardType: TextInputType.emailAddress,
          enabled: false,
          style: const TextStyle(color: Colors.grey),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildLabeledTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: _isEditing ? Colors.white : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            enabled: _isEditing,
            readOnly: !_isEditing,
            style: TextStyle(
              color: _isEditing ? Colors.black : Colors.grey.shade700,
            ),
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hồ sơ cá nhân")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : (_linkImage != null && _linkImage!.isNotEmpty
                          ? NetworkImage(_linkImage!)
                          : const AssetImage('assets/avtUser.png')
                              as ImageProvider),
                ),
                IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildEmailField(),
            _buildLabeledTextField("Họ và tên", _fullNameController),
            _buildLabeledTextField("Địa chỉ", _addressController),
            const SizedBox(height: 24),
            _isEditing
                ? Column(
                    children: [
                      ElevatedButton(
                        onPressed: _isLoading ? null : _updateUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Lưu thay đổi",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                          });
                        },
                        child: const Text("Hủy",
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7AE582),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    child: const Text("Chỉnh sửa thông tin",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Đăng xuất",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
