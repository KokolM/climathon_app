import 'package:flutter/material.dart';

class ClimathonLabels {
  static const String roads = 'road and pavements';
  static const String fire = 'fire hazards';
  static const String garbage = 'garbage management';
  static const String floods = 'floods in city';

  static const IconData roadsIcon = Icons.tram_sharp;
  static const IconData fireIcon = Icons.fire_hydrant_alt;
  static const IconData garbageIcon = Icons.delete;
  static const IconData floodsIcon = Icons.water_drop_rounded;

  static const Map<String, IconData> labelIcons = {
    roads: roadsIcon,
    fire: fireIcon,
    garbage: garbageIcon,
    floods: floodsIcon,
  };
}

class ClimathonDataModel {
  final String label;
  final String description;
  final DateTime created;
  final double lat;
  final double lon;
  final bool status;

  ClimathonDataModel(
    this.label,
    this.description,
    this.created,
    this.lat,
    this.lon,
    this.status,
  );
}
