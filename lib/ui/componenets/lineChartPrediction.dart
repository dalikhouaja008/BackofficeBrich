import 'package:brichbackoffice/ui/Conversions/CurrencyConverterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Linechartprediction extends StatelessWidget {
  final String toCurrency;
  final CurrencyConverterController controller;

  const Linechartprediction({
    super.key, 
    required this.toCurrency, 
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currencyData = controller.predictions[toCurrency] ?? [];

      return SizedBox(
        width: double.infinity,
        height: 300,
        child: Builder(
          builder: (context) {
            if (controller.isLoadingPredictions.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (currencyData.isEmpty) {
              return Center(
                child: Text(
                  'No predictions available for $toCurrency',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }

            return SfCartesianChart(
              primaryXAxis: const CategoryAxis(
                title: AxisTitle(text: 'Date'),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(text: 'Value'),
              ),
              series: <LineSeries<dynamic, String>>[
                LineSeries<dynamic, String>(
                  dataSource: currencyData,
                  xValueMapper: (data, _) => data.date,
                  yValueMapper: (data, _) => data.value,
                  color: Theme.of(context).colorScheme.primary,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}