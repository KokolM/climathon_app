import 'package:climathon_admin/constants/colors.dart';
import 'package:climathon_admin/models/data.dart';
import 'package:climathon_admin/pages/situation_map/widgets/accomplition_rate_chart.dart';
import 'package:climathon_admin/pages/situation_map/widgets/analysis_chart.dart';
import 'package:climathon_admin/pages/situation_map/widgets/series_chart.dart';
import 'package:climathon_admin/providers/data.dart';
import 'package:climathon_admin/widgets/map.dart';
import 'package:climathon_admin/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class _Map extends StatelessWidget {
  final List<ClimathonDataModel> data;

  final _primary = ClimathonColors.primary;
  final _secondary = ClimathonColors.secondary;

  const _Map({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfMapsTheme(
      data: SfMapsThemeData(
        shapeHoverColor: _secondary.withOpacity(0.05),
        shapeHoverStrokeColor: _primary,
        shapeHoverStrokeWidth: 2,
        tooltipColor: Colors.white,
      ),
      child: ClimathonMap(
        data: data,
        markerBuilder: (context, index) {
          return MapMarker(
            latitude: data[index].lat,
            longitude: data[index].lon,
            child: Icon(
              ClimathonLabels.labelIcons[data[index].label],
              color: _primary,
            ),
          );
        },
        markerTooltipBuilder: (context, index) {
          return Container();
        },
        subLayers: [
          MapShapeSublayer(
            source: const MapShapeSource.asset(
              'assets/ba-okr.json',
              shapeDataField: 'NM3',
            ),
            color: _secondary.withOpacity(0.05),
            strokeWidth: 0.5,
            strokeColor: _secondary,
          ),
        ],
      ),
    );
  }
}

class ClimathonSituationMapPage extends StatefulWidget {
  final String? label;

  const ClimathonSituationMapPage({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  State<ClimathonSituationMapPage> createState() =>
      _ClimathonSituationMapPageState();
}

class _ClimathonSituationMapPageState extends State<ClimathonSituationMapPage> {
  late ClimathonDataProvider _provider;

  bool _loading = false;

  _loadData() async {
    _loading = true;
    await _provider.loadData();
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _provider = context.read<ClimathonDataProvider>();
    _loadData();
  }

  get _dataInitialized => !_loading && _provider.data != null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _loading
                        ? const ClimathonSpinner()
                        : _Map(data: [
                            ..._provider.getLabelData(widget.label),
                          ])
                  ],
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height / 3,
                child: Card(
                  child: _dataInitialized
                      ? ClimathonSMSeriesChart(
                          chartData: _provider.data!,
                          label: widget.label,
                        )
                      : const ClimathonSpinner(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width / 3,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: _dataInitialized
                      ? ClimathonSMAccomplitionRateChart(
                          chartData: _provider.data!,
                          label: widget.label,
                        )
                      : const SizedBox(
                          width: double.infinity,
                          child: ClimathonSpinner(),
                        ),
                ),
              ),
              Expanded(
                child: Card(
                  child: _dataInitialized
                      ? ClimathonSMAnalysisChart(
                          chartData: _provider.data!,
                          label: widget.label,
                        )
                      : const SizedBox(
                          width: double.infinity,
                          child: ClimathonSpinner(),
                        ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
