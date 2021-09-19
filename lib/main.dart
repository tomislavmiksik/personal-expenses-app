import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/incomeChart.dart';
import './widgets/newTransaction.dart';
import './widgets/transactionList.dart';
import './models/transaction.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   //systemNavigationBarColor: Color(0xFF596275),
  //   systemStatusBarContrastEnforced: true,
  //   //statusBarColor: Color(0xFF0652DD),
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            title: 'Expense manager',
            home: MyHomePage(),
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.red,
              fontFamily: 'OpenSans',
              backgroundColor: Color(0xFF2c2c54),
            ),
          )
        : CupertinoApp(
            title: 'Expense manager',
            home: MyHomePage(),
            theme: CupertinoThemeData(
                //primaryColor: Colors.teal,
                //primaryContrastingColor: Color(0xFF0652DD),
                ),
          );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 0,
      title: 'New phone',
      amount: 349.99,
      date: DateTime.now(),
      transactionType: false,
    ),
    Transaction(
      id: 1,
      title: 'Paycheck',
      amount: 1000.00,
      date: DateTime.now(),
      transactionType: true,
    ),
    Transaction(
      id: 2,
      title: 'Headphones',
      amount: 459.99,
      date: DateTime.now().subtract(Duration(days: 1)),
      transactionType: false,
    ),
    Transaction(
      id: 3,
      title: 'Gas',
      amount: 50,
      date: DateTime.now().subtract(Duration(days: 3)),
      transactionType: false,
    ),
    Transaction(
      id: 4,
      title: 'Sale',
      amount: 320,
      date: DateTime.now().subtract(Duration(days: 1)),
      transactionType: true,
    ),
    Transaction(
      id: 5,
      title: 'Groceries',
      amount: 15.45,
      date: DateTime.now(),
      transactionType: false,
    )
  ];

  bool _chartToggle = true;

  List<Transaction> get _recentTx {
    return _userTransactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(
      String title, double amount, String txType, DateTime txDate) {
    final Transaction newTransaction = Transaction(
        id: _userTransactions.length + 1,
        title: title,
        amount: amount,
        date: txDate,
        transactionType: txType == 'expense' ? false : true);
    print(_userTransactions.length.toString());
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  int _widgetIndex = 0;
  bool _widgetToggle = true;

  void _deleteTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  void _startNewTx(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      backgroundColor: Color(0xFF84817a),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    final PreferredSizeWidget appBar = Platform.isAndroid
        ? AppBar(
            title: Text('Expense manager'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => _startNewTx(context),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  )),
            ],
          )
        : CupertinoNavigationBar(
            //backgroundColor: Color(0xFF0652DD),
            middle: Text(
              'Expense manager',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    //color: Colors.grey,
                  ),
                  onTap: () => _startNewTx(context),
                ),
              ],
            ),
          );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _chartToggle
              ? Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: Card(
                    //color: ,
                    child: Container(
                      child: Container(
                        height: MediaQuery.of(context).orientation == Orientation.landscape
                            ? (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.60
                            : (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.22,
                        child: ListView(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.9,
                                child: Chart(_recentTx)),
                            //Container(width: 100,),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: IncomeChart(_recentTx)),
                          ],
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    elevation: 0,
                  ),
                )
              : Container(),
          if (MediaQuery.of(context).orientation == Orientation.landscape)
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Chart",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Platform.isAndroid
                      ? Switch(
                          value: _chartToggle,
                          onChanged: (val) {
                            setState(() {
                              _chartToggle = val;
                            });
                          },
                          //activeColor: Color(0xFF0652DD),
                        )
                      : CupertinoSwitch(
                          value: _chartToggle,
                          onChanged: (val) {
                            setState(() {
                              _chartToggle = val;
                            });
                          },
                        ),
                ],
              ),
            ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.70,
            child: TransactionList(_userTransactions, _deleteTransaction),
          ),
        ],
      ),
    ));

    return MaterialApp(
      theme: ThemeData(
        canvasColor: Color(0xFF082032),
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        cardTheme: CardTheme(
          color: Color(0xFF2C394B),
          shadowColor: Colors.transparent,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            color: Color(0xE8CECECE),
          ),
          subtitle2: TextStyle(
            color: Color(0x7BCECECE),
          ),
          caption: TextStyle(
            color: Color(0x7BCECECE),
          ),
        ),
        fontFamily: 'OpenSans',
        backgroundColor: Color(0xFF2c2c54),
      ),
      //darkTheme: ThemeData(),
      home: Platform.isAndroid
          ? Scaffold(
              //backgroundColor: Color(0xFF596275),
              appBar: appBar,
              body: pageBody,
              floatingActionButton: FloatingActionButton(
                //backgroundColor: Color(0xFF0652DD),
                child: Icon(Icons.add_to_photos),
                onPressed: () => _startNewTx(context),
              ),
            )
          : CupertinoPageScaffold(
              //backgroundColor: Color(0xFF596275),
              child: pageBody,
              navigationBar: appBar,
            ),
    );
  }
}
