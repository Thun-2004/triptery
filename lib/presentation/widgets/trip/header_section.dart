import 'package:flutter/material.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/pages/trip/trip_tag_window.dart';
import 'package:triptery/presentation/widgets/auth_screen.dart';
import 'package:triptery/presentation/pages/trip/trip_summary_window.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:lucide_icons_flutter/test_icons.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  void _openBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripSummaryWindow(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      // padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: const Color.fromARGB(255, 198, 198, 198),
      //   image: DecorationImage(
      //     image: NetworkImage('https://i.pinimg.com/736x/2d/ca/05/2dca05788a0be22b9ca554bc9cc1b811.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      // foregroundDecoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Colors.transparent,
      //       Colors.black.withOpacity(0.5),
      //       Colors.black.withOpacity(1),
      //     ],
      //     stops: const [0.5, 0.7, 1.0],
      //   ),
      // ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 198, 198, 198),
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/736x/2d/ca/05/2dca05788a0be22b9ca554bc9cc1b811.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(1),
                ],
                stops: const [0.5, 0.7, 1.0],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // widget.tripController.toggleEditTripInfo();
                                _openBottomModal();
                              },
                            ),

                            SizedBox(width: 8),
                            Icon(Icons.map_rounded),
                            SizedBox(width: 8),
                            Icon(Icons.more_vert),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chilling Beach at Samui',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.mapPin,
                              size: 16,
                              color: Colors.white,
                            ),
                            Text(
                              'Ko Samui, Surat',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ), //first province in the trip
                            const SizedBox(width: 8),
                            // Icon(Icons.info_outline_rounded, weight: 500),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(
                              LucideIcons.calendar,
                              size: 16,
                              color: Colors.white,
                            ),
                            Text(
                              '14 May - 17 May 2025 - 4 days',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  '1.2k',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 8),

                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  '1.2k',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 8),

                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  '1.2k',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            Text(
                              'Couple Trip Cheap budget',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
