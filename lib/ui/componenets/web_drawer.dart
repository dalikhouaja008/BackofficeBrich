import 'package:brichbackoffice/config/routes/app_router.dart';
import 'package:brichbackoffice/ui/mainScreen/mainScreenViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF2A2D3E),
      child: ListView(
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
          //_drawerItem(Icons.supervised_user_circle_sharp, 'Users', () {}),
          _drawerItem(Icons.supervised_user_circle_sharp, 'Users', () => Get.toNamed(AppRoutes.usersPage)),
          _drawerItem(Icons.wallet, 'Wallets', () => Get.toNamed(AppRoutes.walletPage)),
          _drawerItem(
            Icons.currency_exchange,
            'Conversions',
            () => Get.toNamed(AppRoutes.conversions)
          ),
          _drawerItem(Icons.settings, 'Settings', () {}),
          _drawerItem(Icons.logout, 'Log out', () => Get.find<Mainscreenviewmodel>().logout()),
        ],
      ),
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