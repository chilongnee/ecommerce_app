import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:ecommerce_app/core/routes.dart';
import 'package:ecommerce_app/core/utils/notification_utils.dart';
import 'package:ecommerce_app/data/controller/address_controller.dart';
import 'package:ecommerce_app/data/controller/auth_controller.dart';
import 'package:ecommerce_app/data/controller/user_controller.dart';
import 'package:ecommerce_app/data/models/user_model.dart';
import 'package:ecommerce_app/presentation/widgets/button/custom_button.dart';
import 'package:ecommerce_app/presentation/widgets/container/header_container.dart';
import 'package:ecommerce_app/presentation/widgets/input/custom_search_input.dart';
import 'package:ecommerce_app/presentation/widgets/input/custom_input_field.dart';
import 'package:ecommerce_app/presentation/widgets/notification/notification_banner.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();
  final UserController _userController = UserController();
  final AddressAPIController _addressAPIController = AddressAPIController();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();

  final _fullNameController = TextEditingController();
  final FocusNode _focusNodeFullName = FocusNode();

  final _addressController = TextEditingController();
  final FocusNode _focusNodeAddress = FocusNode();

  final _passwordController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();

  final _cfpasswordController = TextEditingController();
  final FocusNode _focusNodeCfPassword = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextCFPassword = true;
  bool _isSigningUp = false;

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodeFullName.dispose();
    _focusNodeAddress.dispose();
    _focusNodePassword.dispose();
    _focusNodeCfPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              HeaderContainer(
                headerColor: AppColors.secondary,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Bạn đã có tài khoản?",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          CustomButton(
                            text: "Đăng nhập",
                            backgroundColor: const Color(0xFF7AE582),
                            textColor: Colors.white,
                            fontSize: 12,
                            height: 32,
                            width: 110,
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: EdgeInsets.all(18),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'HA SHOP',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Text(
                                'Tạo tài khoản để mua sắm',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputField(
                              controller: _emailController,
                              focusNode: _focusNodeEmail,
                              hintText: 'Nhập Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodeFullName);
                              },
                              validator: (String? value) {
                                final RegExp emailRegExp = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                );
                                if (!emailRegExp.hasMatch(value ?? '')) {
                                  _focusNodeEmail.requestFocus();
                                  return 'Email không hợp lệ';
                                }
                                return null;
                              },
                            ),
                            InputField(
                              controller: _fullNameController,
                              focusNode: _focusNodeFullName,
                              hintText: "Họ tên",
                              icon: Icons.person,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodeAddress);
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  _focusNodeFullName.requestFocus();
                                  return 'Vui lòng nhập họ tên';
                                } else if (value.trim().length < 2) {
                                  _focusNodeFullName.requestFocus();
                                  return 'Họ tên quá ngắn';
                                }
                                return null;
                              },
                            ),

                            CustomSearchInput(
                              controller: _addressController,
                              hintText: 'Địa chỉ',
                              icon: Icons.location_city,
                              getSuggestions: getAddressSuggestions,
                            ),

                            InputField(
                              controller: _passwordController,
                              focusNode: _focusNodePassword,
                              hintText: 'Mật khẩu',
                              icon: Icons.lock,
                              obscureText: _obscureTextPassword,
                              isPassword: true,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodeCfPassword);
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextPassword =
                                        !_obscureTextPassword;
                                  });
                                },
                              ),
                              validator: (String? value) {
                                if (value == null || value.length < 6) {
                                  _focusNodePassword.requestFocus();
                                  return "Password should have at least 6 characters";
                                }
                                return null;
                              },
                            ),

                            InputField(
                              controller: _cfpasswordController,
                              focusNode: _focusNodeCfPassword,
                              hintText: 'Nhập lại mật khẩu',
                              icon: Icons.lock,
                              obscureText: _obscureTextCFPassword,
                              isPassword: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextCFPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextCFPassword =
                                        !_obscureTextCFPassword;
                                  });
                                },
                              ),
                              validator: (String? value) {
                                if (value == null || value.length < 6) {
                                  _focusNodeCfPassword.requestFocus();
                                  return "Password should have at least 6 characters";
                                } else if (value != _passwordController.text) {
                                  _focusNodeCfPassword.requestFocus();
                                  return "Confirm password does not match";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: 'Đăng ký',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _register();
                                }
                              },
                              isLoading: _isSigningUp,
                              padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                bottom: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm đăng ký
  void _register() async {
    String email = _emailController.text;
    String fullName = _fullNameController.text;
    String address = _addressController.text;
    String password = _passwordController.text;

    // Gọi phương thức đăng ký
    final result = await _authController.register(email, password);

    if (result.success) {
      UserModel user = UserModel(
        id: result.data!.uid,
        email: email,
        fullName: fullName,
        address: address,
      );
      await _userController.createUser(user);

      Navigator.pushNamed(context, AppRoutes.login, arguments: result.message);
    } else {
      showNotificationBanner(
        context,
        result.message ?? 'Đăng ký thất bại',
        type: NotificationType.error,
      );
    }
  }

  // Hàm gọi địa chỉ
  Future<List<String>> getAddressSuggestions(String query) async {
    final List<String> addresses = await _addressAPIController.getData(query);
    return addresses;
  }
}
