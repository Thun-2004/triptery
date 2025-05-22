import 'package:flutter/material.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/widgets/trip_page/header_section.dart';
import 'package:triptery/presentation/widgets/trip_page/trip_body.dart';
import 'package:get/get.dart';

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
        child: 
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children : [
                HeaderSection(
                  tripController: tripController
                ),
                TripBody(), 
                
              ]
            )
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => mode = Mode.edit),
        child: const Icon(Icons.edit),
      ),
    );
  }
}