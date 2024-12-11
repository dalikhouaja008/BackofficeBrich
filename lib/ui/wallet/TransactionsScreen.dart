import 'package:brichbackoffice/ui/wallet/transactionViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brichbackoffice/data/entities/transaction.dart';

class TransactionsScreen extends StatelessWidget {
  final String walletId;

  TransactionsScreen(this.walletId);

  @override
  Widget build(BuildContext context) {
    final TransactionViewModel controller = Get.put(TransactionViewModel());

    // Fetch transactions when the screen is built
    controller.fetchTransactions(walletId); // Appel à la méthode fetchTransactions

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions for Wallet: $walletId'),
      ),
      body: Obx(() {
        // Vérifie si le tableau de transactions est vide
        if (controller.transactions.isEmpty) {
          return const Center(child: Text('No transactions available.'));
        }

        return ListView.builder(
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final Transaction transaction = controller.transactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text('Type: ${transaction.type}'),
                subtitle: Text(
                  'Amount: \$${transaction.amount.toStringAsFixed(2)}\n'
                  'Wallet: ${transaction.wallet}\n'
                  'Date: ${transaction.createdAt.toLocal().toString().split(' ')[0]}', // Format simple de la date
                ),
                trailing: Icon(Icons.arrow_forward), // Icône pour indiquer une action
                onTap: () {
                  // Logique pour afficher plus de détails sur la transaction
                },
              ),
            );
          },
        );
      }),
    );
  }
}