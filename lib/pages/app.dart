import 'dart:async';
import 'package:climathon_admin/extensions/string.dart';
import 'package:climathon_admin/models/data.dart';
import 'package:climathon_admin/pages/situation_map/situation_map.dart';
import 'package:climathon_admin/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClimathonApp extends StatefulWidget {
  const ClimathonApp({
    Key? key,
  }) : super(key: key);

  @override
  State<ClimathonApp> createState() => _ClimathonAppState();
}

class _ClimathonAppState extends State<ClimathonApp> with TickerProviderStateMixin {
  late TabController _tabController;
  late Timer _timer;

  static const _duration = Duration(seconds: 5);

  _updateData() {
    _timer = Timer.periodic(_duration, (timer) {
      context.read<ClimathonDataProvider>().loadData();
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _updateData();
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wallie Dashboard'),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              const Tab(
                icon: Icon(Icons.all_inclusive),
                text: 'All',
              ),
              Tab(
                icon: const Icon(ClimathonLabels.roadsIcon),
                text: ClimathonLabels.roads.capitalize,
              ),
              Tab(
                icon: const Icon(ClimathonLabels.fireIcon),
                text: ClimathonLabels.fire.capitalize,
              ),
              Tab(
                icon: const Icon(ClimathonLabels.garbageIcon),
                text: ClimathonLabels.garbage.capitalize,
              ),
              Tab(
                icon: const Icon(ClimathonLabels.floodsIcon),
                text: ClimathonLabels.floods.capitalize,
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            ClimathonSituationMapPage(),
            ClimathonSituationMapPage(label: ClimathonLabels.roads),
            ClimathonSituationMapPage(label: ClimathonLabels.fire),
            ClimathonSituationMapPage(label: ClimathonLabels.garbage),
            ClimathonSituationMapPage(label: ClimathonLabels.floods),
          ],
        ),
      ),
    );
  }
}
