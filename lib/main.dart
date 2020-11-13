import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHART!'),
              elevation: 5, // control shadow effect
            ),
          ),
          Column(
            children: transaction.map((tx) {
              return Card(child: Text(tx.title),);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
