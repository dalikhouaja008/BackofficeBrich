import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mainScreenViewModel.dart';

class AdminDashboardScreen extends GetView<Mainscreenviewmodel> {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Drawer Web
          _buildWebDrawer(),
          
          // Contenu Principal
          Expanded(
            child: Scaffold(
              appBar: _buildAppBar(),
              body: _buildDashboardContent(),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Container(
        width: 400,
        height: 40,
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
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher...',
            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://ui-avatars.com/api/?name=Admin+User',
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildWebDrawer() {
    return Container(
      width: 250,
      color: const Color(0xFF2A2D3E),
      child: _drawerContent(),
    );
  }

  Widget _drawerContent() {
    return ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xFF2A2D3E),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://ui-avatars.com/api/?name=Admin+User',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Admin Dashboard',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        _drawerItem(Icons.dashboard, 'Dashboard', () {}),
        _drawerItem(Icons.analytics, 'Analytics', () {}),
        _drawerItem(Icons.supervised_user_circle_sharp, 'Users', () {}),
        _drawerItem(Icons.wallet, 'Wallets', () {}),
        _drawerItem(Icons.currency_exchange, 'Conversions', () {Get.toNamed(AppRoutes.conversions);}),
        _drawerItem(Icons.settings, 'Settings', () {}),
        _drawerItem(Icons.logout, 'Log out', () => controller.logout()),
      ],
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.roboto(color: Colors.white70),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard content',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Chiffres clés du jour
            _buildKeyMetrics(),
            
            const SizedBox(height: 20),
            
            // Graphiques et statistiques
            _buildStatisticsSection(),
          ],
        ),
      ),
    );
  }

  // Les autres méthodes (_buildKeyMetrics, _metricCard, etc.) restent identiques
  // à l'implémentation précédente
  Widget _buildKeyMetrics() {
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

  Widget _buildStatisticsSection() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildLineChart(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPieChart(),
        ),
      ],
    );
  }

 Widget _buildLineChart() {
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
          'Volume de Trading Mensuel',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 1,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      const months = ['Jan', 'Fev', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil'];
                      return Text(months[value.toInt()], style: TextStyle(fontSize: 10));
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 30000),
                    const FlSpot(1, 45000),
                    const FlSpot(2, 35000),
                    const FlSpot(3, 55000),
                    const FlSpot(4, 40000),
                    const FlSpot(5, 60000),
                    const FlSpot(6, 50000),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
Widget _buildPieChart() {
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
