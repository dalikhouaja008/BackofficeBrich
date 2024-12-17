import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:brichbackoffice/data/repositories/CurrencyConverterRepository.dart';
import 'package:brichbackoffice/ui/Conversions/CurrencyConverterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class ConversionsScreen extends StatefulWidget {
  const ConversionsScreen({super.key});

  @override
  _ConversionsScreenState createState() => _ConversionsScreenState();
}

class _ConversionsScreenState extends State<ConversionsScreen> {
   final Color _primaryColor = const Color(0xFF3366FF);
  final Color _backgroundColor = const Color(0xFFF4F6FF);
  final Color _cardColor = Colors.white;
  final Color _textColor = const Color(0xFF2D3748);
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
          // Sidebar Navigation
          _buildSidebar(),

          // Main Content Area
          Expanded(
            child: Scaffold(
              appBar: _buildAppBar(),
              body: _buildMainContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return GetBuilder<CurrencyConverterController>(
      init: CurrencyConverterController(Get.find<CurrencyConverterRepository>()),
      builder: (controller) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Conversion Section
              _buildConversionSection(controller),
              const SizedBox(height: 20),

              // Responsive Layout for Charts and Tables
              LayoutBuilder(
                builder: (context, constraints) {
                  // For wider screens, use side-by-side layout
                  if (constraints.maxWidth > 1200) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildConversionVolumeChart()),
                        const SizedBox(width: 20),
                        Expanded(child: _buildPredictionsChart(controller)),
                      ],
                    );
                  }
                  // For smaller screens, stack vertically
                  return Column(
                    children: [
                      _buildConversionVolumeChart(),
                      const SizedBox(height: 20),
                      _buildPredictionsChart(controller),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Responsive Tables
              LayoutBuilder(
                builder: (context, constraints) {
                  // For wider screens, use side-by-side layout
                  if (constraints.maxWidth > 1200) {
                    return Row(
                      children: [
                        Expanded(child: _buildExchangeRatesTable(controller)),
                        const SizedBox(width: 20),
                        Expanded(child: _buildRecentConversionsTable()),
                      ],
                    );
                  }
                  // For smaller screens, stack vertically
                  return Column(
                    children: [
                      _buildExchangeRatesTable(controller),
                      const SizedBox(height: 20),
                      _buildRecentConversionsTable(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _buildSidebar() {
    return Container(
      width: 250,
      color: const Color(0xFF2A2D3E),
      child: ListView(
        children: [
          _buildSidebarHeader(),
          ..._buildSidebarMenuItems(),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color(0xFF2A2D3E)),
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
    );
  }

  List<Widget> _buildSidebarMenuItems() {
    return [
      _sidebarMenuItem(Icons.dashboard, 'Dashboard', () {}),
      _sidebarMenuItem(Icons.analytics, 'Analytics', () {}),
      _sidebarMenuItem(Icons.supervised_user_circle_sharp, 'Users', () {}),
      _sidebarMenuItem(Icons.wallet, 'Wallets', () {}),
      _sidebarMenuItem(Icons.currency_exchange, 'Conversions', () {
        Get.toNamed(AppRoutes.conversions);
      }),
      _sidebarMenuItem(Icons.settings, 'Settings', () {}),
    ];
  }

  Widget _sidebarMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.roboto(color: Colors.white70),
      ),
      onTap: onTap,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Currency Conversions',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            // Refresh logic
          },
        ),
      ],
    );
  }


  Widget _buildConversionContent(CurrencyConverterController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConversionSection(controller),
            const SizedBox(height: 20),
            _buildConversionVolumeChart(),
            const SizedBox(height: 20),
            _buildPredictionsChart(controller),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Optionnel : pour espacer les tableaux
              children: [
                Expanded(
                  // Utilisez Expanded pour que le tableau prenne l'espace disponible
                  child: _buildExchangeRatesTable(controller),
                ),
                const SizedBox(width: 20), // Espacement entre les tableaux
                Expanded(
                  // Utilisez également Expanded ici
                  child: _buildRecentConversionsTable(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
Widget _buildCurrencyTextField(CurrencyConverterController controller) {
    return TextField(
      controller: controller.amountController,
      decoration: InputDecoration(
        labelText: 'Amount',
        labelStyle: GoogleFonts.roboto(color: _textColor.withOpacity(0.7)),
        prefixIcon: Icon(Icons.money, color: _primaryColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryColor, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      style: GoogleFonts.roboto(color: _textColor),
    );
  }

  Widget _buildCurrencyDropdown(
    CurrencyConverterController controller, 
    RxString currencyValue, 
    String label,
    IconData icon
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: _primaryColor),
          const SizedBox(width: 8),
          Obx(() => DropdownButton<String>(
            value: currencyValue.value,
            underline: Container(),
            dropdownColor: Colors.white,
            style: GoogleFonts.roboto(
              color: _textColor,
              fontWeight: FontWeight.w600,
            ),
            items: controller.currencies.map((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
            onChanged: (String? newValue) {
              currencyValue.value = newValue!;
            },
          )),
        ],
      ),
    );
  }
  Widget _buildConversionSection(CurrencyConverterController controller) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor.withOpacity(0.1), _primaryColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Currency Converter',
            style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCurrencyTextField(controller),
                    const SizedBox(height: 12),
                    Obx(() => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            controller.conversionResultText.value,
                            key: ValueKey(controller.conversionResultText.value),
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: controller.conversionResultText.value.contains('Erreur')
                                  ? Colors.red
                                  : _textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildCurrencyDropdown(
                controller, 
                controller.fromCurrency, 
                'From', 
                Icons.monetization_on_outlined
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.swap_vert, color: _primaryColor, size: 32),
                onPressed: () => controller.switchCurrencies(),
              ),
              Expanded(
                child: Text(
                  'Convert To',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
              ),
              _buildCurrencyDropdown(
                controller, 
                controller.toCurrency, 
                'To', 
                Icons.attach_money
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Obx(() => ElevatedButton.icon(
              icon: Icon(
                controller.isLoading.value 
                  ? Icons.hourglass_empty 
                  : Icons.currency_exchange,
                color: Colors.white,
              ),
              label: Text(
                controller.isLoading.value ? 'Converting...' : 'Convert',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : controller.convertCurrency,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }


    Widget _buildExchangeRatesTable(CurrencyConverterController controller) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exchange Rates',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: _primaryColor),
                  onPressed: () {
                    // Add refresh logic
                  },
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                ),
              );
            }

            return controller.exchangeRates.isEmpty
                ? Center(
                    child: Text(
                      'No exchange rates available',
                      style: GoogleFonts.roboto(color: Colors.grey),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20,
                      dataRowHeight: 60,
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => _primaryColor.withOpacity(0.1),
                      ),
                      columns: [
                        _buildDataColumn('Currency'),
                        _buildDataColumn('Buying Rate'),
                        _buildDataColumn('Selling Rate'),
                        _buildDataColumn('Date'),
                      ],
                      rows: controller.exchangeRates.map((rate) {
                        return DataRow(cells: [
                          _buildDataCell(rate['code'] ?? 'N/A'),
                          _buildDataCell(rate['buyingRate']?.toString() ?? 'N/A'),
                          _buildDataCell(rate['sellingRate']?.toString() ?? 'N/A'),
                          _buildDataCell(rate['date'] ?? 'N/A'),
                        ]);
                      }).toList(),
                    ),
                  );
          }),
        ],
      ),
    );
  }
  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          color: _textColor,
        ),
      ),
    );
  }

  DataCell _buildDataCell(String value) {
    return DataCell(
      Text(
        value,
        style: GoogleFonts.roboto(color: _textColor.withOpacity(0.8)),
      ),
    );
  }

 Widget _buildConversionVolumeChart() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Monthly Conversion Volume',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
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
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => Text(
                        ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'][value.toInt()],
                        style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
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
                    gradient: LinearGradient(
                      colors: [_primaryColor, _primaryColor.withOpacity(0.5)],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 4,
                        color: _primaryColor,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                    ),
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
                DataCell(Text(
                    '${conversion['amount']} → ${conversion['convertedAmount']}')),
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
        _drawerItem(Icons.currency_exchange, 'Conversions', () {
          Get.toNamed(AppRoutes.conversions);
        }),
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

  Widget _buildPredictionsChart(CurrencyConverterController controller) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prédictions de Devises',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Dropdown for selecting prediction currency
              Obx(() => DropdownButton<String>(
                  value: controller.currencyPrediction.value,
                  items: controller.currencies.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.currencyPrediction.value = newValue;
                      controller.toCurrency.value =
                          newValue; // Synchronisez les deux
                      controller.loadPredictions(
                          controller.getCurrentDate(), [newValue]);
                    }
                  })),
            ],
          ),
          const SizedBox(height: 16),
          // Predictions Chart
          Obx(() {
            // Check if predictions are loading
            if (controller.isLoadingPredictions.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // Debugging print
            print('Current predictions: ${controller.predictions}');
            print('Current currency: ${controller.toCurrency.value}');

            // Get predictions for the current currency
            final currencyPredictions =
                controller.predictions[controller.toCurrency.value] ?? [];

            // If no predictions, show a message
            if (currencyPredictions.isEmpty) {
              return Center(
                child: Text(
                  'Aucune prédiction disponible',
                  style: GoogleFonts.roboto(),
                ),
              );
            }

            // Create spots for the line chart
            final spots = currencyPredictions.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.value);
            }).toList();

            return SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final index = value.toInt();
                          if (index < currencyPredictions.length) {
                            return Text(
                              currencyPredictions[index].date,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toStringAsFixed(4),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
