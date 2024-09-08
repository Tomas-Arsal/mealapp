import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
class CategoryMealScreenState extends StatefulWidget {
  const CategoryMealScreenState({Key? key}) : super(key: key);
static const routeName = 'category_name';

  @override
  State<CategoryMealScreenState> createState() => _CategoryMealScreenStateState();
}

class _CategoryMealScreenStateState extends State<CategoryMealScreenState> {
 late List<Meal> disPlayedMeal;
  @override
  void didChangeDependencies() {
  final  List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeals;
    var routAg = ModalRoute.of(context)!.settings.arguments as Map<String , String> ;
    var rougeId = routAg['id'] ;
     disPlayedMeal = availableMeals.where((meal) {
      return meal.categories.contains(rougeId) ;
    }).toList() ;
super.didChangeDependencies() ;
  }
  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape ;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var routAg = ModalRoute.of(context)!.settings.arguments as Map<String , String> ;
    var rougeId = routAg['id'] ;

    return  Scaffold(
      appBar: AppBar(title:  Text(lan.getTexts('cat-$rougeId').toString()),),
      body: GridView.builder(
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          childAspectRatio: landscape? 2.60 / 2.20 : 2.14/2.20,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
        itemBuilder:(context ,index) {
      return MealItem(
        id: disPlayedMeal[index].id,
          affordability: disPlayedMeal[index].affordability,
          complexity: disPlayedMeal[index].complexity,
          duration: disPlayedMeal[index].duration,
          imageUrl: disPlayedMeal[index].imageUrl,
       ) ;
    } ,
    itemCount:disPlayedMeal.length,
    ),
);
  }
}
