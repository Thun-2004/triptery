import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceDontMissSection extends StatefulWidget {
  const PlaceDontMissSection({super.key});

  @override
  State<PlaceDontMissSection> createState() => _PlaceDontMissSectionState();
}

class _PlaceDontMissSectionState extends State<PlaceDontMissSection> {
  final PageController _controller = PageController();
  final List<String> images = List.generate(
    5,
    (_) => 'assets/images/salmonjuseyo.png',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Don't miss",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      images[index],
                      width: 368,
                      height: 184,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: images.length,
                    effect: WormEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      spacing: 6,
                      dotColor: Colors.white.withOpacity(0.3),
                      activeDotColor: const Color(0xFFFE8C56),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE7D57),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text(
              "Select activities",
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
        ),
      ],
    );
  }
}
