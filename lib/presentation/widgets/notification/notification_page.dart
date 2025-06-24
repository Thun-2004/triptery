import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final String response = await rootBundle.loadString(
      'lib/data/mock/notification_mock.json',
    );
    final List<dynamic> data = json.decode(response);
    setState(() {
      notifications = data;
      isLoading = false;
    });
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()}w ago';
    } else {
      return '${(diff.inDays / 30).floor()}mo ago';
    }
  }

  // Placeholder for getImageByTripId
  String getImageByTripId(String? tripId) {
    // TODO: Implement real logic
    return 'assets/images/salmonjuseyo.png';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final now = DateTime.now();
    List<Map<String, dynamic>> today = [];
    List<Map<String, dynamic>> lastWeek = [];
    List<Map<String, dynamic>> lastMonth = [];

    for (var n in notifications) {
      final createdAt = DateTime.parse(n['createdAt']);
      final diff = now.difference(createdAt);
      if (diff.inDays < 1) {
        today.add(n);
      } else if (diff.inDays < 7) {
        lastWeek.add(n);
      } else if (diff.inDays < 30) {
        lastMonth.add(n);
      }
    }

    List<Widget> notificationWidgets = [];
    if (today.isNotEmpty) {
      notificationWidgets.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Today',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
      notificationWidgets.addAll(
        today.map(
          (n) => NotificationCard(
            userName: n['userName'],
            userProfilePictureUrl: n['userProfilePictureUrl'],
            tripName: '', // You can add trip name if available
            tripImageUrl: getImageByTripId(n['tripId']),
            createdAt: DateTime.parse(n['createdAt']),
            timeAgo: timeAgo(DateTime.parse(n['createdAt'])),
            type: n['notificationType'], // 🔥 Map notification type here
            seen: n['seen'],
          ),
        ),
      );
    }

    if (lastWeek.isNotEmpty) {
      notificationWidgets.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Last 7 days',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
      notificationWidgets.addAll(
        lastWeek.map(
          (n) => NotificationCard(
            userName: n['userName'],
            userProfilePictureUrl: n['userProfilePictureUrl'],
            tripName: '',
            tripImageUrl: getImageByTripId(n['tripId']),
            createdAt: DateTime.parse(n['createdAt']),
            timeAgo: timeAgo(DateTime.parse(n['createdAt'])),
            type: n['notificationType'], // 🔥 Map notification type here
            seen: n['seen'],
          ),
        ),
      );
    }

    if (lastMonth.isNotEmpty) {
      notificationWidgets.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Last 30 days',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
      notificationWidgets.addAll(
        lastMonth.map(
          (n) => NotificationCard(
            userName: n['userName'],
            userProfilePictureUrl: n['userProfilePictureUrl'],
            tripName: '',
            tripImageUrl: getImageByTripId(n['tripId']),
            createdAt: DateTime.parse(n['createdAt']),
            timeAgo: timeAgo(DateTime.parse(n['createdAt'])),
            type: n['notificationType'], // 🔥 Map notification type here
            seen: n['seen'],
          ),
        ),
      );
    }

    if (notificationWidgets.isEmpty) {
      notificationWidgets.add(const Center(child: Text('No notifications.')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...notificationWidgets,
          const SizedBox(height: 24),
          const Center(
            child: Text(
              "That's all your notifications from last 30 days",
              style: TextStyle(color: Colors.black38, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
