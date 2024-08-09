import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/screens/home_screens.dart';
import 'services/weather_service.dart';
    // Import your HomeScreen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      home: HomeScreen(),
    );
  }
}
