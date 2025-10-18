import 'package:flutter/material.dart';
import 'package:instegram/screens/auth/login_screen.dart';
import 'package:instegram/screens/main_feed_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goTo();
    print("splash screen");
  }

  goTo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final bool? remember = prefs.getBool('isRememberMe');
    print('remember me value is : $remember');
    
    if(remember!) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainFeedScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("splash"),
        centerTitle: true,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),

    );
  }
}
