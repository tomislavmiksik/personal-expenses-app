import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double moneySpent;
  final double spendingPctOfTotal;
  final String txType;

  ChartBar(this.label, this.moneySpent, this.spendingPctOfTotal, this.txType);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '€${moneySpent.toStringAsFixed(0)}',
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              width: 10,
              child: Stack(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.6,
                    width: 10,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      color: Color(0xffffffff),
                      //borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: txType == "expense" ? Color(0xFFFF4C29) : Color(0xFF57CC99),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
    },);
  }
}
