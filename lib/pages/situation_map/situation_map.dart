import 'package:climathon_admin/constants/colors.dart';
import 'package:climathon_admin/pages/situation_map/widgets/data_tooltip.dart';
import 'package:climathon_admin/providers/data.dart';
import 'package:climathon_admin/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ClimathonSituationMapPage extends StatefulWidget {
  const ClimathonSituationMapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClimathonSituationMapPage> createState() =>
      _ClimathonSituationMapPageState();
}

class _ClimathonSituationMapPageState extends State<ClimathonSituationMapPage> {
  final _primary = ClimathonColors.primary;
  final _secondary = ClimathonColors.secondary;

  bool _loading = false;

  _loadData() async {
    _loading = true;
    var provider = context.read<ClimathonDataProvider>();
    await provider.loadData();
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.read<ClimathonDataProvider>().data;
    return Stack(
      children: [
        SfMapsTheme(
          data: SfMapsThemeData(
            shapeHoverColor: _primary.withOpacity(0.5),
            shapeHoverStrokeColor: _primary,
            shapeHoverStrokeWidth: 2,
            tooltipColor: Colors.blue,
            tooltipStrokeColor: const Color.fromRGBO(252, 187, 15, 1),
            tooltipStrokeWidth: 1.5,
          ),
          child: ClimathonMap(
            subLayers: [
              if (!_loading && data != null)
                MapShapeSublayer(
                  source: MapShapeSource.asset(
                    'assets/ba-okr.json',
                    shapeDataField: 'NM3',
                    dataCount: data.length,
                    primaryValueMapper: (int index) => data[index].key,
                  ),
                  color: _secondary.withOpacity(0.2),
                  strokeWidth: 1,
                  strokeColor: _secondary,
                  shapeTooltipBuilder: (BuildContext context, int index) =>
                      ClimathonSituationMapDataTooltip(
                    data: context.read<ClimathonDataProvider>().data?[index] ??
                        data[index],
                  ),
                ),
            ],
          ),
        ),
        Container(

        ),
        if (_loading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
