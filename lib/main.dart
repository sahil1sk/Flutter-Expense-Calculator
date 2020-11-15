import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple, //primarySwatch helps to generate number of shades like for primary color which is used by other widgets 
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),  
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1', 
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2', 
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  // this list we generate for passing the recent transactions
  List<Transaction> get _recentTransactions {
            // where method will use on list if true is return then element is kept otherwise not
    return _userTransactions.where((tx) {
      // so here we return date only of last 7 days
      // isAfter means return the date only after the date inside given
      return tx.date.isAfter( 
        DateTime.now().subtract(
          Duration(days: 7),
        ), 
      );
    }).toList(); // where will give us iterable back that's why we convert it to list
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount, 
      date: DateTime.now(), 
      id: DateTime.now().toString()
    ); 

    setState(() {
      _userTransactions.add(newTx);
    });
  }


  void _startAddNewTransaction(BuildContext ctx) {
    // passing the context and builders argument has it's own context
    showModalBottomSheet(context: ctx, builder: (bCtx) {
      return NewTransaction(_addNewTransaction);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense', style: TextStyle(fontFamily: 'Open Sans'),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // now column will take all the width and there child also
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
