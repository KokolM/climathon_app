import 'package:climathon_admin/constants/colors.dart';
import 'package:climathon_admin/models/data.dart';
import 'package:climathon_admin/providers/data.dart';
import 'package:climathon_admin/widgets/safe_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ClimathonStatisticsPage extends StatefulWidget {
  const ClimathonStatisticsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClimathonStatisticsPage> createState() =>
      _ClimathonStatisticsPageState();
}

class _ClimathonStatisticsPageState extends State<ClimathonStatisticsPage> {
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
    return ClimathonSafeArea(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 3,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: _loading || data == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Chart example 1'),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<ClimathonDataModel, String>>[
                        LineSeries<ClimathonDataModel, String>(
                          dataSource: data,
                          xValueMapper: (ClimathonDataModel data, _) =>
                              data.key,
                          yValueMapper: (ClimathonDataModel data, _) =>
                              data.size,
                          name: 'Size',
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        )
                      ],
                    ),
                  ),
          ),
          Card(
            color: Colors.white,
            child: _loading || data == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SfSparkLineChart.custom(
                      //Enable the trackball
                      trackball: const SparkChartTrackball(
                          activationMode: SparkChartActivationMode.tap),
                      //Enable marker
                      marker: const SparkChartMarker(
                          displayMode: SparkChartMarkerDisplayMode.all),
                      //Enable data label
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      xValueMapper: (int index) => data[index].key,
                      yValueMapper: (int index) => data[index].size,
                      dataCount: 5,
                    ),
                  ),
          ),
          Card(
            color: Colors.white,
            child: _loading || data == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SfCircularChart(
                        title: ChartTitle(text: 'Sales by sales person'),
                        legend: Legend(isVisible: true),
                        series: <PieSeries<ClimathonDataModel, String>>[
                          PieSeries<ClimathonDataModel, String>(
                              explode: true,
                              explodeIndex: 0,
                              dataSource: data,
                              xValueMapper: (ClimathonDataModel data, _) =>
                                  data.key,
                              yValueMapper: (ClimathonDataModel data, _) =>
                                  data.size,
                              dataLabelMapper: (ClimathonDataModel data, _) =>
                                  data.key,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true)),
                        ])),
          ),
          Card(
            color: Colors.white,
            child: _loading || data == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SfPyramidChart(
                        series: PyramidSeries<ClimathonDataModel, String>(
                      dataSource: data,
                      xValueMapper: (ClimathonDataModel data, _) => data.key,
                      yValueMapper: (ClimathonDataModel data, _) => data.size,
                    ))),
          ),
          Card(
            color: Colors.white,
            child: _loading || data == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
                      // Renders scatter chart
                      ScatterSeries<ClimathonDataModel, DateTime>(
                          dataSource: data,
                          xValueMapper: (ClimathonDataModel data, _) => DateTime.now(),
                          yValueMapper: (ClimathonDataModel data, _) => data.size
                      )
                    ]
                )),
          ),
          Card(
            color: Colors.white,
            child: _loading || data == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SfCartesianChart(
                    series: <ChartSeries>[
                      SplineAreaSeries<ClimathonDataModel, int>(
                          dataSource: data,
                          splineType: SplineType.cardinal,
                          cardinalSplineTension: 0.9,
                          xValueMapper: (ClimathonDataModel data, _) => data.size.toInt(),
                          yValueMapper: (ClimathonDataModel data, _) => data.size
                      )
                    ]
                )),
          ),
        ],
      ),
    );
  }
}
