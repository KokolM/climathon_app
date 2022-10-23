import 'package:climathon_admin/models/data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _Model {
  final String text;
  final int value;

  _Model(
    this.text,
    this.value,
  );
}

class ClimathonSMAccomplitionRateChart extends StatelessWidget {
  final List<ClimathonDataModel> chartData;
  final String? label;

  const ClimathonSMAccomplitionRateChart({
    Key? key,
    required this.chartData,
    this.label,
  }) : super(key: key);

  _generateData() {
    List<_Model> retval = [];
    var pending = 0;
    var fixed = 0;
    for (var element in chartData) {
      if (label == null) {
        if (element.status) {
          fixed++;
        } else {
          pending++;
        }
      } else if (element.label == label) {
        if (element.status) {
          fixed++;
        } else {
          pending++;
        }
      }
    }
    retval.addAll([
      _Model('Pending issues', pending),
      _Model('Fixed issues', fixed),
    ]);

    return retval;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCircularChart(
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          PieSeries<_Model, String>(
            dataSource: _generateData(),
            xValueMapper: (_Model data, _) => data.text,
            yValueMapper: (_Model data, _) => data.value,
          )
        ],
      ),
    );
  }
}
