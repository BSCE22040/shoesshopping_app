// Importing Flutter's material design library to use UI widgets and theming.
import 'package:flutter/material.dart';

// Importing Provider package for state management (used for managing app data like cart items).
import 'package:provider/provider.dart';

// Importing custom provider class for managing cart operations.
import 'package:shop_app_flutter/cart_provider.dart';

// Importing the home page of the shopping app where products will be displayed.
import 'package:shop_app_flutter/home_page.dart';

// The entry point of the Flutter application. The execution starts here.
void main() {
  // runApp() is a built-in Flutter function that takes a widget and makes it the root of the app.
  runApp(const MyApp());
}

// The root widget of the application. It represents the whole app UI and logic.
class MyApp extends StatelessWidget {
  // Constructor with a constant key, helps with widget tree optimization.
  const MyApp({super.key});

  // The build() method defines how this widget will look on screen.
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider is used to make CartProvider available to all widgets in the app.
    return ChangeNotifierProvider(
      // This creates an instance of CartProvider which holds cart data and notifies listeners.
      create: (context) => CartProvider(),

      // MaterialApp sets up app-wide settings like title, theme, and navigation.
      child: MaterialApp(
        // Removes the debug banner from the top right corner of the app during development.
        debugShowCheckedModeBanner: false,

        // Title of the application displayed in app switcher and system-level views.
        title: 'Shopping App',

        // Defining a global theme for the application.
        theme: ThemeData(
          // Setting a custom font for the entire app.
          fontFamily: 'Lato',

          // Creating a color scheme using a seed color (used for consistent theme colors).
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(254, 206, 1, 1),
          ),

          // Customizing the app bar (top bar) appearance.
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black, // Black color for the title text.
            ),
          ),

          // Setting styles for all input fields (like search bars, forms, etc.)
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1), // Grey prefix icon color.
          ),

          // Defining text styles for various text sizes throughout the app.
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          // Enabling Material Design 3 (modern UI style).
          useMaterial3: true,
        ),

        // Setting the HomePage as the default screen when the app starts.
        home: HomePage(),
      ),
    );
  }
}
