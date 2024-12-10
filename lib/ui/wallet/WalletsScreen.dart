import 'package:brichbackoffice/ui/wallet/walletViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletsScreen extends StatelessWidget {
  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Wallet Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Balance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Consumer<WalletsViewModel>( // Use Consumer to access the WalletsViewModel
              builder: (context, vm, child) {
                if (vm.errorMessage.isNotEmpty) {
                  return Text(
                    vm.errorMessage,
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Text(
                  "\$${vm.totalBalance.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Wallets",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<WalletsViewModel>(
                builder: (context, vm, child) {
                  if (vm.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(vm.errorMessage, style: TextStyle(color: Colors.red)),
                    );
                  }

                  return ListView.builder(
                    itemCount: vm.wallets.length,
                    itemBuilder: (context, index) {
                      final wallet = vm.wallets[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(wallet.walletName),
                          subtitle: Text("Balance: \$${wallet.balance.toStringAsFixed(2)}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<WalletsViewModel>(
                builder: (context, vm, child) {
                  if (vm.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(vm.errorMessage, style: TextStyle(color: Colors.red)),
                    );
                  }

                  return ListView.builder(
                    itemCount: vm.recentTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = vm.recentTransactions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(transaction.type),
                          subtitle: Text(
                            "${transaction.amount < 0 ? '-' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<WalletsViewModel>().fetchWallets();
          context.read<WalletsViewModel>().fetchRecentTransactions();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
