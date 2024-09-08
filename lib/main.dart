import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/Categories_Screen.dart';
import 'package:mealapp/screens/categoryMealScreenState.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/meal_details_screen.dart';
import 'package:mealapp/screens/on_boarding_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/screens/thems_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized() ;
SharedPreferences prefs = await SharedPreferences.getInstance() ;
 Widget homescreen  = prefs.getBool('watched')??false ? TabsScreen() : OnBoardingScreen() ;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(create: (ctx) => MealProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
      ],
      child: MyApp(homescreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen ;
   const MyApp( this.mainScreen );

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(
        primaryColor: accentColor,
        primarySwatch: accentColor,
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryColor ,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: primaryColor,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            )),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.blue,
          backgroundColor: primaryColor,
          elevation: 50.0,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyLarge: TextStyle(color: Colors.black) ,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: accentColor,
        scaffoldBackgroundColor: HexColor('333739'),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: primaryColor,
          elevation: 0.0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.blue,
          elevation: 50.0,
          backgroundColor: primaryColor ,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

      ),
      // home: const Categories_Screen() ,
      routes: {
        '/': (BuildContext context) => mainScreen,
        TabsScreen.routeTabName: (BuildContext context) => TabsScreen(),
        CategoryMealScreenState.routeName: (context) =>
            const CategoryMealScreenState(),
        MealDetailScreen.routeMealDetailScreen: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemScreen.routeThemName: (context) => ThemScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
