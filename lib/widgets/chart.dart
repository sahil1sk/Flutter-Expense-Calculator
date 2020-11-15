import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // this package is for DateFormat

import './chart_bar.dart';
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
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1), 
        'amount': totalSum
      };
      // this is for reverse the list // here we reverse the list to show the today first
    }).reversed.toList();
  }


  // getting the total spending of the week
  double get totalSpending {
    // fold funtion like reduce funtion of javascript
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding( // if you want to set only the padding then use Padding widget don't need to use container
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // for setting all the rows evenly spaced we use spaceAround
          children: groupedTransactionValues.map((data) {   
              return Flexible( // for setting the flexible size
                fit: FlexFit.tight,  // so here we set the the each chart bar will fix in it's our size
                child: ChartBar(
                  data['day'], 
                  data['amount'],   // if toalSpending is 0 then pass 0 no need to divide by zero
                  totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending //// getting the percentage of day amount from the total spending
                ),
              );
            }
          ).toList(),
        ),
      ),
    );
  }
}