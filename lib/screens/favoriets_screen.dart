
import 'package:flutter/material.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape ;
    var dw = MediaQuery.of(context).size.width ;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List<Meal> favoriteMeals = Provider.of<MealProvider>(context , listen: true).favoriteMeals ;
    if (favoriteMeals.isEmpty) {
      return  Center(
        child: Text(lan.getTexts('favorites_text').toString(),),
      );
    } else {
      return GridView.builder(
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400? 400 :500,
          childAspectRatio: landscape? dw/(dw*0.40) : dw/(dw*0.90),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
