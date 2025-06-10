import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:triptery/domain/repositories/place_repository_impl.dart';

class HeaderSection extends StatefulWidget {
  final PlaceRepositoryImpl repository;

  const HeaderSection({super.key, required this.repository});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final PageController _controller = PageController();
  final List<String> images = List.generate(
    5,
    (_) => 'assets/images/header_image.png',
  );

  Timer? _autoScrollTimer;

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
    return SizedBox(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🔄 Image carousel
          PageView.builder(
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

          // 🔘 Dot indicator
          Positioned(
            bottom: 118,
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

          // 🏷 Title & Explore Button
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Bangkok, Thailand",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFE8757),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 10,
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    "Explore",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 👤 Bottom user info overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              height: 60,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/user_profile.png',
                    ),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Salmon",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "You're in Bangkok, Thailand",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
