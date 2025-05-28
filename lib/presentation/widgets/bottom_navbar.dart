import 'package:flutter/material.dart';
import '../pages/search_page.dart';
import '../../domain/repositories/place_repository_impl.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xff1c1c27),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      currentIndex: 0,
      onTap: (index) {
        if (index == 2) {
          // Search icon index
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => SearchPage(repository: PlaceRepositoryImpl()),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}
