import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

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
          UserTransactions(),
        ],
      ),
    );
  }
}
