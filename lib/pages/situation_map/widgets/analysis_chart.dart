import 'package:climathon_admin/models/data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _Model {
  final int value;

  _Model(this.value);
}

class ClimathonSMAnalysisChart extends StatelessWidget {
  final List<ClimathonDataModel> chartData;
  final String? label;

  const ClimathonSMAnalysisChart({
    Key? key,
    required this.chartData,
    this.label,
  }) : super(key: key);

  _generateData(String label) {
    List<_Model> retval = [];
    var today = DateTime.now();
    var currentValue = 0;
    var allValue = 0;
    var years = [];
    for (var element in chartData) {
      if (element.label == label) {
        var refYear = element.created.year;
        if (refYear == today.year) {
          currentValue++;
        }
        if (!years.contains(refYear)) {
          years.add(refYear);
        }
        allValue++;
      }
    }
    retval.addAll([
      _Model(currentValue),
      _Model(allValue ~/ years.length),
    ]);

    return retval;
  }

  _buildLineSeries(String label) {
    return ColumnSeries<_Model, int>(
      name: label,
      dataSource: _generateData(label),
      xValueMapper: (_Model data, index) => index,
      yValueMapper: (_Model data, _) => data.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
          legend: Legend(isVisible: true),
          series: label == null
              ? <ChartSeries<_Model, int>>[
                  _buildLineSeries(ClimathonLabels.roads),
                  _buildLineSeries(ClimathonLabels.fire),
                  _buildLineSeries(ClimathonLabels.garbage),
                  _buildLineSeries(ClimathonLabels.floods),
                ]
              : <ChartSeries<_Model, int>>[
                  _buildLineSeries(label!),
                ]),
    );
  }
}
