import 'dart:ui';

import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false; // to newly generated list
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false; // to newly generated list
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false; // to newly generated list
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false; // to newly generated list
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((element) => element.id == mealId),
        );
      });
    }
  }


  bool _isMealFavorites(String id){
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 220, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        // '/': (ctx)=> CategoriesScreen(),
        '/': (ctx) => TabsScreen(_favoriteMeals),
        // '/category-meals': (context)=> CategoryMealsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
            _availableMeals), //requuired static routeName property
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite, _isMealFavorites,),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        //when the route nema is not registered on above, it goes to here
        print(settings.arguments);
        // if(settings.name == '/meal-detail'){
        //   return MaterialPageRoute();
        // }
        // else if(settings.name == '/simething-else'){
        //   return MaterialPageRoute()
        // }
        // return MaterialPageRoute(builder:(ctx)=>CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // when the route info is not exist, going no where, it comes here
        // use when it links 'page not found' or showing wrong address page
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('NavigationTime!'),
      ),
    );
  }
}
