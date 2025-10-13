import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:instegram/screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          'l12_.21l_'.tr(),
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined, color: Colors.black, size: 22),
            onPressed: () {},
          ),
          // IconButton(
          //   icon: Icon(Icons.favorite_outline, color: Colors.black, size: 18),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: Icon(Icons.send_outlined, color: Colors.black, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/1.jpg"),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildStatColumn('Posts', 9),
                          _buildStatColumn('Followers', 534),
                          _buildStatColumn('Following', 462),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'l12_.21l_'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: Text('alhamdulillah'.tr()),
                ),
                const SizedBox(height: 20),
                //دخول الى صفحة تسجيل الدخول
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
                      },
                      child: Text('edit_profile'.tr()),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('share_profile'.tr()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: GridView.builder(
              itemCount: 9, // عدد العناصر
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                // قائمة الصور
                List<String> images = [
                  'assets/1.jpg',
                  'assets/2.jpg',
                  'assets/3.jpg',
                  'assets/4.jpg',
                  'assets/5.jpg',
                  'assets/6.jpg',
                  'assets/7.jpg',
                  'assets/8.jpg',
                  'assets/9.jpg',
                ];

                return Image.asset(
                  images[index], // اختر الصورة حسب الـ index
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _buildStatColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label.tr(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
