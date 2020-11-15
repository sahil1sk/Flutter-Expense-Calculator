import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount, spendingPctOfTotal;

  ChartBar(
    this.label,
    this.spendingAmount,
    this.spendingPctOfTotal
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
        SizedBox(height: 4),  // for spacing of 4px
        Container(
          height: 60,
          width: 10,
          child: Stack( // helps to place one widget above another
            children: <Widget>[
              Container( // bottom element first
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius:  BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox( // allows me to create box that the faction of another value
                heightFactor: spendingPctOfTotal, // height between 0 and 1
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4), // for spacing
        Text(label),
      ],
    );
  }
}