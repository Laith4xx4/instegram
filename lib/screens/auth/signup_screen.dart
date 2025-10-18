import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import '../main_feed_screen.dart';
import 'login_screen.dart';

/// شاشة إنشاء حساب جديد (Sign Up)
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ================================
  // 🧩 المتغيرات و Controllers
  // ================================
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController =
  TextEditingController(text: 'User'); // الدور الافتراضي هو "User"

  bool _isLoading = false;
  String? _errorMessage;

  // ================================
  // 🧹 تنظيف الموارد عند إغلاق الشاشة
  // ================================
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  // ================================
  // 🧠 دالة تسجيل مستخدم جديد
  // ================================
  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final role = _roleController.text.trim().isEmpty
        ? 'User'
        : _roleController.text.trim();

    // التحقق من أن الحقول ليست فارغة
    if (email.isEmpty || password.isEmpty || role.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields'.tr();
        _isLoading = false;
      });
      return;
    }

    try {
      // إرسال طلب التسجيل إلى الخادم
      final response = await http.post(
        Uri.parse('http://192.168.100.66:5086/api/Auth/register'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'Email': email,
          'Password': password,
          'Role': role,
        }),
      );
      print('Response Code: ${response.statusCode}');
      // ✅ النجاح
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!'.tr())),
        );

        // العودة إلى شاشة تسجيل الدخول
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      // ❌ فشل التسجيل
      else {
        setState(() {
          _errorMessage = _parseErrorMessage(response);
        });
        print('Registration failed: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e'.tr();
      });
      print('Error during registration: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ================================
  // 🧩 دالة تحليل رسالة الخطأ القادمة من الخادم
  // ================================
  String _parseErrorMessage(http.Response response) {
    try {
      if (response.body.isEmpty) return 'Registration failed'.tr();

      final dynamic body = jsonDecode(response.body);

      if (body is Map<String, dynamic>) {
        return body['message'] ??
            body['description'] ??
            'Registration failed'.tr();
      } else if (body is List) {
        final errors = body.map((item) {
          if (item is Map<String, dynamic> && item.containsKey('description')) {
            return item['description'] as String;
          } else {
            return item.toString();
          }
        }).join(', ');
        return errors;
      }
    } catch (e) {
      print("Error parsing response body: $e");
      return 'Failed to parse server response'.tr();
    }

    return 'Registration failed'.tr();
  }

  // ================================
  // 🧱 واجهة المستخدم
  // ================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ===== AppBar =====
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png"),
              const SizedBox(height: 30),

              // 📧 البريد الإلكتروني
              _buildTextField(
                controller: _emailController,
                hint: 'email_hint'.tr(),
              ),
              const SizedBox(height: 10),

              // 🔒 كلمة المرور
              _buildTextField(
                controller: _passwordController,
                hint: 'password_hint'.tr(),
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // 🧾 الدور (Role)
              _buildTextField(
                controller: _roleController,
                hint: 'role_hint'.tr(),
              ),
              const SizedBox(height: 15),

              // ⚠️ رسالة الخطأ
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              // 🔘 زر التسجيل
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : signUpUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'sign_up_button'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===== الفاصل =====
              const Divider(color: Colors.grey, thickness: 1),

              // 🔁 الانتقال إلى تسجيل الدخول
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already_have_account'.tr()),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'log_in_button'.tr(),
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================
  // 🧰 دالة مساعدة لبناء حقول الإدخال
  // ================================
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
