import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brichbackoffice/ui/user/userViewModel.dart';

class UserWalletsPage extends StatelessWidget {
  final String userId;

  const UserWalletsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..fetchUserWallets(userId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Wallets de l\'Utilisateur')),
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
            final wallets = viewModel.userWallets;
            if (wallets == null || wallets.isEmpty) {
              return const Center(child: Text('Aucun wallet trouvé'));
            }
            return ListView.builder(
              itemCount: wallets.length,
              itemBuilder: (context, index) {
                final wallet = wallets[index];
                return ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: Text(wallet.walletName),
                  subtitle: Text('Solde: ${wallet.balance.toStringAsFixed(4)}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}