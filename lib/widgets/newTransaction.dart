import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTx;

  NewTransaction(this._addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String dropdownValue = 'expense';
  final _titleController = TextEditingController();
  final txController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final txType = dropdownValue;
    final date = _selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addNewTx(enteredTitle, enteredAmount, txType, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          margin: EdgeInsets.all(0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            //height: ,
            padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFF2d3436),
            ),
            //color: Color(0xFF00b894),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hoverColor: Colors.white,
                  ),
                  controller: _titleController,
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(

                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixText: '€',
                    prefixStyle: TextStyle(color: Colors.white, fontSize: 16),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hoverColor: Colors.white,
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        dropdownColor: Color(0xFF2d3436),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['expense', 'income']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        autofocus: true,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            OutlinedButton(
                              child: Text(
                                _selectedDate == null
                                    ? 'No Date Chosen'
                                    : DateFormat.yMMMd().format(_selectedDate),
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: _selectedDate == null
                                    ? MaterialStateProperty.all<Color>(
                                        Color(0xFFe74c3c))
                                    : MaterialStateProperty.all<Color>(
                                        Color(0xff10ac84)),
                              ),
                              onPressed: _presentDatePicker,
                            ),
                            // FloatingActionButton(
                            //   mini: true,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10)),
                            //   child: Icon(Icons.calendar_today),
                            //   onPressed: _presentDatePicker,
                            // )
                          ]),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff10ac84),
                              ),
                              child: Text('Add transaction',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: _submitData,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
