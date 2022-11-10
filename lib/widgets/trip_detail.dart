import 'package:expense_manager_flutter/helpers/database_helper.dart';
import 'package:expense_manager_flutter/models/transaction.dart';
import 'package:expense_manager_flutter/widgets/edit_transaction_form.dart';
import 'package:expense_manager_flutter/widgets/new_transaction_form.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Transaction trip;

  DetailPage(this.trip, {Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

Future<void> _editTransaction(String id ,String title, double amount, DateTime chosenDate,
    String destination, String description, String note) async {
  final newTxn = Transaction(
    DateTime.now().millisecondsSinceEpoch.toString(),
    title,
    amount,
    chosenDate,
    destination,
    description,
    note,
  );
  int res = await DatabaseHelper.instance.updateTransactionById(int.tryParse(id),newTxn);

  // if (res != 0) {
  //   _updateUserTransactionsList();
  // }
}

void _startEditTransaction(BuildContext context) {
  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: EditTransactionForm(_editTransaction),
      );
    },
  );
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.trip.txnTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _startEditTransaction(context),
              tooltip: "Add New Trip",
            ),
          ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Text("Title:" + widget.trip.txnTitle.toString()),
              Text("Amount:" + widget.trip.txnAmount.toString()),
              Text("Destination:" + widget.trip.txnDestination.toString()),
              Text("Description:" + widget.trip.txnDescription.toString()),
              Text("Note:" + widget.trip.txnNote.toString()),
              Text("Date:" + widget.trip.txnDateTime.toString()),
            ],
          ),
        ));
  }
}
