import 'package:flutter/material.dart';
//import 'package:flutter/services.dart'; // we import for using SystemChrome

import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() { 
  // WidgetsFlutterBinding.ensureInitialized(); // for lates version we need to confine this before using given setting
  // // so here in this we allow on portraitUp and portraitDown setting not allowing landscape setting
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple, //primarySwatch helps to generate number of shades like for primary color which is used by other widgets 
        fontFamily: 'QuickSand',
        errorColor: Colors.red,
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

  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

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

  void _addNewTransaction(String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount, 
      date: choosenDate, 
      id: DateTime.now().toString()
    ); 

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  // for adding new transaction
  void _startAddNewTransaction(BuildContext ctx) {
    // passing the context and builders argument has it's own context
    // this is the built in funtion to showing the bottom sheet
    showModalBottomSheet(context: ctx, builder: (bCtx) {
      return NewTransaction(_addNewTransaction); // passing the widget which we want to show in the bottom sheet
    },);
  }

  // for deleteing transaction
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }


  @override
  Widget build(BuildContext context) {

    // if we use appBar in this way this will help to give the appBar height 
    final appBar = AppBar(
        title: Text('Personal Expense', style: TextStyle(fontFamily: 'Open Sans'),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // now column will take all the width and there child also
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center, // center all the content inside the row
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
              ],
            ),
            _showChart // if true then we will show chart otherwise list 
            ? Container(  // getting the 70% of height and deducting the appBar height and top padding
                height: ( MediaQuery.of(context).size.height - 
                          appBar.preferredSize.height - 
                          MediaQuery.of(context).padding.top ) * 0.7,
                child: Chart(_recentTransactions),
              )
            : Container( // getting the 70% of height and deducting the appBar height and top padding
                height: ( MediaQuery.of(context).size.height - 
                          appBar.preferredSize.height - 
                          MediaQuery.of(context).padding.top ) * 0.7,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
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
