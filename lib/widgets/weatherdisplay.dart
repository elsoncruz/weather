import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/screens/forecast_screen.dart';

class WeatherDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    if (weatherProvider.currentWeather == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Text('Current Temperature: ${weatherProvider.currentWeather!['main']['temp']}°C'),
        Text('Condition: ${weatherProvider.currentWeather!['weather'][0]['description']}'),
        Text('Min Temp: ${weatherProvider.currentWeather!['main']['temp_min']}°C'),
        Text('Max Temp: ${weatherProvider.currentWeather!['main']['temp_max']}°C'),
        Text('Wind Speed: ${weatherProvider.currentWeather!['wind']['speed']} m/s'),
      ],
    );
  }
}
