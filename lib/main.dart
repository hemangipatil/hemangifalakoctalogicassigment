import 'package:flutter/material.dart';
import 'package:hemangifalakoctalogictest/Database/database.dart';
import 'package:hemangifalakoctalogictest/Screens/form_screen_1.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local SQLite database (This line is sufficient, no need for 'initializeDatabase')
  await DBHelper.instance.database;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Booking Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NameScreen(), // Set FormScreen as the home screen
    );
  }
}
