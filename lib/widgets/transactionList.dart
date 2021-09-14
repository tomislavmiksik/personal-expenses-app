import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  Color getColor(bool transaction) {
    if (!transaction) {
      return Color(0xFFe74c3c);
    } else {
      return Color(0xFF00b894);
    }
  }

  final List<Transaction> _userTransactions;
  final Function deleteTx;

  TransactionList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    int lng = _userTransactions.length;
    return Container(
      //height: MediaQuery.of(context).size.height * 0.6,
      child: _userTransactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nothing to see here',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]);
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  color: Color(0xFF2d3436),
                  shadowColor: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        color: getColor(
                            _userTransactions[lng - index - 1].transactionType),
                      )),
                  child: ListTile(
                    tileColor: Colors.transparent,
                    contentPadding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        style: BorderStyle.none,
                      ),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff202323),
                              ),
                            ),
                            onPressed: () => deleteTx(lng - index - 1),
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFFe74c3c),
                            ),
                            label: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFFe74c3c),
                            ),
                            onPressed: () => deleteTx(lng - index - 1),
                          ),
                    //amount
                    leading: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: FittedBox(
                          child: Text(
                            _userTransactions[lng - index - 1].transactionType
                                ? '€${_userTransactions[lng - index - 1].amount.toStringAsFixed(2)}'
                                : '-€${_userTransactions[lng - index - 1].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: getColor(_userTransactions[lng - index - 1]
                                  .transactionType),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[lng - index - 1].title,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(_userTransactions[lng - index - 1].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
/*Card(
                    /*color: getColor(
                        _userTransactions[lng - index - 1].transaction),*/
                    color: Color(0xff353d3f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //indicator of expense/income
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 8,
                          height: 50,
                          color: getColor(_userTransactions[lng - index - 1]
                              .transactionType),
                          child: Text(" "),
                        ),
                        //amount of transaction
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          width: 130,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            _userTransactions[lng - index - 1].transactionType
                                ? '€${_userTransactions[lng - index - 1].amount.toStringAsFixed(2)}'
                                : '-€${_userTransactions[lng - index - 1].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                        //name of transaction
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          alignment: AlignmentDirectional.center,
                          width: 150,
                          child: Column(
                            children: <Widget>[
                              Text(
                                _userTransactions[lng - index - 1].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                  DateFormat.yMMMd().format(
                                      _userTransactions[lng - index - 1].date),
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        )
                      ],
                    ));*/
