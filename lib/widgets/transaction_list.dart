import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  // we use const constructors but it is only applicable to constructor if we use final 
  // by using the const once the constructor will get the value it will not rebuild again when the build method is called 
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {                    // context and constraints
    return transactions.isEmpty ? LayoutBuilder(builder: (ctx, constraints){
      return Column(
        children: <Widget>[
          Text(
            'No Transactions added yet!',
            style: Theme.of(context).textTheme.title, // setting the style like the theme title style
          ),
          SizedBox( // this invisible box will help to create the space
            height: constraints.maxHeight * 0.2,
          ),
          Container( // we wrap the image in container so that BoxFit will calculate the hight of parent to set cover
            height: constraints.maxHeight * 0.6, // setting the 60% of the height
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    },) : ListView( // using keys with list view builder is not good that's why we are using normal List View
      children: transactions.map((tx) {
        return TransactionItem(
          key: ValueKey(tx.id), // passing the unique key
          transaction: tx, 
          deleteTx: deleteTx
        );
      }).toList(),
    );
  }
}

