import 'package:climathon_admin/models/data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _Model {
  final DateTime date;
  final int value;

  _Model(this.date, this.value);
}

class ClimathonSMSeriesChart extends StatelessWidget {
  final List<ClimathonDataModel> chartData;
  final String? label;

  const ClimathonSMSeriesChart({
    Key? key,
    required this.chartData,
    this.label,
  }) : super(key: key);

  _generateData(bool status) {
    var today = DateTime.now();
    List<_Model> retval = [];
    for (int i = 0; i < 12; i++) {
      var refDate = Jiffy(today).subtract(months: i).dateTime;
      var value = 0;
      for (var element in chartData) {
        if (element.created.isBefore(refDate) && element.status == status) {
          if (label == null) {
            value++;
          } else if (label == element.label) {
            value++;
          }
        }
      }
      retval.add(_Model(refDate, value));
    }
    return retval;
  }

  _buildLineSeries(List<_Model> dataSource, String name) {
    return LineSeries<_Model, DateTime>(
      name: name,
      dataSource: dataSource,
      xValueMapper: (_Model data, _) => data.date,
      yValueMapper: (_Model data, _) => data.value,
      dataLabelSettings: const DataLabelSettings(
        isVisible: true,
        useSeriesColor: true,
      ),
      markerSettings: const MarkerSettings(
        isVisible: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        legend: Legend(isVisible: true),
        series: <ChartSeries<_Model, DateTime>>[
          _buildLineSeries(_generateData(false), 'Pending issues'),
          _buildLineSeries(_generateData(true), 'Fixed issues'),
        ],
      ),
    );
  }
}
