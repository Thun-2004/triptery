import 'package:flutter/material.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/widgets/auth_screen.dart';
import 'package:triptery/presentation/pages/trip/trip_summary_window.dart'; 


class HeaderSection extends StatefulWidget {
  HeaderSection({ required this.tripController, super.key});
  final TripController tripController;

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
   
  void _openBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripSummaryWindow()
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 198, 198, 198),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                        Icon(Icons.share),
                        SizedBox(width: 8),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [   
                    Text('1-3 May 2025'),
                    Text('One day Trip BKK'),
                    Row(
                      children: [

                        Icon(Icons.remove_red_eye_outlined),
                        Text('1.2k'),
                        const SizedBox(width: 8),

                        Icon(Icons.remove_red_eye_outlined),
                        Text('1.2k'),
                        const SizedBox(width: 8),

                        Icon(Icons.remove_red_eye_outlined),
                        Text('1.2k'),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
