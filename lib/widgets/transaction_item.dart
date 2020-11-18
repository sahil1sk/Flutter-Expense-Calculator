import 'dart:math'; // for using Random

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key); // initatze the key to the parent

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)]; // generate radndom number b/w 0,1,2,3
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical:8,
        horizontal: 5
      ),
      elevation: 5,
      child: ListTile( // helps to make easy styled element
        leading: CircleAvatar( // leading is the first part
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox( // means the data will be set into it's our box only srink the size if the number is large not go to another line
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text( // setting the title
          widget.transaction.title,
          style: Theme.of(context).textTheme.title, // setting the style of text which we configure at theme
        ),
        subtitle: Text( // helps to set the subtitle
          DateFormat.yMMMd().format(widget.transaction.date),
        ), // trailing will help to show the last side element like leading showing first
        trailing: MediaQuery.of(context).size.width > 460 ? 
        FlatButton.icon(
          onPressed: () => widget.deleteTx(widget.transaction.id), 
          icon: const Icon(Icons.delete), // use const if widget remain same so that it will not rebuild again when the build method is called
          label: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
        )
        :IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor, // getting the error color from the theme
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ),
      ),
    );
  }
}