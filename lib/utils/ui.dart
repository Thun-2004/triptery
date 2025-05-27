
import 'package:flutter/material.dart';

class NoBounceScrollBehavior extends ScrollBehavior {
  
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}