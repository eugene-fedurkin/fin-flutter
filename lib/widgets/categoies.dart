import 'package:flutter/material.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/providers/shared_state.dart';
import 'package:provider/provider.dart';


class Categories extends StatelessWidget {
  const Categories({Key? key, required this.categories}) : super(key: key);

  final List<CategoryModel> categories;

 @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return GridTile(
                child: CategoryTile(
              category: categories[index],
            ));
          },
        ));
  }
}

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<SharedState>(context);

    return GestureDetector(
      onTap: () {
        _state.selectCategory(category);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        alignment: Alignment.center,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _state.activeCategory == category
                ? _state.activeCategory?.color
                : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Icon(category.icon, color: Colors.white, size: 50,),
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: category.color,
                )),
            Text(
              category.name,
              style: TextStyle(
                  color: _state.activeCategory == category
                      ? Colors.white
                      : category.color),
            )
          ],
        ),
      ),
    );
  }
}
