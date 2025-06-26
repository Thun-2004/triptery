import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';
import 'package:triptery/presentation/controllers/plan_review_controller.dart';

class WriteReviewPage extends StatefulWidget {
  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  final PlanReviewController planReviewController = Get.find<PlanReviewController>();
  final int maxChars = 500;
  String? reviewText;
  int rating = 0;
  
  Widget buildStar(int index) {
    return GestureDetector(
      onTap: () => setState(() => rating = index),
      child: Icon(
        Icons.star,
        color: index <= rating ? Colors.orange : Colors.grey[300],
        size: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Write a review",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 80),
            child: ListView(
              children: [
                // Trip Info Box
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://i.pinimg.com/736x/e3/cc/52/e3cc52244f9b6810a0321b35fe249fbf.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Eat & Trip in Osaka",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Osaka, Japan",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Star Rating
                const Center(
                  child: Text(
                    "How was the trip?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => buildStar(i + 1)),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    rating == 0
                        ? "Rate the trip"
                        : rating == 1
                        ? "Poor"
                        : rating == 2
                        ? "Fair"
                        : rating == 3
                        ? "Good"
                        : rating == 4
                        ? "Great"
                        : "Excellent",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                const SizedBox(height: 20),

                // Detail Review
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Detailed review ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "(Optional)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _reviewController,
                  maxLength: maxChars,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        "Let other know about your experiences with this trip",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    counterText: "${_reviewController.text.length}/$maxChars",
                  ),
                  onChanged: (_) => setState(() {
                    reviewText = _reviewController.text;
                  }),
                ),
              ],
            ),
          ),

          // Review Button
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                //FIXME: Add validation for rating and reviewText and change this to dynamic data later
                PlanReview newReview = PlanReview(
                  id: "1",
                  userId: "1",
                  username: "Levi",
                  userProfilePictureUrl: "assets/images/user.jpg",
                  planId: "1",
                  rating: rating,
                  description: reviewText ?? "",
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                );
                planReviewController.addPlanReview(1, newReview);
                Navigator.pop(context); 
              },
              child: const Text(
                "Review",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
