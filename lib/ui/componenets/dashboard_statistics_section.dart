

import 'package:brichbackoffice/ui/componenets/line_chart.dart';
import 'package:brichbackoffice/ui/componenets/pie_chart.dart';
import 'package:flutter/material.dart';

class DashboardStatisticsSection extends StatelessWidget {
  const DashboardStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children:  [
        Expanded(
          flex: 2,
          child: DashboardLineChart(),
        ),
        SizedBox(width: 16),
        Expanded(
          child: DashboardPieChart(),
        ),
      ],
    );
  }
}