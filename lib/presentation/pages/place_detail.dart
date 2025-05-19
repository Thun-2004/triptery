import 'package:flutter/material.dart';
import '../../domain/entities/place/place.dart';
import '../../domain/entities/place/place_review_group.dart';
import '../widgets/place_detail_page/place_review_section.dart';
import '../widgets/dash_divider.dart';
import '../../domain/usecases/get_review_groups_by_place_id.dart';
import '../../domain/repositories/place_repository_impl.dart'; // or Mock

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
    final groups = await GetPlaceReviewGroupsByPlaceId(repo).execute(widget.place.id);

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
            // 🔺 Top image with gradient overlay
            Stack(
              children: [
                Image.network(
                  widget.place.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.place.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.place.address}, ${widget.place.city}',
                        style: const TextStyle(
                          color: Color(0xffffa000),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 🔽 Scrollable content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 20),
                      const SizedBox(width: 4),
                      Text('${widget.place.rating}', style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 8),
                      Text('(${widget.place.totalUserRatings} Reviews)', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.place.description,
                    style: const TextStyle(fontSize: 14, height: 2, color: Color(0xff848997)),
                  ),
                  const SizedBox(height: 24),
                  const Text('Review', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const DashedDivider(),

                  isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : PlaceReviewSection(reviewGroups: reviewGroups),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
