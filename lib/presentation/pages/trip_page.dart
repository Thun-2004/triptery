import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/pages/edit_route_page.dart';
import 'package:triptery/presentation/widgets/trip/header_section.dart';
import 'package:triptery/presentation/widgets/trip/trip_body.dart';
import 'package:triptery/presentation/widgets/trip/components/map.dart';
import 'package:get/get.dart';

enum Mode { normal, edit }

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  bool showMap = false;
  Mode mode = Mode.normal;

  void toggleMap() {
    setState(() {
      showMap = !showMap;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, //elimiate top margin
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderSection(toggleMap: toggleMap),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: showMap ? 550 : 0,
                curve: Curves.easeInOut,
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: showMap ? 1.0 : 0.0,
                    child: const Map(),
                  ),
                ),
              ),
              TripBody(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        // onPressed: () => setState(() => tripController.toggleEditPlaceOrder()),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditRoutePage()),
          );
        },

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
          child: Icon(LucideIcons.pencilLine, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
