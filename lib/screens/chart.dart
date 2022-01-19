import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// not working useless package

class Chart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Chart(this.seriesList, {this.animate});

  factory Chart.withSampleData() {
    return Chart(
      _createProfileSharedData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      behaviors: [
        charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          showMeasures: true,
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          measureFormatter: (num value) {
            return value == null ? '-' : '$value';
          },
        ),
      ],
    );
  }

  static List<charts.Series<ProfileShared, String>> _createProfileSharedData() {
    final data = [
      ProfileShared('profile', 100),
      ProfileShared('rejected', 75),
      ProfileShared('scheduled', 25),
      ProfileShared('selected', 5),
    ];

    return [
      charts.Series<ProfileShared, String>(
        id: 'interview',
        domainFn: (ProfileShared profile, _) => profile.status,
        measureFn: (ProfileShared profile, _) => profile.count,
        data: data,
      )
    ];
  }
}

class ProfileShared {
  final String status;
  final int count;

  ProfileShared(this.status, this.count);
}
