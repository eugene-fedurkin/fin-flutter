class TransactionModel {
  late int? id;
  late DateTime date;
  late String name;
  late int sum;

  TransactionModel(this.date, this.name, this.sum, this.id);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date.microsecondsSinceEpoch;
    map['name'] = name;
    map['sum'] = sum;

    return map;
  }

  TransactionModel.fromMap(Map<String, dynamic>map) {
    id = map['id'];
    date = DateTime.fromMicrosecondsSinceEpoch(map['date']);
    name = map['name'];
    sum = map['sum'];
  }
}