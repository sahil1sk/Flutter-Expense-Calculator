import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
 
  NewTransaction(this.addTx) {
    print('Constructor function is called!');
  }

  @override
  _NewTransactionState createState() { 
    print('createState funtion is called!');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate; // type of DateTime

  _NewTransactionState() {
    print('Construction of State is called');
  }

  @override   // initState method is provided by the State
  void initState() { // initState funtion will called once one the state is created
    super.initState(); // so here we call the State initState funtion
    print('initState() is called');
  }

  // this function is called whenever there is change in the parent widget
  @override // method provide by the state
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget); // calling the method in the state class
    print('didUpdateWidget() is called');
  }

  @override
  void dispose() { // this function is called when the widget is removed
    super.dispose();
    print('dispose funtion is called');
  }

  void _submitData() {
    if(_amountController.text.isEmpty) return; // if amount is not there then also return  becasue we don't want to do conversion
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) return;
    // widget.addTx helps to call the pointer which is at its widget class means in NewTransaction class
    widget.addTx(enteredTitle, enteredAmount, _selectedDate); // calling function and setting data into list
    // the given line will help to turn of the top most screen 
    // we used here to disable modal 
    Navigator.of(context).pop(); // context auto available
  }

  // this function is trigger when we click the select date button
  void _presentDatePicker() {
    // built in funtion to show the date picker
    showDatePicker( // this function is like async and await
      context: context, // context available in stateful widget globally
      initialDate: DateTime.now(), // already selected date
      firstDate: DateTime(2019),  // the past date the person will able to chose
      lastDate: DateTime.now(),   // the future date person will able to choose
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;    
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView( // we set that when the padding is added then the list will become scrollable bcause built in bottom sheet have configured size
        child: Container(
          padding: EdgeInsets.only(
            top: 10, 
            left: 10, 
            right: 10, 
            bottom: MediaQuery.of(context).viewInsets.bottom + 10, // viewInsets.bottom adding for when keyboard will appear 
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number, //In IOS numberWithOptions(decimal:true),
                onSubmitted: (_) => _submitData(), // so we dont' want to use value then use _ 
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded( // this will take as much space available
                      child: Text(_selectedDate == null 
                        ? 'No Date Chosen!' 
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker, // this function will help to show the date picker
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor, // getting the primary color from the theme
                textColor: Theme.of(context).textTheme.button.color, // getting the color from the app theme which we set in main.dart file
                onPressed: _submitData,
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}