import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealapp/widgets/draw_item.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class ThemScreen extends StatelessWidget {
  static const routeThemName = '/them';
  final bool fromOnBoarding;

  ThemScreen({this.fromOnBoarding = false});

  @override
  Widget build(BuildContext context) {
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    Widget buildRadioListView(
        ThemeMode themVal, String text, IconData? iconData, BuildContext ctx) {
      return RadioListTile(
        secondary: Icon(iconData),
        value: themVal,
        groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
        onChanged: (newValueChanged) =>
            Provider.of<ThemeProvider>(ctx, listen: false)
                .themeModeChange(newValueChanged),
        title: Text(text,
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,),
        activeColor: accentColor,
      );
    }

    return Scaffold(
      body:
       CustomScrollView(
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
            SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        lan.getTexts('theme_screen_title').toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 30.0),
                      ),
                    ),
                  ),
                  Text(
                    lan.getTexts('theme_mode_title').toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                  buildRadioListView(
                      ThemeMode.system,
                      lan.getTexts('System_default_theme').toString(),
                      null,
                      context),
                  buildRadioListView(
                      ThemeMode.dark,
                      lan.getTexts('dark_theme').toString(),
                      Icons.wb_sunny_rounded,
                      context),
                  buildRadioListView(
                      ThemeMode.light,
                      lan.getTexts('light_theme').toString(),
                      Icons.nights_stay,
                      context),
                  buildListTitle(context, lan.getTexts("primary").toString()),
                  buildListTitle(context, lan.getTexts("accent").toString()),
                ]))
          ],
        ),
      drawer: fromOnBoarding ? null : MainDrawer(),
    );
  }
}

ListTile buildListTitle(BuildContext context, text) {
  var lan = Provider.of<LanguageProvider>(context, listen: true);
  var primaryColor =
      Provider.of<ThemeProvider>(context, listen: true).primaryColor;
  var accentColor =
      Provider.of<ThemeProvider>(context, listen: true).accentColor;
  return ListTile(
    title: Text('$text'),
    trailing: CircleAvatar(
      backgroundColor: text == lan.getTexts("primary").toString() ? primaryColor : accentColor,
    ),
    onTap: () => showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            elevation: 5,
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: text == lan.getTexts("primary").toString()
                    ? Provider.of<ThemeProvider>(ctx, listen: true)
                    .primaryColor
                    : Provider.of<ThemeProvider>(ctx, listen: true)
                    .accentColor,
                onColorChanged: (newColor) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .onChanged(newColor, text == lan.getTexts("primary").toString() ? 1 : 2),
              ),
            ),
          );
        }),
  );
}
