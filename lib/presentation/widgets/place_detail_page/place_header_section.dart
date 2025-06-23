import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../domain/entities/place/place.dart';

class PlaceHeaderSection extends StatefulWidget {
  final Place place;

  const PlaceHeaderSection({super.key, required this.place});

  @override
  State<PlaceHeaderSection> createState() => _PlaceHeaderSectionState();
}

class _PlaceHeaderSectionState extends State<PlaceHeaderSection> {
  final PageController _controller = PageController();
  Timer? _autoScrollTimer;
  final List<String> images = List.generate(
    5,
    (_) => 'assets/images/salmonjuseyo.png',
  );

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final nextPage = (_controller.page?.round() ?? 0) + 1;
      _controller.animateToPage(
        nextPage % images.length,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(images[index], fit: BoxFit.cover),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0x4425283C),
                            Color(0xFF25283C),
                          ],
                          stops: [0, 0.4, 0.7],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          bottom: 100,
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
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          right: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.place.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${widget.place.address}, ${widget.place.city}',
                      style: const TextStyle(
                        color: Color(0xffffa000),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.place.rating} ',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '(${widget.place.totalUserRatings})',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: 20,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Color(0xffFF7043),
            radius: 22,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
