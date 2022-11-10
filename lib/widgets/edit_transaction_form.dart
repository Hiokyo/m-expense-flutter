import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTransactionForm extends StatefulWidget {
  final Function _editTransaction;

  EditTransactionForm(this._editTransaction);

  @override
  _EditTransactionFormState createState() => _EditTransactionFormState();
}

class _EditTransactionFormState extends State<EditTransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _destinationController = TextEditingController();
  final _riskController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _titleFocus = FocusNode();
  final _amountFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _timeFocus = FocusNode();
  final _destinationFocus = FocusNode();
  final _riskFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _noteFocus = FocusNode();

  // bool _autoValidateToggle = false;
  AutovalidateMode _autoValidateToggle = AutovalidateMode.disabled;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  _EditTransactionFormState() {
    bool _autoValidateToggle = false;
    _selectedDate = DateTime.now();
    _selectedTime = null;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900, 1),
      lastDate: today,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.value =
            TextEditingValue(text: DateFormat('d/M/y').format(pickedDate));
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.value = TextEditingValue(
            text: DateFormat.jm().format(
          DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
          ),
        ));
      });
    }
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _onSubmit() {
    if (_formKey.currentState.validate()) {
      final txnTitle = _titleController.text;
      final txnDestination = _destinationController.text;
      final txnDescription = _descriptionController.text;
      final txnNote = _noteController.text;

      final txnAmount = double.parse(_amountController.text);
      final txnDateTime = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, _selectedTime.hour, _selectedTime.minute);

      widget._editTransaction(txnTitle, txnAmount, txnDateTime, txnDestination,
          txnDescription, txnNote);
      Navigator.of(context).pop();
    } else {
      bool _autoValidateToggle = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),

            // Title TextField
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter a title",
                isDense: true,
                contentPadding: EdgeInsets.all(8),
              ),
              validator: (value) {
                if (value.isEmpty) return "Title cannot be empty";
                return null;
              },
              autovalidateMode: _autoValidateToggle,
              focusNode: _titleFocus,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _titleFocus, _amountFocus),
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 5.0,
            ),

            // Amount TextField
            TextFormField(
              focusNode: _amountFocus,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.local_atm),
                hintText: "Enter the amount",
                isDense: true,
                contentPadding: EdgeInsets.all(8),
              ),
              autovalidateMode: _autoValidateToggle,
              validator: (value) {
                RegExp regex = RegExp('[0-9]+(\.[0-9]+)?');
                if (!regex.hasMatch(value) || double.tryParse(value) == null)
                  return "Please enter valid amount";
                return null;
              },
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _amountFocus, _destinationFocus),
              controller: _amountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),

            SizedBox(
              height: 5.0,
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter Destination",
                isDense: true,
                contentPadding: EdgeInsets.all(8),
              ),
              validator: (value) {
                if (value.isEmpty) return "Destination cannot be empty";
                return null;
              },
              autovalidateMode: _autoValidateToggle,
              focusNode: _destinationFocus,
              onFieldSubmitted: (_) => _fieldFocusChange(
                  context, _destinationFocus, _descriptionFocus),
              controller: _destinationController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 5.0,
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter Description",
                isDense: true,
                contentPadding: EdgeInsets.all(8),
              ),
              validator: (value) {
                if (value.isEmpty) return "Description cannot be empty";
                return null;
              },
              autovalidateMode: _autoValidateToggle,
              focusNode: _descriptionFocus,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _descriptionFocus, _noteFocus),
              controller: _descriptionController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 5.0,
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Note ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter Note",
                isDense: true,
                contentPadding: EdgeInsets.all(8),
              ),
              validator: (value) {
                if (value.isEmpty) return "Note cannot be empty";
                return null;
              },
              autovalidateMode: _autoValidateToggle,
              focusNode: _noteFocus,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _noteFocus, _dateFocus),
              controller: _noteController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 5.0,
            ),
            // Date and Time Textfield
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Date TextField
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        focusNode: _dateFocus,
                        keyboardType: TextInputType.datetime,
                        onFieldSubmitted: (_) =>
                            _fieldFocusChange(context, _dateFocus, _timeFocus),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          labelText: 'Date',
                          hintText: 'Date of Transaction',
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        autovalidateMode: _autoValidateToggle,
                        validator: (value) {
                          if (value.isEmpty) return "Please select a date";
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 5.0,
                ),
                // Time TextField
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _timeController,
                        focusNode: _timeFocus,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          labelText: 'Time',
                          hintText: 'Time of Transaction',
                          prefixIcon: Icon(Icons.schedule),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        autovalidateMode: _autoValidateToggle,
                        validator: (value) {
                          if (value.isEmpty) return "Please select a date";
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 15.0,
            ),

            // Add Transaction Button
            SizedBox(
              width: double.infinity,
              height: 40.0,
              child: ElevatedButton.icon(
                icon: Icon(Icons.check),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(25.0)),
                label: Text(
                  'ADD TRANSACTION',
                  style: TextStyle(
                    fontFamily: "Rubik",
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                // textColor: Colors.white,
                // color: Colors.green[700],
                onPressed: _onSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
