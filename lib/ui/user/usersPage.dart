import 'package:brichbackoffice/ui/user/userWalletsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brichbackoffice/ui/user/userViewModel.dart';
import 'package:brichbackoffice/data/entities/user.dart';
import 'package:brichbackoffice/ui/user/userDetailsPage.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Liste des Utilisateurs'),
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
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: viewModel.users.length,
              itemBuilder: (context, index) {
                final user = viewModel.users[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                user.name?.substring(0, 1).toUpperCase() ?? '?',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name ?? 'Non défini',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email ?? 'Email non défini',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDetailsPage(userId: user.id ?? ''),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.info_outline),
                              label: const Text('Détails'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserWalletsPage(userId: user.id ?? ''),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.account_balance_wallet),
                              label: const Text('Wallets'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
