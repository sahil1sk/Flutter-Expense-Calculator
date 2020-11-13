import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // List is of Transaction type
  final List<Transaction> transaction = [
    Transaction(
      id: 't1', 
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2', 
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ]; 

  // String titleInput;  
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // now column will take all the width and there child also
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.blue,
              child: Text('CHART!'),
              elevation: 5, // control shadow effect
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    //onChanged: (val) => titleInput = val,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    //onChanged: (val) => amountInput = val,
                  ),
                  FlatButton(
                    textColor: Colors.purple,
                    onPressed: () {
                      print(titleController.text);
                      //print(titleInput + amountInput);
                    }, 
                    child: Text('Add Transaction'),
                  )
                ],
              ),
            ),
          ),  
          Column(     // we don't use ... because we make list from class it's already a copy
            children: transaction.map((tx) {
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
                              color: Colors.purple,
                              width: 2,
                            ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                            '\$${tx.amount}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple,
                            ),
                          ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(tx.date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
