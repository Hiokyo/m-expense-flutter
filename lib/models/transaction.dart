class Transaction {
  String _id;
  String _title;
  double _amount;
  String _destination;
  String _description;
  String _note;

  DateTime _date;

  String get txnId => _id;
  String get txnTitle => _title;
  double get txnAmount => _amount;
  String get txnDestination => _destination;
  String get txnDescription => _description;
  String get txnNote => _note;

  DateTime get txnDateTime => _date;

  Transaction(this._id, this._title, this._amount, this._date,
      this._destination, this._description, this._note);

  // convenience constructor to create a Transaction object
  Transaction.fromMap(Map<String, dynamic> map) {
    _id = map['id'].toString();
    _title = map['title'];
    _amount = map['amount'];
    _destination = map['destination'];
    _description = map['description'];
    _note = map['note'];

    _date = DateTime.parse(map['date']);
  }

  // convenience method to create a Map from this Transaction object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': int.tryParse(_id),
      'title': _title,
      'amount': _amount,
      'destination': _destination,
      'description': _description,
      'note': _note,
      'date': _date.toIso8601String()
    };
    if (_id != null) {
      map['id'] = int.tryParse(_id);
    }

    return map;
  }
}
