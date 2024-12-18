import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:brichbackoffice/ui/user/userViewModel.dart';
import 'package:brichbackoffice/data/entities/user.dart';
import 'package:brichbackoffice/data/entities/wallet.dart';

class UserDetailsPage extends StatelessWidget {
  final String userId;
  const UserDetailsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()
        ..fetchUserDetails(userId)
        ..fetchUserWallets(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Détails de l\'Utilisateur'),
          backgroundColor: Colors.teal,
        ),
        body: Consumer<UserViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.error != null) {
              return Center(
                child: Text(
                  'Erreur: ${viewModel.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final user = viewModel.selectedUser;
            final wallets = viewModel.userWallets;

            if (user == null) {
              return const Center(child: Text('Utilisateur non trouvé'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildUserInfoCard(user),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: _buildWalletsCard(wallets),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.teal.shade200,
                child: Text(
                  user.name?.substring(0, 1).toUpperCase() ?? '?',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name ?? 'Nom non défini',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(color: Colors.teal),
            _buildDetailRow(
              label: 'Email',
              value: user.email ?? 'Non défini',
              icon: Icons.email,
            ),
            _buildDetailRow(
              label: 'Téléphone',
              value: user.numTel ?? 'Non défini',
              icon: Icons.phone,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletsCard(List<Wallet>? wallets) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wallets',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Total: ${wallets?.length ?? 0} wallet(s)',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: wallets != null && wallets.isNotEmpty
                  ? ListView.builder(
                      itemCount: wallets.length,
                      itemBuilder: (context, index) {
                        final wallet = wallets[index];
                        return WalletListItem(wallet: wallet);
                      },
                    )
                  : const Center(
                      child: Text(
                        'Aucun wallet trouvé pour cet utilisateur',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class WalletListItem extends StatelessWidget {
  final Wallet wallet;

  const WalletListItem({
    Key? key,
    required this.wallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: const Icon(
          Icons.account_balance_wallet,
          color: Colors.teal,
        ),
        title: Text(wallet.walletName),
        subtitle: Text(wallet.formattedBalance),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Public Key', wallet.shortPublicKey),
                _buildInfoRow('Currency', wallet.currency),
                _buildInfoRow('Type', wallet.type),
                _buildInfoRow('Network', wallet.network),
                _buildInfoRow('Created', wallet.createdAt.toString().split('.')[0]),
                if (wallet.originalAmount > 0)
                  _buildInfoRow('Original Amount', wallet.originalAmount.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}