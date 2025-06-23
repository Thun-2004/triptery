

import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/transport_modes.dart';

IconData getIconForMode(TransportMode mode) {
  switch (mode) {
    case TransportMode.bus:
      return LucideIcons.busFront;
    case TransportMode.train:
      return LucideIcons.tramFront;
    case TransportMode.car:
      return LucideIcons.carFront;
    case TransportMode.carRent:
      return LucideIcons.car;
    case TransportMode.taxi:
      return LucideIcons.carTaxiFront;
    case TransportMode.skyTrain:
      return LucideIcons.trainFront;
    case TransportMode.subway:
      return LucideIcons.trainFrontTunnel;
    case TransportMode.boat:
      return LucideIcons.ship;
    case TransportMode.airplane:
      return LucideIcons.plane;
    default:
      return LucideIcons.footprints;
  }
}

String getTransportModeName(TransportMode mode) {
  switch (mode) {
    case TransportMode.bus:
      return 'Bus';
    case TransportMode.train:
      return 'Train';
    case TransportMode.car:
      return 'Car';
    case TransportMode.carRent:
      return 'Car Rent';
    case TransportMode.taxi:
      return 'Taxi';
    case TransportMode.skyTrain:
      return 'Sky Train';
    case TransportMode.subway:
      return 'Subway';
    case TransportMode.boat:
      return 'Boat';
    case TransportMode.airplane:
      return 'Airplane';
    case TransportMode.walk:
      return 'Walk';
    default:
      return 'Select Transport';
  }
}

TransportMode getTransportModeFromName(String name) {
  switch (name) {
    case 'Bus':
      return TransportMode.bus;
    case 'Train':
      return TransportMode.train;
    case 'Car':
      return TransportMode.car;
    case 'Car Rent':
      return TransportMode.carRent;
    case 'Taxi':
      return TransportMode.taxi;
    case 'Sky Train':
      return TransportMode.skyTrain;
    case 'Subway':
      return TransportMode.subway;
    case 'Boat':
      return TransportMode.boat;
    case 'Airplane':
      return TransportMode.airplane;
    case 'Walk':
      return TransportMode.walk;
    default:
      return TransportMode.subway;
  }
}