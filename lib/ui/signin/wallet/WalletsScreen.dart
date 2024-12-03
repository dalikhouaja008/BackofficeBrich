import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WalletsViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Balance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Consumer<WalletsViewModel>(
              builder: (context, vm, child) {
                return Text(
                  "\$${vm.totalBalance.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              "Wallets",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<WalletsViewModel>(
                builder: (context, vm, child) {
                  return ListView.builder(
                    itemCount: vm.wallets.length,
                    itemBuilder: (context, index) {
                      final wallet = vm.wallets[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
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
            SizedBox(height: 20),
            Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<WalletsViewModel>(
                builder: (context, vm, child) {
                  return ListView.builder(
                    itemCount: vm.recentTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = vm.recentTransactions[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(transaction.type),
                          subtitle: Text(
                              "${transaction.amount < 0 ? '-' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}"),
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
          viewModel.fetchWallets();
          viewModel.fetchRecentTransactions();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
