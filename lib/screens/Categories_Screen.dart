import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/widgets/Categorey_Item.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';

class Categories_Screen extends StatelessWidget {
  const Categories_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 3 / 3,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
        ),
        children:  Provider.of<MealProvider>(context).availableCategory
            .map((catData) => Categorey_Item(
            id: catData.id,  color: catData.color)
        )
            .toList(),

      ),
    );
  }
}
