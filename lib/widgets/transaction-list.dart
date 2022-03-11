import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/db/database.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/models/transaction.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late Future<List<TransactionModel>> transactions;
  late List<CategoryModel> categories;
  final formatter = DateFormat('MMM d, y');

  @override
  void initState() {
    super.initState();

    categories = CategoriesApi().fetchCategories();
    transactions = DBProvider.db.getTransactions(false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
        future: transactions,
        builder: (context, projectSnap) {
          final data = projectSnap.data;

          if (data == null) {
            return const Text('No Data');
          }

          return GroupedListView<TransactionModel, String>(
            elements: data,
            groupBy: (element) => formatter.format(element.date),
            groupSeparatorBuilder: (String groupByValue) => Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Container(
                  child: Text('$groupByValue${formatter.format(DateTime.now()) == groupByValue ? ' (Today)' : ''}'),
                  padding: const EdgeInsets.only(
                      top: 3, bottom: 3, left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.cyan.shade50),
                )),
            itemBuilder: (context, element) {
              final category = categories
                  .firstWhere((cat) => cat.name == element.name);

              return Card(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                          child: Icon(
                            category.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: category.color,
                          )),
                      Text(
                        element.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      Text('${element.sum} Br')
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
