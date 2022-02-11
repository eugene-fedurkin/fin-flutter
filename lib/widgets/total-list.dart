import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/db/database.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/models/transaction.dart';

class TotalList extends StatefulWidget {
  const TotalList({Key? key}) : super(key: key);

  @override
  _TotalListState createState() => _TotalListState();
}

class _TotalListState extends State<TotalList> {
  late Future<List<TransactionModel>> costs;
  late List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();

    categories = CategoriesApi().fetchCategories();
    costs = DBProvider.db.getTransaction(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
        future: costs,
        builder: (context, projectSnap) {
          final data = projectSnap.data;

          if (data == null) {
            return const Text('No Data');
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final category = categories
                  .firstWhere((element) => element.name == data[index].name);

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
                        data[index].name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      Text('${data[index].sum} Br')
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
