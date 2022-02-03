import 'package:organizer/models/category.dart';

class Cost {
  late int id;
  late DateTime date;
  late String name;
  late int sum;

  Cost(this.date, this.name, this.sum);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['date'] = date;
    map['name'] = name;
    map['sum'] = sum;

    return map;
  }

  Cost.fromMap(Map<String, dynamic>map) {
    id = map['id'];
    date = map['date'];
    name = map['name'];
    sum = map['sum'];
  }
}