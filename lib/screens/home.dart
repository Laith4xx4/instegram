import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: Colors.black, size: 18),
          onPressed: () {},
        ),
        title: Text(
          'Instagram'.tr(),
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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

      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                StoryWidget(
                  imagePath: 'assets/1.jpg',
                  username: 'your_story'.tr(),
                ),
                StoryWidget(
                  imagePath: 'assets/m1.jpg',
                  username: 'leomessi'.tr(),
                  isLive: true,
                ),
                StoryWidget(
                  imagePath: 'assets/c1.jpg',
                  username: 'cristiano'.tr(),
                  // isLive: true,
                ),
                StoryWidget(
                  imagePath: 'assets/b1.jpg',
                  username: 'kieron_d'.tr(),
                ),
                StoryWidget(
                  imagePath: 'assets/b3.jpg',
                  username: 'craig_'.tr(),
                ),
              ],
            ),
          ),
          const Divider(),
          buildPost(
            ['assets/1.jpg', 'assets/2.jpg'],
            'assets/1.jpg',
            'l12_.21l_'.tr(),
            'alhamdulillah'.tr(),
            '1,000',
          ),
          buildPost(
            ['assets/m1.jpg', 'assets/m2.jpg'],
            'assets/m1.jpg',
            'leomessi'.tr(),
            'argentina'.tr(),
            '1,289',
            isVerified: true,
          ),
          buildPost(
            ['assets/c1.jpg', 'assets/c2.jpg'],
            'assets/c1.jpg',
            'cristiano'.tr(),
            'trophy_portugal'.tr(),
            '10,000',
            isVerified: true,
          ),
          buildPost(
            ['assets/b1.jpg', 'assets/b3.jpg'],
            'assets/b2.jpg',
            'bar'.tr(),
            'blue_red_hearts'.tr(),
            '1,000',
            isVerified: true,
          ),
          const Divider(),
        ],
      ),
    );
  }

  /// 👇 دالة بناء البوست
  Widget buildPost(
    List<String> imagePaths,
    String imageP,
    String username,
    String caption,
    String like, {
    bool isVerified = false,
  }) {
    final bool hasMultipleImages = imagePaths.length > 1;
    final PageController pageController = PageController();
    int currentPage = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔸 الجزء العلوي (الصورة الشخصية + الاسم)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 20, backgroundImage: AssetImage(imageP)),
                  const SizedBox(width: 10),
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (isVerified)
                    Image.asset('assets/verified.png', height: 15),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // 🔸 الصور (واحدة أو أكثر)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: hasMultipleImages
                      ? PageView.builder(
                          controller: pageController,
                          itemCount: imagePaths.length,
                          onPageChanged: (index) =>
                              setState(() => currentPage = index),
                          itemBuilder: (context, index) {
                            return Image.asset(
                              imagePaths[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        )
                      : Image.asset(
                          imagePaths[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 450,
                        ),
                ),

                // 🔸 مؤشرات الصور (نقاط صغيرة في الأسفل)
                if (hasMultipleImages)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        imagePaths.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Colors.white
                                : Colors.white54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // 🔸 أزرار التفاعل
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_outline),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_outline),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // 🔸 عدد الإعجابات والنص
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${'$like'.tr()} ${'likes'.tr()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text('${username.tr()}: ${caption.tr()}'),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

class StoryWidget extends StatelessWidget {
  final String imagePath;
  final String username;
  final bool isLive;

  const StoryWidget({
    super.key,
    required this.imagePath,
    required this.username,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CircleAvatar(radius: 35, backgroundImage: AssetImage(imagePath)),
              if (isLive)
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'LIVE'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(username.tr()),
        ],
      ),
    );
  }
}
