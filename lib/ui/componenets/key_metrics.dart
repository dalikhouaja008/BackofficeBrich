import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
class KeyMetrics extends StatelessWidget {
  const KeyMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _metricCard('Utilisateurs', '1,254', Icons.people, Colors.blue),
        const SizedBox(width: 16),
        _metricCard('Volume de Trading', '45,230 TND', Icons.show_chart, Colors.green),
        const SizedBox(width: 16),
        _metricCard('Total des Portefeuilles', '230,450 TND', Icons.account_balance_wallet, Colors.orange),
        const SizedBox(width: 16),
        _metricCard('Conversions', '1,890', Icons.currency_exchange, Colors.purple),
      ],
    );
  }

  Widget _metricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
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
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.roboto(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
