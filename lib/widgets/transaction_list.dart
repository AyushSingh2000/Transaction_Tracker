import 'package:flutter/material.dart';
import '../models/transactions.dart';
import'package:intl/intl.dart';


class TransactionList extends StatelessWidget {

final List<Transaction> transactions;
final Function deleteTx;

TransactionList(this.transactions,this.deleteTx );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,

        child:transactions.isEmpty?Column(
          children: <Widget>[
            Text('No transaction',
            ),
            SizedBox(
              height:100,
            ),
            Container(
              height:200,
             child: Image.asset('assests/images/pngegg.png',
             fit:BoxFit.cover,
           ),
            ),
          ],
        ): ListView.builder(
          itemBuilder: (ctx,index) {
            return Card(
            elevation: 5,
            margin:EdgeInsets.symmetric(vertical: 8,horizontal: 5),
              child:ListTile(
                leading:
                CircleAvatar(
                  radius: 30,
                   child: Padding(
                     padding: EdgeInsets.all(10),
                   child:Text('\₹${transactions[index].amount}',
                   style: TextStyle(fontSize:10),),
                   ),
                ),
                title:Text(transactions[index].title.toString(),
                style:Theme.of(context).textTheme.titleSmall,
                ),
                subtitle:
                Text(DateFormat.yMMMd().format(transactions[index].date as DateTime),),
                trailing: IconButton(icon:Icon(Icons.delete),
                  onPressed: ()=>deleteTx(transactions[index].id)),
              ),
            );
          },
          itemCount: transactions.length,

        ),

    );
  }
}

