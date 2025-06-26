import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/presentation/controllers/plan_review_controller.dart';
import 'package:triptery/presentation/pages/write_review_page.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final PlanReviewController planReviewController =
      Get.find<PlanReviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Obx(
            () => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 36),
                    Text(
                      planReviewController.rating > 0.0
                          ? '${planReviewController.rating.value}'
                          : 'No reviews yet',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "based on ${planReviewController.planReview.isNotEmpty ? planReviewController.planReview.length : 0} reviews",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Review List
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: planReviewController.planReview.length,
                separatorBuilder: (_, __) => const Divider(height: 20),
                itemBuilder: (context, index) {
                  final review = planReviewController.planReview[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  review.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _timeAgo(review.createdAt),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                ...List.generate(
                                  review.rating.round(),
                                  (_) => const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  review.rating.toStringAsFixed(1), // shows number like 4.0, 4.5
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ]
                            ),
                            const SizedBox(height: 4),
                            Text(review.description),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // Write a review button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WriteReviewPage()),
                  );
                },
                child: const Text(
                  "Write a review",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(int dateTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateTime);
    final duration = DateTime.now().difference(date);
    if (duration.inDays > 0) return "${duration.inDays} days ago";
    if (duration.inHours > 0) return "${duration.inHours} hours ago";
    return "${duration.inMinutes} mins ago";
  }
}
