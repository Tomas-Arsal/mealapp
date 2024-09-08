import 'package:flutter/material.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/screens/thems_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/filters_screen.dart';


class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black ,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment:lan.isEn? Alignment.centerLeft : Alignment.centerRight,
              color: primaryColor,
              child:  Text(
                lan.getTexts(
                  'drawer_name',

                ).toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            buildListTile( lan.getTexts('drawer_item1').toString(), Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeTabName);
            }),
            buildListTile( lan.getTexts('drawer_item2').toString(), Icons.settings, () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            }),
            buildListTile( lan.getTexts('drawer_item3').toString(), Icons.color_lens, () {
              Navigator.of(context).pushReplacementNamed(ThemScreen.routeThemName);
            }),
            Container(
              width: 350,
              color:primaryColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    lan.getTexts('drawer_switch_title').toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          lan
                              .getTexts('drawer_switch_item2')
                              .toString(),
                          style: Theme.of(context).textTheme.titleLarge),
                      Switch(
                        value: lan.isEn,
                        onChanged: (newValue) {
                          Provider.of<LanguageProvider>(context,
                              listen: false)
                              .changeLan(newValue);
                        },
                        activeColor: accentColor,
                      ),
                      Text(
                          lan
                              .getTexts('drawer_switch_item1')
                              .toString(),
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
