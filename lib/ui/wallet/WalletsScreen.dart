import 'package:brichbackoffice/ui/wallet/walletViewModel.dart';
import 'package:brichbackoffice/data/repositories/WalletRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<WalletsViewModel>().fetchWallets();
      context.read<WalletsViewModel>().fetchRecentTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Consumer<WalletsViewModel>(builder: (context, vm, child) {
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
            }),
            const SizedBox(height: 20),
            const Text(
              "Wallets",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Search Field
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Wallets',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) =>
                  context.read<WalletsViewModel>().setSearchQuery(value),
            ),
            const SizedBox(height: 16),
            // Table Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(flex: 2, child: Text('Wallet Name')),
                Expanded(flex: 1, child: Text('Balance')),
                Expanded(flex: 2, child: Text('User')),
                Expanded(flex: 1, child: Text('Actions')),
              ],
            ),
            const Divider(),
            // Table Body
            Expanded(
              child: Consumer<WalletsViewModel>(
                builder: (context, vm, child) {
                  if (vm.errorMessage.isNotEmpty) {
                    return Center(child: Text(vm.errorMessage));
                  }
                  if (vm.wallets.isEmpty) {
                    return const Center(child: Text('No wallets available'));
                  }
                  return ListView.builder(
                    itemCount: vm.wallets.length,
                    itemBuilder: (context, index) {
                      final wallet = vm.wallets[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 2, child: Text(wallet.walletName)),
                          Expanded(flex: 1, child: Text("\$${wallet.balance.toStringAsFixed(2)}")),
                          Expanded(flex: 2, child: Text(wallet.user)),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    // Navigate to wallet details
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.block),
                                  onPressed: () {
                                    // Block wallet logic
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
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

                  if (vm.recentTransactions.isEmpty) {
                    return const Center(child: Text('No recent transactions'));
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
