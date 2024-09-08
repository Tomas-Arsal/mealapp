import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeMealDetailScreen = 'meal-details';

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape ;
    var dw = MediaQuery.of(context).size.width ;

    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List<String> ingredmentlint =
        lan.getTexts('ingredients-$mealId')as List<String>;
    var ListIngrement = GridView.builder(
      padding: EdgeInsets.all(0),
      gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: dw <= 400? 400 :500,
        childAspectRatio: landscape? dw/(dw*0.12) : dw/(dw*0.12),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
      itemBuilder: (ctx, index) => Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(ingredmentlint[index])),
      ),
      itemCount: ingredmentlint.length,
    );
    List<String> stepsli = lan.getTexts('steps-$mealId') as List<String>;
    var ListSteps = GridView.builder(
      padding: EdgeInsets.all(0),
      gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: dw <= 400? 400 :500,
        childAspectRatio: landscape? dw/(dw*0.40) : dw/(dw*0.28),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${(index + 1)}'),
            ),
            title: Text(
             stepsli[index],
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const Divider()
        ],
      ),
      itemCount: stepsli.length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId').toString()),
                background:  Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/a2.png'),
                      image: NetworkImage(
                        selectedMeal.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if(landscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                      buildSectionTitle(context, lan.getTexts('Ingredients').toString() ),
                      buildContainer(
                        ListIngrement, context,
                      ),
                    ],),
                    Column(children: [
                      buildSectionTitle(context, lan.getTexts('Steps').toString() ),
                      buildContainer(
                        ListSteps, context,
                      ),
                    ],),
                  ],),

              if(!landscape)
                buildSectionTitle(context, lan.getTexts('Ingredients').toString() ),
              if(!landscape)
                buildContainer(
                  ListIngrement , context,
                ),
              if(!landscape)
                buildSectionTitle(context, lan.getTexts('Steps').toString() ),
              if(!landscape)
                buildContainer(
                  ListSteps, context,
                ),
            ]))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Provider.of<MealProvider>(context, listen: true)
                    .isFavorite(mealId)
                ? Icons.star
                : Icons.star_border,
          ),
          // ال onpressed  لا يستخدم معها listen  هيسبب ايرور لانه بيسمع تلقائى .....
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId),
        ),
      ),
    );
  }
}

Widget buildSectionTitle(BuildContext context, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,

    ),
  );
}

Widget buildContainer(Widget child , context) {
  bool landscape = MediaQuery.of(context).orientation == Orientation.landscape ;
  var dw = MediaQuery.of(context).size.width ;
  var dh = MediaQuery.of(context).size.height ;

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(0),
    height: landscape? dh*0.5 : dh*0.5,
    width: landscape? (dw*0.5-30) : dw ,
    child: child,
  );
}
