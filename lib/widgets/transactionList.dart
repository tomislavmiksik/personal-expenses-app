import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  Color getColor(bool transaction) {
    if (!transaction) {
      return Color(0xFFFF4C29);
    } else {
      return Color(0xFF57CC99);
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
                return Column(
                  children: [
                    Card(
                      shadowColor: Colors.transparent,
                      elevation: 5,
                      //: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      child: ListTile(
                        //tileColor: getColor(_userTransactions[lng - index - 1]
                        //  .transactionType),
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
                                    // backgroundColor: MaterialStateProperty.all<Color>(
                                    //   Color(0xff202323),
                                    // ),
                                    ),
                                onPressed: () => deleteTx(lng - index - 1),
                                icon: Icon(
                                  Icons.delete,
                                  color: Color(0xFFe74c3c),
                                ),
                                label: Text(
                                  "Delete",
                                  // style: TextStyle(
                                  //   color: Colors.white,
                                  // ),
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () => deleteTx(lng - index - 1),
                              ),
                        //amount
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: getColor(_userTransactions[lng - index - 1].transactionType),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: FittedBox(
                              child: Text(
                                _userTransactions[lng - index - 1].transactionType
                                    ? '€${_userTransactions[lng - index - 1].amount.toStringAsFixed(2)}'
                                    : '-€${_userTransactions[lng - index - 1].amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: getColor(_userTransactions[lng - index - 1].transactionType),
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          _userTransactions[lng - index - 1].title,
                          style: TextStyle(
                            //color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd()
                              .format(_userTransactions[lng - index - 1].date),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
