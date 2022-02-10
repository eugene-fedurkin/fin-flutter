import 'package:flutter/material.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/constants/route.dart';
import 'package:organizer/db/database.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/models/cost.dart';
import 'package:organizer/providers/shared_state.dart';
import 'package:organizer/widgets/amount_input.dart';
import 'package:organizer/widgets/categoies.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late List<Category> categories;
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    categories = CategoriesApi().fetchCategories();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sharedState = Provider.of<SharedState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Money'),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.my_location),
        //   onPressed: () {},
        // ),
        actions: [
          PopupMenuButton(
            onSelected: (String result) { setState(() { Navigator.pushNamed(context, result); }); },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: AMOUNTS_ROUTE,
                child: Text('Total'),
              ),
              const PopupMenuItem(
                value: TRANSACTIONS_ROUTE,
                child: Text('Transactions'),
              )
            ]

          ),
        ],
      ),
      body: Wrap(
        children: [
          Column(
            children: [
              AmountInput(controller: _inputController),
              Categories(categories: categories),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final categoryName = sharedState.activeCategory?.name;

          if (categoryName != null) {
            DBProvider.db.insertCost(
              Cost(
                DateTime.now(),
                categoryName,
                int.parse(_inputController.text),
                null
              )
            );

            _inputController.text = '';
          }
        },
        icon: const Icon(Icons.edit),
        label: const Text('Add Amount'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
