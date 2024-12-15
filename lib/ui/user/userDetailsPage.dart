import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brichbackoffice/ui/user/userViewModel.dart';
import 'package:brichbackoffice/data/entities/user.dart';

class UserDetailsPage extends StatelessWidget {
  final String userId;
  const UserDetailsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..fetchUserDetails(userId),
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
            if (user == null) {
              return const Center(child: Text('Utilisateur non trouvé'));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
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
                            radius: 50,
                            backgroundColor: Colors.teal.shade200,
                            child: Text(
                              user.name?.substring(0, 1).toUpperCase() ?? '?',
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            user.name ?? 'Non défini',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.teal),
                        _buildDetailRow(
                          context,
                          label: 'Email',
                          value: user.email ?? 'Non défini',
                          icon: Icons.email,
                        ),
                        _buildDetailRow(
                          context,
                          label: 'Téléphone',
                          value: user.numTel ?? 'Non défini',
                          icon: Icons.phone,
                        ),
                        _buildDetailRow(
                          context,
                          label: 'Rôle',
                          value: _getRoleDescription(user.roleId) ?? 'Non défini',
                          icon: Icons.person_outline,
                        ),
                        _buildDetailRow(
                          context,
                          label: 'Wallet',
                          value: user.wallet?.toString() ?? 'Aucun wallet',
                          icon: Icons.account_balance_wallet,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _getRoleDescription(int? roleId) {
    if (roleId == null) return null;
    switch (roleId) {
      case 0:
        return 'Admin';
      case 1:
        return 'Utilisateur';
      default:
        return 'Rôle inconnu';
    }
  }

  Widget _buildDetailRow(
    BuildContext context, {
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
