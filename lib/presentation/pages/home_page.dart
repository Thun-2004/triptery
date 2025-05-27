import 'package:flutter/material.dart';
import 'package:triptery/domain/repositories/place_repository_impl.dart';
import 'package:triptery/domain/usecases/get_top_plans.dart';
import 'package:triptery/presentation/widgets/home_page/nearby.dart';
import 'package:triptery/presentation/widgets/home_page/plan_horizontal_list.dart';
import 'package:triptery/presentation/widgets/home_page/search_bar.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/home_page/header_section.dart';
import '../widgets/home_page/horizontal_card_list.dart';
import '../../domain/entities/category.dart';
import '../widgets/home_page/categories.dart';

import '../../domain/entities/place/place.dart';
import '../../domain/entities/plan/plans.dart';
import '../../domain/usecases/get_top_places.dart';
import '../../domain/usecases/get_popular_activities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Place> topBangkokTours = [];
  List<Place> popularActivities = [];
  List<Plan> trendingPlan = [];
  bool isLoading = true;
  final List<Category> categories = [
  Category(name: 'Island', imagePath: 'assets/images/island.png'),
  Category(name: 'Hills', imagePath: 'assets/images/hills.png'),
  Category(name: 'Cruise', imagePath: 'assets/images/cruise.png'),
  Category(name: 'Adventure', imagePath: 'assets/images/adventure.png'),
  Category(name: 'Camping', imagePath: 'assets/images/camping.png'),
];


  @override
  void initState() {
    super.initState();
    loadPlaces();
  }

  Future<void> loadPlaces() async {
    final topByRating = await GetTopPlacesByRating(limit: 3).execute();
    final plans = await GetTopPlans(limit: 3).execute();

    setState(() {
      topBangkokTours = topByRating;
      popularActivities = topByRating;
      trendingPlan = plans;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeRepository = PlaceRepositoryImpl();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Header
                          HeaderSection(repository: placeRepository),

                          // 2. Padding to make room under the floating bar
                          const SizedBox(height: 45),

                          Categories(categories: categories),
                          // 3. Rest of page

                          PlanHorizontalList(plans: trendingPlan),
                          HorizontalCardList(
                            title: 'Popular in Bangkok',
                            cards: topBangkokTours,
                          ),
                          HorizontalCardList(
                            title: 'Activities & Experiences',
                            cards: popularActivities,
                          ),

                          NearbyPlans(plans: trendingPlan),
                        ],
                      ),

                      // 🔍 4. Floating Search Bar
                      Positioned(
                        left: 16,
                        right: 16,
                        top:
                            330, // 👈 adjust this to line up visually with header bottom
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CustomSearchBar(repository: placeRepository),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
