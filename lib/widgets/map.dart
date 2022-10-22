// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class ClimathonMap extends StatelessWidget {
//   final List<Widget>? children;
//
//   const ClimathonMap({
//     Key? key,
//     this.children,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap(
//       options: MapOptions(
//         center: LatLng(48.14910422668625, 17.107678140831858),
//         zoom: 13,
//         maxZoom: 18.45,
//       ),
//       nonRotatedChildren: [
//         AttributionWidget.defaultWidget(
//           source: 'OpenStreetMap contributors',
//           onSourceTapped: null,
//         ),
//       ],
//       children: [
//         TileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           userAgentPackageName: 'com.example.app',
//         ),
//         if (children != null) ...children!,
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';
//
// class ClimathonMap extends StatelessWidget {
//   final List<Widget>? children;
//
//   const ClimathonMap({
//     Key? key,
//     this.children,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SfMaps(
//       layers: [
//         MapTileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           // initialZoomLevel: 15,
//           // initialFocalLatLng: const MapLatLng(48.14910422668625, 17.107678140831858),
//           zoomPanBehavior: MapZoomPanBehavior(
//             zoomLevel: 15,
//             minZoomLevel: 5,
//             maxZoomLevel: 19,
//             focalLatLng: const MapLatLng(48.14910422668625, 17.107678140831858),
//             enableMouseWheelZooming: true,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ClimathonMap extends StatefulWidget {
  final List<MapSublayer>? subLayers;

  const ClimathonMap({
    Key? key,
    this.subLayers,
  }) : super(key: key);

  @override
  State<ClimathonMap> createState() => _ClimathonMapState();
}

class _ClimathonMapState extends State<ClimathonMap> {
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(48.14910422668625, 17.107678140831858),
      enableMouseWheelZooming: true,
      maxZoomLevel: 19,
      zoomLevel: 11,
      minZoomLevel: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
          // urlTemplate: 'https://a.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}@2x.png',
          urlTemplate: 'https://a.basemaps.cartocdn.com/rastertiles/voyager_labels_under/{z}/{x}/{y}@2x.png',
          zoomPanBehavior: _zoomPanBehavior,
          sublayers: widget.subLayers,
        ),
      ],
    );
  }
}
