import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Helpers & Screens
import 'package:instegram/core/utils/SharedPreferencesHelper.dart';
import 'package:instegram/screens/auth/signup_screen.dart';
import 'package:instegram/screens/main_feed_screen.dart';

/// شاشة تسجيل الدخول
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ================================
  // 🧩 المتغيرات و Controllers
  // ================================
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRememberMe = false;
  bool isLoading = false;
  String? _errorMessage;

  // ================================
  // 🧹 تنظيف الموارد عند إغلاق الشاشة
  // ================================
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ================================
  // 🔐 دالة تسجيل الدخول
  // ================================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    setState(() {
      isLoading = true;
      _errorMessage = null;
    });

    try {
      // إرسال الطلب إلى السيرفر
      final response = await http.post(
        Uri.parse('http://192.168.100.66:5086/api/Auth/login'),
        body: jsonEncode({'Email': email, 'Password': password}),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // ✅ نجاح تسجيل الدخول
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        if (jsonBody is Map<String, dynamic> && jsonBody.containsKey("token")) {
          final String accessToken = jsonBody["token"];

          // حفظ التوكن في SharedPreferences
          await SharedPreferencesHelper.saveString("accessToken", accessToken);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful!'.tr())),
          );

          // الانتقال إلى الصفحة الرئيسية
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainFeedScreen()),
          );
        } else {
          setState(() {
            _errorMessage = 'Login failed: Invalid response format'.tr();
          });
          print('❌ Invalid response format');
        }
      }
      // ❌ فشل تسجيل الدخول
      else {
        setState(() {
          _errorMessage = _parseErrorMessage(response);
        });
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e'.tr();
      });
      print('Error during login: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ================================
  // 🧠 دالة لمعالجة الأخطاء القادمة من السيرفر
  // ================================
  String _parseErrorMessage(http.Response response) {
    try {
      if (response.body.isEmpty) return 'Login failed'.tr();

      final dynamic body = jsonDecode(response.body);

      if (body is Map<String, dynamic>) {
        return body['message'] ??
            body['description'] ??
            'Login failed'.tr();
      } else if (body is String) {
        return body;
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
      print('Error parsing response body: $e');
      return 'Failed to parse server response'.tr();
    }

    return 'Login failed'.tr();
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainFeedScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // تبديل اللغة بين العربية والإنجليزية
              if (context.locale.languageCode == 'ar') {
                context.setLocale(const Locale('en'));
              } else {
                context.setLocale(const Locale('ar'));
              }
            },
          ),
        ],
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            const SizedBox(height: 30),

            // 📧 حقل البريد الإلكتروني
            _buildTextField(
              controller: _emailController,
              hint: 'email_hint'.tr(),
            ),
            const SizedBox(height: 10),

            // رسالة الخطأ
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            // 🔒 حقل كلمة المرور
            _buildTextField(
              controller: _passwordController,
              hint: 'password_hint'.tr(),
              obscureText: true,
            ),
            const SizedBox(height: 10),

            // ✅ خيار التذكّر
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: _isRememberMe,
                  onChanged: (value) {
                    setState(() => _isRememberMe = value ?? false);
                    print('Remember Me: $_isRememberMe');
                  },
                ),
                Text('remember_me'.tr()),
              ],
            ),

            // 🔗 نسيت كلمة المرور
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'forgot_password'.tr(),
                  style: const TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),

            // 🔘 زر تسجيل الدخول
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                  await login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'log_in'.tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔄 تبديل الحساب
            TextButton(
              onPressed: () {},
              child: Text(
                'switch_accounts'.tr(),
                style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
            ),

            const SizedBox(height: 50),
            const Divider(color: Colors.grey, thickness: 1),

            // ✨ الانتقال إلى شاشة التسجيل
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('dont_have_account'.tr()),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'sign_up'.tr(),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
