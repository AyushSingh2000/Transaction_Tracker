import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();

  final _amountController=TextEditingController();
   DateTime? _selectedDate;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final _enteredTitle=_titleController.text;
    final _enteredAmount=double.parse(_amountController.text);

    if(_enteredTitle.isEmpty||_enteredAmount<=0||_selectedDate==null)
      {
        return ;
      }


    widget.addTx(
        _enteredTitle,
        _enteredAmount,
        _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate:DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate==null){
        return;
      }
      setState(() {
        _selectedDate=pickedDate;
      });

    });
  }



  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:<Widget>[
                TextField(
                  decoration:
                  InputDecoration(labelText: 'Product'),
                  controller: _titleController,
                  onSubmitted: (_)=> _submitData,

                  /* onChanged: (value){
                      titleInput=value;
                    },*/
                ),
                TextField(
                  decoration:
                  InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType:TextInputType.number,
                  onSubmitted: (_)=> _submitData,
                  /*  onChanged: (value){
                      amountInput=value;
                    },*/
                ),
                Container(
                  height: 70,
                  child:Row(
                  children:<Widget>[
                    Expanded(child:
                    Text(_selectedDate==null?'No Date Chosen':
                    'Selected Date:${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                    ),
                    TextButton(
                        child: Text('Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold,),),
                        onPressed: _presentDatePicker)

                  ],

                ),
                ),
                ElevatedButton(
                  child:
                  Text('Add Transaction',style: TextStyle(color: Colors.white),),
                  onPressed:_submitData,
                 ),
              ],
            )
        )
    );
  }
}