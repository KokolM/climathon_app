import 'package:climathon_admin/pages/playground/playground.dart';
import 'package:climathon_admin/pages/situation_map/situation_map.dart';
import 'package:climathon_admin/pages/statistics/statistics.dart';
import 'package:climathon_admin/widgets/menu.dart';
import 'package:flutter/material.dart';

class ClimathonApp extends StatelessWidget {

  const ClimathonApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Climathon app'),
        ),
        body: ClimathonMenu(
          items: [
            ClimathonMenuItem(
              'Map',
              Icons.map,
              const ClimathonSituationMapPage(
                key: ValueKey<int>(0),
              ),
            ),
            ClimathonMenuItem(
              'Statistics',
              Icons.dashboard,
              const ClimathonStatisticsPage(
                key: ValueKey<int>(1),
              ),
            ),
            ClimathonMenuItem(
              'Playground',
              Icons.handyman,
              const ClimathonPlaygroundPage(
                key: ValueKey<int>(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
