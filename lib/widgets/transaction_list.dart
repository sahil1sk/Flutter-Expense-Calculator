import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
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
    },) : ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: EdgeInsets.symmetric(
            vertical:8,
            horizontal: 5
          ),
          elevation: 5,
          child: ListTile( // helps to make easy styled element
            leading: CircleAvatar( // leading is the first part
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox( // means the data will be set into it's our box only srink the size if the number is large not go to another line
                  child: Text('\$${transactions[index].amount}'),
                ),
              ),
            ),
            title: Text( // setting the title
              transactions[index].title,
              style: Theme.of(context).textTheme.title, // setting the style of text which we configure at theme
            ),
            subtitle: Text( // helps to set the subtitle
              DateFormat.yMMMd().format(transactions[index].date),
            ), // trailing will help to show the last side element like leading showing first
            trailing: MediaQuery.of(context).size.width > 460 ? 
            FlatButton.icon(
              onPressed: () => deleteTx(transactions[index].id), 
              icon: Icon(Icons.delete), 
              label: Text('Delete'),
              textColor: Theme.of(context).errorColor,
            )
            :IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor, // getting the error color from the theme
              onPressed: () => deleteTx(transactions[index].id),
            ),
          ),
        );
      },     
      itemCount: transactions.length,
    );
  }
}