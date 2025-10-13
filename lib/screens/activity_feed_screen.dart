import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityFeedScreen extends StatefulWidget {
  const ActivityFeedScreen({super.key});

  @override
  State<ActivityFeedScreen> createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends State<ActivityFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Instagram Likes'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'following'.tr()),
              Tab(text: 'you'.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Following
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'follow_requests'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Add more content for Follow Requests if needed
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'new_activities'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // New activities
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/karennne.jpg',
                        ), // Replace with actual image
                      ),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'karennne',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' liked your photo. '),
                            TextSpan(
                              text: '1h',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      trailing: Image.asset(
                        'assets/1.jpg',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ), // Replace with actual image
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'today_activities'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Today activities
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/kiero_d.jpg',
                        ), // Replace with actual image
                      ),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'kiero_d, zackjohn',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: '26 others',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' liked your photo. '),
                            TextSpan(
                              text: '3h',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      trailing: Image.asset(
                        'assets/2.jpg',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ), // Replace with actual image
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'this_week_activities'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // This Week activities
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/craig_love.jpg',
                        ), // Replace with actual image
                      ),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'craig_love',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' mentioned you in a comment: '),
                            TextSpan(
                              text: '@jacob_u',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(text: ' exactly... '),
                            TextSpan(
                              text: '2d',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        'Reply',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Image.asset(
                        'assets/3.jpg',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ), // Replace with actual image
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/martini_rond.jpg',
                        ), // Replace with actual image
                      ),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'martini_rond',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' started following you. '),
                            TextSpan(
                              text: '3d',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: Text('message'.tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/maxjacobson.jpg',
                        ), // Replace with actual image
                      ),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'maxjacobson',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' started following you. '),
                            TextSpan(
                              text: '3d',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: Text('message'.tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/mis_potter.jpg',
                        ), // Replace with actual image
                      ),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'mis_potter',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' started following you. '),
                            TextSpan(
                              text: '3d',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: Text('follow'.tr()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'this_month_activities'.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // This Month activities (placeholder)
                    Center(child: Text('this_month_content'.tr())),
                  ],
                ),
              ),
            ),
            // Tab 2: You (placeholder for now)
            Center(child: Text('you_content'.tr())),
          ],
        ),
      ),
    );
  }
}
