import 'package:flutter/material.dart';
import '../../domain/entities/place/place.dart';
import '../../domain/entities/place/place_review_group.dart';
import '../../domain/usecases/get_review_groups_by_place_id.dart';
import '../../domain/repositories/place_repository_impl.dart';
import '../widgets/place_detail_page/place_header_section.dart';
import '../widgets/place_detail_page/place_dont_miss_section.dart';
import '../widgets/place_detail_page/place_description_section.dart';
import '../widgets/place_detail_page/place_review_section.dart';
import '../widgets/place_detail_page/place_contact_section.dart';
import '../widgets/dash_divider.dart';

class PlaceDetailPage extends StatefulWidget {
  final Place place;

  const PlaceDetailPage({super.key, required this.place});

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  List<PlaceReviewGroup> reviewGroups = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReviewGroups();
  }

  Future<void> _loadReviewGroups() async {
    final repo = PlaceRepositoryImpl();
    final groups = await GetPlaceReviewGroupsByPlaceId(
      repo,
    ).execute(widget.place.id);

    setState(() {
      reviewGroups = groups;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlaceHeaderSection(place: widget.place),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PlaceDontMissSection(),
                  const SizedBox(height: 28),
                  PlaceDescriptionSection(
                    description: widget.place.description,
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    "Reviews",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const DashedDivider(),
                  const SizedBox(height: 12),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PlaceReviewSection(reviewGroups: reviewGroups),
                  const DashedDivider(),
                  const SizedBox(height: 28),
                  const PlaceContactSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
