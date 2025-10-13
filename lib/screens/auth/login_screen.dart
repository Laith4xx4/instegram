import 'package:flutter/material.dart';
import 'package:instegram/screens/auth/signup_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:instegram/screens/main_feed_screen.dart';
import 'package:instegram/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberMe = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
           Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => (MainFeedScreen())),
      );
          },
        ),
        toolbarHeight: 30, // Further reduced AppBar height
        actions: [
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == 'ar') {
                context.setLocale(Locale('en'));
              } else {
                context.setLocale(Locale('ar'));
              }
            },
            icon: Icon(Icons.language),
          ), // IconButton
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Spacer(), // Removed Spacer due to height adjustments
                // Text(
                //   'Instagram',
                //   style: TextStyle(
                //     fontFamily: 'Billabong',
                //     fontSize: 50,
                //     color: Colors.black,
                //   ),
                Image.asset("assets/logo.png"),

                SizedBox(height: 30), // Adjusted height
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'username_hint'.tr(),
                    contentPadding: EdgeInsets.all(10),
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
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.grey.shade50,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'password_hint'.tr(),
                    contentPadding: EdgeInsets.all(10),
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
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.grey.shade50,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: _isRememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _isRememberMe = value!;
                          print(_isRememberMe);
                        });
                      },
                    ),
                    Text('remember_me'.tr()),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 10.0,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'forgot_password'.tr(),
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Adjusted height
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      print("Username is: ${_usernameController.text}");
                      print("Password is: ${_passwordController.text}");
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isRememberMe', _isRememberMe);
                      final bool? remember = prefs.getBool('isRememberMe');
                      print("remember me value is : $remember");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'log_in'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 15), // Adjusted height
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'switch_accounts'.tr(),
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
                SizedBox(height: 50), // Adjusted height
                Divider(color: Colors.grey, thickness: 1),
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
                          style: TextStyle(
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
      ),
      // ),
    );
  }
}
