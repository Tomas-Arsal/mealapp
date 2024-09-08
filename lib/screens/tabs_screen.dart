import 'package:flutter/material.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/Categories_Screen.dart';
import 'package:mealapp/screens/favoriets_screen.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../widgets/draw_item.dart';

class TabsScreen extends StatefulWidget {
 static const routeTabName = '/TabName' ;
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
    List<Map<String, dynamic>>? _pages;

    @override
    void initState() {
      Provider.of<MealProvider>(context , listen: false).getData() ;
      Provider.of<ThemeProvider>(context , listen: false).getThemeColors() ;
      Provider.of<LanguageProvider>(context , listen: false).getLan() ;
      super.initState();

    }
    // تنظيم الكود يتضمن كل جزء من المتغيرات يكون فوق الفاتكشن الهنستخدمها فيه
    int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor =
      Provider.of<ThemeProvider>(context, listen: true).primaryColor;
  var accentColor =
      Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {
        'page': const Categories_Screen(),
        'title': lan.getTexts('categories').toString(),
      },
      {
        'page': FavoritesScreen(),
        'title':  lan.getTexts('your_favorites').toString(),
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,

      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages![_selectedPageIndex]['title'].toString()),
        ),
        body: _pages![_selectedPageIndex]['page'] ,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          unselectedItemColor: Colors.black54,
          selectedItemColor:  accentColor ,
          currentIndex: _selectedPageIndex,
           type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
                backgroundColor:  Theme.of(context).primaryColor,
                icon: const Icon(Icons.category),
                label: lan.getTexts('categories').toString() ,
            ),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.primary,
                icon: const Icon(Icons.star),
                label: lan.getTexts('your_favorites').toString(),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}