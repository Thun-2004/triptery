import 'package:flutter/cupertino.dart';
// import your auth and pages
// import 'package:your_app/login_page.dart';
// import 'package:your_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'triptery',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 16,
            color: CupertinoColors.black,
          ),
          actionTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.activeBlue,
          ),
          navTitleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.black,
          ),
        ),
      ),
      home: isAuthenticated() ? const HomePage() : const LoginPage(),
    );
  }
}