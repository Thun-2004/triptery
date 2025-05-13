import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/home_page/header_section.dart';
import '../widgets/home_page/horizontal_card_list.dart';

//Mock data
import '../../data/mock/mock_tours.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),

              HorizontalCardList(
                title: 'Top Bangkok tours',
                cards: topBangkokTours,
              ),

              HorizontalCardList(
                title: 'Popular things to do in Thailand',
                cards: popularActivities,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
