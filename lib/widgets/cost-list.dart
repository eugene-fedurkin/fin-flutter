import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/db/database.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/models/cost.dart';

class CostList extends StatefulWidget {
  final bool sum;

  const CostList({Key? key, required this.sum}) : super(key: key);

  @override
  _CostListState createState() => _CostListState();
}

class _CostListState extends State<CostList> {
  late Future<List<Cost>> costs;
  late List<Category> categories;

  @override
  void initState() {
    super.initState();

    categories = CategoriesApi().fetchCategories();
    costs = DBProvider.db.getCosts(widget.sum);
    print(widget.sum)
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cost>>(
        future: costs,
        builder: (context, projectSnap) {
          final data = projectSnap.data;

          if (data == null) {
            return const Text('No Data');
          }

          return ListView.builder(
            shrinkWrap: true,
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
