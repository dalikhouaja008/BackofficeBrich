import 'package:brichbackoffice/data/entities/ExchangeRate.dart';
import 'package:flutter/material.dart';

class ExchangeRateList extends StatelessWidget {
  final List<ExchangeRate> rates;

  const ExchangeRateList({
    super.key, 
    required this.rates
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 600),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(),
          
          // Rate List
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: rates.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
              itemBuilder: (context, index) {
                final rate = rates[index];
                return _buildRateItem(rate);
              },
            ),
          ),
          
          // Footer with Date
          _buildFooter(rates),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              "Currency",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:  Color(0xFF3D5AFE),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Buying",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:  Color(0xFF3D5AFE),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Selling",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:  Color(0xFF3D5AFE),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRateItem(ExchangeRate rate) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rate.code,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color:  Color(0xFF3D5AFE),
                  ),
                ),
                Text(
                  rate.designation,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Unit: ${rate.unit}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              rate.buyingRate,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color:  Color(0xFF3D5AFE),
              ),
            ),
          ),
          Expanded(
            child: Text(
              rate.sellingRate,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color:  Color(0xFFFFA500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(List<ExchangeRate> rates) {
    // Extract date from first rate or use current date
    final dateString = rates.isNotEmpty 
      ? rates.first.date.substring(0, 10) 
      : DateTime.now().toIso8601String().substring(0, 10);

    return Container(
      width: double.infinity,
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.all(8),
      child: Text(
        "Date: $dateString",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color:  Color(0xFF3D5AFE),
        ),
      ),
    );
  }
}
