import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';
import './chartBar.dart';

class IncomeChart extends StatelessWidget {
  final List<Transaction> transactions;

  IncomeChart(this.transactions);


  List<Map<String, Object>> get groupedIncVal {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = 0;
      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year && transactions[i].transactionType == true) {
          sum += transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }


  double get maxIncome {
    return groupedIncVal.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.21,
      child: Card(
        elevation: 6,
        //color: Color(0xFF082032),
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedIncVal.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    e['day'],
                    e['amount'],
                    maxIncome == 0.0 ? 0.0 : (e['amount'] as double) / maxIncome, "income"),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
