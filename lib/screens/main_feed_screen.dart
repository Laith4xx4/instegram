import 'package:flutter/material.dart';
import 'package:instegram/screens/activity_feed_screen.dart';
import 'package:instegram/screens/home.dart';
import 'package:instegram/screens/profile_screen.dart';
import 'package:instegram/screens/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // ListView.builder(
    //   itemCount: 5, // Just for demonstration
    //   itemBuilder: (context, index) {
    //     return const PostCard();
    //   },
    // ),
    const Home(),
    const SearchScreen(),
    Text('add_post'.tr()),
    const ActivityFeedScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("index $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Instagram'),
      //   centerTitle: false,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add_box_outlined),
      //       onPressed: () {
      //         // Handle add post
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.favorite_outline),
      //       onPressed: () {
      //         // Handle likes
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.send_outlined),
      //       onPressed: () {
      //         // Handle messages
      //       },
      //     ),
      //   ],
      // ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr()),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'add'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'likes'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'profile'.tr(),
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

// class PostCard extends StatelessWidget {
//   const PostCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: <Widget>[
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundImage: NetworkImage(
//                   'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text('laiht'),
//               const Spacer(),
//               IconButton(
//                 icon: const Icon(Icons.more_vert),
//                 onPressed: () {
//                   // Handle more options
//                 },
//               ),
//             ],
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           height: 400,
//           decoration: BoxDecoration(
//             color: Colors.grey[300], // لون خلفية قبل تحميل الصورة
//             borderRadius: BorderRadius.circular(0), // حواف دائرية
//
//             image: DecorationImage(
//               image: NetworkImage(
//                 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
//               ),
//               fit: BoxFit.cover, // تغطي الصورة كامل المساحة
//             ),
//           ),
//         ),
//         // Image.asset(
//         //   'assets/owl.jpg',
//         //   fit: BoxFit.cover,
//         //   width: double.infinity,
//         //   height: 300,
//         // ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.favorite_outline),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(Icons.comment_outlined),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send_outlined),
//                 onPressed: () {},
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: const Icon(Icons.bookmark_outline),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.0),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               '1,234 likes',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text('username This is a caption for the post.'),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
