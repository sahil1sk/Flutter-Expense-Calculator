import 'package:building_real_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // this package is for DateFormat

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  // constructor
  Chart(this.recentTransactions);

  // List<Map<String, Object>> return type creating the list of map which contains strings and objects
  List<Map<String, Object>> get groupedTransactionValues { // this is the getter
    // we are generating the list of 7 elements and return it 
    return List.generate(7, (index) {
      // making the weekday by subtracting the days from today using index like for todya index is 0 
      // then it will not subtract any day for 1 it will subtract one day
      final weekDay = DateTime.now().subtract(Duration(days: index), );  
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if( recentTransactions[i].date.day == weekDay.day && 
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year
        ){
          totalSum += recentTransactions[i].amount;
        }
      }
      
      // DateFormat.E this will give shortcut for weekday
      return {'day': DateFormat.E(weekDay), 'amount': totalSum};
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(children: <Widget>[

        ],
      ),
    );
  }
}