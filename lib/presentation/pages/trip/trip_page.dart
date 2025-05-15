import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/header_section.dart';
import 'package:triptery/presentation/widgets/trip_page/trip_body.dart';


class TripPage extends StatefulWidget {

  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children : [
                HeaderSection(),
                TripBody(), 
              ]
            )
          )
      ),
    );
  }
}