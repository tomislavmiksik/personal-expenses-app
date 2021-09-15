import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;
  final _selectedDate;
  AdaptiveFlatButton(this.text, this.handler, this._selectedDate);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? OutlinedButton(
      child: Text(
        _selectedDate == null
            ? text
            : DateFormat.yMMMd()
            .format(_selectedDate),
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor: _selectedDate == null
            ? MaterialStateProperty.all<Color>(
            Color(0xFFe74c3c))
            : MaterialStateProperty.all<Color>(
            Color(0xff10ac84)),
      ),
      onPressed: handler,
    )
        : CupertinoButton(
      child: Text(
        _selectedDate == null
            ? text
            : DateFormat.yMMMd()
            .format(_selectedDate),
        style: TextStyle(color: Colors.white),
      ),
      color: _selectedDate == null
          ? Color(0xFFe74c3c)
          : Color(0xff10ac84),
      onPressed: handler,
    );
  }
}
