import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPieChart extends StatelessWidget {
  const DashboardPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Répartition des Portefeuilles par Devise',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    color: Colors.blue,
                    title: 'USD',
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 30,
                    color: Colors.green,
                    title: 'EUR',
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 20,
                    color: Colors.orange,
                    title: 'TND',
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 10,
                    color: Colors.red,
                    title: 'Autres',
                    radius: 50,
                  ),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}