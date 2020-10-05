import 'dart:ui';

import 'package:flutter/material.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        '/': (ctx)=> CategoriesScreen(),
        // '/category-meals': (context)=> CategoryMealsScreen(),
        CategoryMealsScreen.routeName : (context) => CategoryMealsScreen(), //requuired static routeName property
        MealDetailScreen.routeName: (context)=>MealDetailScreen()
      },
      onGenerateRoute: (settings){  //when the route nema is not registered on above, it goes to here 
        print(settings.arguments);
        // if(settings.name == '/meal-detail'){
        //   return MaterialPageRoute();
        // }
        // else if(settings.name == '/simething-else'){
        //   return MaterialPageRoute()
        // }
        // return MaterialPageRoute(builder:(ctx)=>CategoriesScreen());
      },
      onUnknownRoute:(settings){ // when the route info is not exist, going no where, it comes here
      // use when it links 'page not found' or showing wrong address page
        return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      } ,
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
