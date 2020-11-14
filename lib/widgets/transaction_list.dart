import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, 
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            'No Transactions added yet!',
            style: Theme.of(context).textTheme.title, // setting the style like the theme title style
          ),
          SizedBox( // this invisible box will help to create the space
            height: 10,
          ),
          Container( // we wrap the image in container so that BoxFit will calculate the hight of parent to set cover
            height: 250,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10, 
                    horizontal: 10
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, // getting the primary color
                        width: 2,
                      ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor, // setting the color which we define in the theme
                      ),
                    ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title, // setting the style of title which we define in app theme
                    ),
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },     
        itemCount: transactions.length,
      ),
    );
  }
}