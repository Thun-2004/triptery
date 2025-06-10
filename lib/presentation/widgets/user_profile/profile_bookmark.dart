import 'package:flutter/material.dart';
import '../../../domain/entities/place/place.dart';
import '../../../domain/entities/plan/plans.dart';
import '../../../domain/usecases/get_top_places.dart';
import '../../../domain/usecases/get_top_plans.dart';
import '../home_page/horizontal_card_list.dart';

class ProfileBookmark extends StatefulWidget {
  const ProfileBookmark({super.key});

  @override
  State<ProfileBookmark> createState() => _ProfileBookmarkState();
}

class _ProfileBookmarkState extends State<ProfileBookmark> {
  List<Place> topPlaces = [];
  List<Plan> topPlans = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final places = await GetTopPlacesByRating(limit: 5).execute();
    final plans = await GetTopPlans(limit: 5).execute();
    setState(() {
      topPlaces = places;
      topPlans = plans;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          HorizontalCardList(
            title: 'Trip Plan',
            cards: topPlaces,
            actionLabel: 'See All',
            onActionTap: () {
              // TODO: Navigate to full trip plan list
            },
          ),
          HorizontalCardList(
            title: 'Place',
            cards: topPlaces,
            actionLabel: 'See All',
            onActionTap: () {
              // TODO: Navigate to full place list
            },
          ),
        ],
      ),
    );
  }
}
