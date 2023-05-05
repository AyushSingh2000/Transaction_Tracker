import 'package:flutter/material.dart';
import 'package:untitled/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transactions.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.amber),
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(titleTextStyle:TextStyle(fontFamily:'Montserrat', fontSize: 20)  ),
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions =[
 /*   Transaction(
        id: '1',
        title: 'suyash',
        amount: 20,
        date: DateTime.now()),
    Transaction(
        id :'t2',
        title :'shirt',
        amount :30.99,
        date:DateTime.now()),  */
  ];
  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx){
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(days:7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle,double txAmount,DateTime chosenDate){
    final NewTx=Transaction( title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(NewTx);
    });


  }
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    },);
}

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx){
        return tx.id==id;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Tracker',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton( icon: Icon(Icons.add),onPressed: ()=>_startAddNewTransaction(context),),
        ],
      ),
      body: SingleChildScrollView(

       child:Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
           crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
            Chart(_recentTransactions),
          TransactionList(_userTransactions,_deleteTransaction),
      ],
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
        onPressed: ()=>_startAddNewTransaction(context),),
    );
  }
}
