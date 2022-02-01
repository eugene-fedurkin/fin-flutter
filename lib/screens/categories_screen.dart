import 'package:flutter/material.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/models/category.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Money'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_city),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Wrap(
          children: [
            Column(
              children: [
                AmountInput(controller: _inputController),
                // TextFormField(
                //   controller: _inputController,

                // ),
                Categories(categories: categories),
                Text('2'),
                Text('3'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(_inputController.text);
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
