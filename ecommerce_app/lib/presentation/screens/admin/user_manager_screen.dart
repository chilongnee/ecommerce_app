import 'package:ecommerce_app/data/controller/user_controller.dart';
import 'package:ecommerce_app/data/models/user_model.dart';
import 'package:ecommerce_app/presentation/widgets/button/list_grid_button.dart';
import 'package:ecommerce_app/presentation/widgets/button/sort_button.dart';
import 'package:ecommerce_app/presentation/widgets/card/user_card.dart';
import 'package:ecommerce_app/presentation/widgets/form/grid_view_custom.dart';
import 'package:ecommerce_app/presentation/widgets/form/list_view_custom.dart';
import 'package:flutter/material.dart';

class UserManagerScreen extends StatefulWidget {
  const UserManagerScreen({super.key});

  @override
  State<UserManagerScreen> createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  final UserController _userController = UserController();

  List<UserModel> _allUsers = [];
  List<UserModel> _selectedUsers = [];

  bool _isGridView = false;
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  void getAllUser() async {
    final result = await _userController.getAllUsers();

    if (result.success && result.data != null) {
      setState(() {
        _allUsers = result.data!;
      });
    } else {
      print("Lỗi khi lấy danh sách người dùng: ${result.message}");
    }
  }

  void _onUserLongPress(UserModel user) {
    setState(() {
      _isSelecting = true;
      _selectedUsers.add(user);
    });
  }

  void _onUserTap(UserModel user) {
    if (_isSelecting) {
      setState(() {
        if (_selectedUsers.contains(user)) {
          _selectedUsers.remove(user);
          if (_selectedUsers.isEmpty) _isSelecting = false;
        } else {
          _selectedUsers.add(user);
        }
      });
    } else {
      // Information of user
    }
  }

  void _deleteSelectedUser() async {
    for (var user in _selectedUsers) {
      await _userController.deleteUser(user);
    }

    setState(() {
      _allUsers.removeWhere((user) => _selectedUsers.contains(user));
      _selectedUsers.clear();
      _isSelecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedUsers.isNotEmpty)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Xóa người dùng đã chọn',
                    onPressed: _deleteSelectedUser,
                  ),
                ),
              ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Quản lý người dùng',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SortButton(),
                ListGridButton(
                  isGridView: _isGridView,
                  onToggleView: (isGrid) {
                    setState(() {
                      _isGridView = isGrid;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  _allUsers.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : _isGridView
                      ? GridViewCustom(
                        items: _allUsers,
                        itemBuilder:
                            (user) => UserCard(
                              name: user.fullName,
                              email: user.email,
                              isGridView: _isGridView,
                              isSelected: _selectedUsers.contains(user),
                              onTap: () => _onUserTap(user),
                              onLongPress: () => _onUserLongPress(user),
                            ),
                      )
                      : ListViewCustom<UserModel>(
                        items: _allUsers,
                        itemBuilder:
                            (user) => UserCard(
                              name: user.fullName,
                              email: user.email,
                              imageUrl: user.linkImage,
                              isSelected: _selectedUsers.contains(user),
                              onTap: () => _onUserTap(user),
                              onLongPress: () => _onUserLongPress(user),
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
