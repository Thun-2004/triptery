import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/widgets/trip/header_section.dart';
import 'package:triptery/presentation/widgets/trip/trip_body.dart';
import 'package:get/get.dart';
import 'package:triptery/utils/ui.dart' show NoBounceScrollBehavior;

enum Mode { normal, edit }

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  Mode mode = Mode.normal;
  final tripController = Get.find<TripController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, //elimiate top margin
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [HeaderSection(), TripBody()],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() => tripController.toggleEditPlaceOrder()),
      //   child: const Icon(Icons.edit),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => tripController.toggleEditPlaceOrder()),
        elevation: 4,
        shape: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFEB755), // Light orange
                const Color(0xFFFE7D57), // Darker orange
              ],
            ),
          ),
          child:  Icon(
              LucideIcons.pencilLine,
              color: Colors.white,
              size: 28,
            ),
        ),
      ),
    );
  }
}
