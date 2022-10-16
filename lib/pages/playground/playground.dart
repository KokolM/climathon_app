// import 'package:climathon_admin/widgets/map.dart';
// import 'package:climathon_admin/widgets/menu.dart';
// import 'package:climathon_admin/pages/app.dart';
// import 'package:climathon_admin/widgets/popup.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class ClimathonPlaygroundPage extends StatelessWidget {
//   const ClimathonPlaygroundPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClimathonMap(
//       children: [
//         CircleLayer(
//           circles: [
//             CircleMarker(
//                 point: LatLng(48.14910422668625, 17.107678140831858),
//                 radius: 240,
//                 useRadiusInMeter: true,
//                 color: Colors.red.withOpacity(0.4)),
//           ],
//         ),
//         MarkerLayer(
//           markers: [
//             Marker(
//               point: LatLng(48.14910422668625, 17.107678140831858),
//               width: 80,
//               height: 80,
//               builder: (context) => const ClimathonPopup(
//                 child: FlutterLogo(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:climathon_admin/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ClimathonPlaygroundPage extends StatelessWidget {
  const ClimathonPlaygroundPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClimathonMap(
      subLayers: [
      ],
    );
  }
}

