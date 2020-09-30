import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text('No traansactions added yet!',
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView(
            //useful for long long list
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id), //use key when flutter doesn't work properly between widget tree and element tree
                      transaction: tx,
                      deleteTransaction: deleteTransaction,
                    ))
                .toList(),
          );

    // return Card(
    //   child: Row(
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(
    //           vertical: 10,
    //           horizontal: 15,
    //         ),
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: Theme.of(context).primaryColor,
    //             width: 2,
    //           ),
    //         ),
    //         padding: EdgeInsets.all(10),
    //         child: Text(
    //           '\$${transactions[index].amount.toStringAsFixed(2)}', //string interpolation!!11 with ${}
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             transactions[index].title,
    //             style: Theme.of(context).textTheme.headline6,
    //           ),
    //           Text(
    //             DateFormat.yMMMd().format(transactions[index].date),
    //             style: TextStyle(
    //               color: Colors.grey,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    // itemCount: transactions.length,
    // children: transactions.map((tx) {
    //   return
    // }).toList(), //since using ListBuilder, no longer work
  }
}
