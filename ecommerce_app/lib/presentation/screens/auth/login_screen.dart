import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:ecommerce_app/core/routes.dart';
import 'package:ecommerce_app/core/utils/notification_utils.dart';
import 'package:ecommerce_app/data/controller/auth_controller.dart';
import 'package:ecommerce_app/presentation/widgets/button/custom_button.dart';
import 'package:ecommerce_app/presentation/widgets/container/header_container.dart';
import 'package:ecommerce_app/presentation/widgets/input/custom_input_field.dart';
import 'package:ecommerce_app/presentation/widgets/notification/notification_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();

  final _passwordController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;
  bool _isSigning = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final message = ModalRoute.of(context)?.settings.arguments as String?;
    if (message != null && message.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNotificationBanner(
          context,
          message,
          type: NotificationType.success,
        );
      });
    }
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
                            "Bạn chưa có tài khoản?",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          CustomButton(
                            text: "Đăng ký",
                            backgroundColor: const Color(0xFF7AE582),
                            textColor: Colors.white,
                            fontSize: 12,
                            height: 32,
                            width: 100,
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.register);
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
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 5),

                      const Text(
                        'HA SHOP',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const Text(
                        'Mua sắm - Giá tốt - Mỗi ngày',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 10),
                      // Form đăng nhập
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // EMAIL
                            InputField(
                              controller: _emailController,
                              focusNode: _focusNodeEmail,
                              hintText: 'Nhập email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodePassword);
                              },
                              validator: (value) {
                                final RegExp emailRegExp = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                );
                                if (!emailRegExp.hasMatch(value ?? '')) {
                                  _focusNodeEmail.requestFocus();
                                  return 'Email không hợp lệ!';
                                }
                                return null;
                              },
                            ),

                            // MẬT KHẨU
                            InputField(
                              controller: _passwordController,
                              focusNode: _focusNodePassword,
                              hintText: "Nhập mật khẩu",
                              icon: Icons.lock,
                              isPassword: true,
                              obscureText: _obscureTextPassword,
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
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  _focusNodePassword.requestFocus();
                                  return "Mật khẩu phải có ít nhất 6 ký tự!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: "Đăng nhập",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                              isLoading: _isSigning,
                              padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                bottom: 24.0,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 24.0,
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Bạn quên mật khẩu?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 40.0,
                                right: 40.0,
                                top: 24,
                                bottom: 24,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Text(
                                      'Đăng nhập với',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlutterSocialButton(
                                  onTap: () {},
                                  buttonType: ButtonType.facebook,
                                  mini: true,
                                  iconSize: 15,
                                ),
                                const SizedBox(width: 12),
                                FlutterSocialButton(
                                  onTap: () {},
                                  buttonType: ButtonType.google,
                                  mini: true,
                                  iconSize: 15,
                                ),
                                const SizedBox(width: 12),
                                FlutterSocialButton(
                                  onTap: () {},
                                  buttonType: ButtonType.linkedin,
                                  mini: true,
                                  iconSize: 15,
                                ),
                              ],
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

  // Hàm đăng nhập
  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if(email == 'admin@gmail.com' && password == 'admin123') {
      Navigator.pushNamed(context, AppRoutes.adminDashboard);
    }

    // Check tài khoản có tồn tại hay không
    bool exists = await _authController.checkAccountExists(email);
    if (!exists) {
      showNotificationBanner(
        context,
        'Tài khoản không tồn tại. Vui lòng kiểm tra lại email!',
        type: NotificationType.error,
      );
      return;
    }

    // Gọi phương thức đăng nhập
    final result = await _authController.login(email, password);

    // Kiểm tra đăng nhập thành công hay không
    if (result.success) {
      Navigator.pushNamed(context, AppRoutes.dashboard);
    } else {
      showNotificationBanner(
        context,
        result.message ?? 'Đăng nhập thất bại',
        type: NotificationType.error,
      );
    }
  }
}
