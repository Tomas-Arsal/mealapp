import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/draw_item.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';
  final bool fromOnBoarding;

  FiltersScreen({this.fromOnBoarding = false});

  Widget _buildSwitchListTile(String title,
      String description,
      bool currentValue,
      updateValue,context) {
    return SwitchListTile(
      title: Text(title ,
        style: Theme
          .of(context)
          .textTheme
          .bodyLarge,
      ),
      value: currentValue,
      subtitle: Text(
        description,
        style: Theme
            .of(context)
            .textTheme
            .bodyLarge,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {

    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final Map<String, bool> currentFilters =
        Provider
            .of<MealProvider>(context, listen: true)
            .filters;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer:fromOnBoarding ? null :MainDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: false,
                title: fromOnBoarding
                    ? AppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  elevation: 0,
                )
                    : Text(lan.getTexts('theme_appBar_title').toString()),
              backgroundColor: fromOnBoarding
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).primaryColor,
              elevation: fromOnBoarding ? 0 : 5,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  lan.getTexts("filters_screen_title").toString(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                ),
              ),
                    Builder(
                      builder: (BuildContext context) =>
                          _buildSwitchListTile(
                            lan.getTexts("Gluten-free",).toString(),
                            lan.getTexts("Gluten-free-sub").toString(),
                            currentFilters['gluten']!,
                                (newValue) {
                                currentFilters['gluten'] = newValue;
                                Provider.of<MealProvider>(
                                    context, listen: false)
                                    .setFilters();
                            },
                            context ,
                          ),
                    ),
                    Builder(
                      builder: (BuildContext context) =>
                          _buildSwitchListTile(
                            lan.getTexts("Lactose-free").toString(),
                            lan.getTexts("Lactose-free_sub").toString(),
                            currentFilters['lactose']!,
                                (newValue) {
                                currentFilters['lactose'] = newValue;
                                Provider.of<MealProvider>(
                                    context, listen: false)
                                    .setFilters();
                            },
                            context ,
                          ),
                    ),
                    Builder(
                      builder: (BuildContext context) =>
                          _buildSwitchListTile(
                            lan.getTexts("Vegetarian").toString(),
                            lan.getTexts("Vegetarian-sub").toString(),
                            currentFilters['vegan']!,
                                (newValue) {
                                currentFilters['vegan'] = newValue;
                                Provider.of<MealProvider>(
                                    context, listen: false)
                                    .setFilters();
                            },
                            context ,

                          ),
                    ),
                    Builder(builder: (context) {
                      return _buildSwitchListTile(
                        lan.getTexts("Vegan").toString(),
                        lan.getTexts("Vegan-sub").toString(),
                        currentFilters['vegetarian']!,
                            (newValue) {
                            currentFilters['vegetarian'] = newValue;
                            Provider.of<MealProvider>(
                                context, listen: false)
                                .setFilters();
                        },
                        context ,
                      );
                    })
            ]))
          ],
        ),
      ),
    );
  }
}
