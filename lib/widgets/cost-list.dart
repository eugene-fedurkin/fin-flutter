import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/db/database.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/models/cost.dart';

class CostList extends StatefulWidget {
  const CostList({Key? key}) : super(key: key);

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
    costs = DBProvider.db.getCosts(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cost>>(
        future: costs,
        builder: (context, projectSnap) {
          final data = projectSnap.data;

          if (data == null) {
            return Text('No Data');
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final category = categories
                  .firstWhere((element) => element.name == data[index].name);

                  // return Card(

                  // );

              return ListTile(
                title: Text(data[index].name),
                trailing: Text('${data[index].sum} Br'),
                leading: Container(
                  child: Icon(category.icon),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: category.color,
                  )
                ),
              );
            },
          );
        });
  }
}
