import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
 
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0) return;
    // widget.addTx helps to call the pointer which is at its widget class means in NewTransaction class
    widget.addTx(enteredTitle, enteredAmount); // calling function and setting data into list
    // the given line will help to turn of the top most screen 
    // we used here to disable modal 
    Navigator.of(context).pop(); // context auto available
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number, //In IOS numberWithOptions(decimal:true),
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              textColor: Colors.purple,
              onPressed: submitData,
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}