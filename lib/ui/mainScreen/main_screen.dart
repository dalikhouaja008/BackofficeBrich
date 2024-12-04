import 'package:brichbackoffice/ui/componenets/app_bar_search.dart';
import 'package:brichbackoffice/ui/componenets/dashboard_statistics_section.dart';
import 'package:brichbackoffice/ui/componenets/key_metrics.dart';
import 'package:brichbackoffice/ui/componenets/web_drawer.dart';
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
          const WebDrawer(),
          Expanded(
            child: Scaffold(
              appBar: const CustomAppBarSearch(),
              body: _buildDashboardContent(),
            ),
          ),
        ],
      ),
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
            const KeyMetrics(),
            const SizedBox(height: 20),
            const DashboardStatisticsSection(),
          ],
        ),
      ),
    );
  }
}
