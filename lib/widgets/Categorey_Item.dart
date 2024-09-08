import 'package:flutter/material.dart';
import 'package:mealapp/screens/categoryMealScreenState.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class Categorey_Item extends StatelessWidget {
  final String id;
  final Color color;

  const Categorey_Item(
      {required this.id,  required this.color});

  void selectCategory(context) {
    Navigator.of(context).pushNamed(
      CategoryMealScreenState.routeName,
      arguments: {
        'id': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text(lan.getTexts('cat-$id').toString())),
        ),
      ),
    );
  }
}
