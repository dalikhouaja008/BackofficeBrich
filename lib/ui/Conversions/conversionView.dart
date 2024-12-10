import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class ConversionsScreen extends StatefulWidget {
  const ConversionsScreen({super.key});

  @override
  _ConversionsScreenState createState() => _ConversionsScreenState();
}

class _ConversionsScreenState extends State<ConversionsScreen> {
  // Liste des devises
  final List<String> currencies = ['USD', 'EUR', 'TND', 'GBP', 'JPY'];
  
  // Contrôleurs pour les champs de saisie
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';

  // Données de conversions récentes
  final List<Map<String, dynamic>> _recentConversions = [
    {
      'date': '2024-03-15',
      'from': 'USD',
      'to': 'EUR',
      'amount': 1000,
      'convertedAmount': 920.50,
      'rate': 0.92
    },
    {
      'date': '2024-03-14',
      'from': 'TND',
      'to': 'USD',
      'amount': 5000,
      'convertedAmount': 1600.25,
      'rate': 0.32
    },
    // Ajoutez plus de conversions ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Drawer (identique à votre implémentation existante)
          Container(
            width: 250,
            color: const Color(0xFF2A2D3E),
            child: _buildWebDrawer(),
          ),
          
          // Contenu Principal
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Conversions de Devises',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      // Logique de rafraîchissement des taux
                    },
                  ),
                ],
              ),
              body: _buildConversionContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de conversion
            _buildConversionSection(),
            
            const SizedBox(height: 20),
            
            // Graphique des volumes de conversion
            _buildConversionVolumeChart(),
            
            const SizedBox(height: 20),
            
            // Conversions récentes
            _buildRecentConversionsTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionSection() {
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
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Montant',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _fromCurrency,
                items: currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _fromCurrency = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Convertir en',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: _toCurrency,
                items: currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _toCurrency = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Logique de conversion
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Conversion de $_fromCurrency à $_toCurrency'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Convertir'),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionVolumeChart() {
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
            'Volume de Conversions Mensuel',
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
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 50000),
                      const FlSpot(1, 75000),
                      const FlSpot(2, 60000),
                      const FlSpot(3, 90000),
                      const FlSpot(4, 70000),
                      const FlSpot(5, 85000),
                      const FlSpot(6, 100000),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentConversionsTable() {
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
            'Conversions Récentes',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          DataTable(
            columns: const [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('De')),
              DataColumn(label: Text('Vers')),
              DataColumn(label: Text('Montant')),
              DataColumn(label: Text('Taux')),
            ],
            rows: _recentConversions.map((conversion) {
              return DataRow(cells: [
                DataCell(Text(conversion['date'])),
                DataCell(Text(conversion['from'])),
                DataCell(Text(conversion['to'])),
                DataCell(Text('${conversion['amount']} → ${conversion['convertedAmount']}')),
                DataCell(Text(conversion['rate'].toString())),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Reproduisez votre méthode _buildDrawerContent() existante ici
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
        //_drawerItem(Icons.logout, 'Log out', () => controller.logout()),
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
}