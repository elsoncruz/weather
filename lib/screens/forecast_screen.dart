import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider with ChangeNotifier {
  String apiKey = 'YOUR_OPENWEATHERMAP_API_KEY';
  double latitude = 0.0;
  double longitude = 0.0;
  Map<String, dynamic>? currentWeather;
  List<dynamic>? forecast;

  void setLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    const currentWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=8.195016562680948&lon=77.37638344987191&appid=d1dd19772a6142d9c438357ee4f10cd5';
    const forecastUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=8.195016562680948&lon=77.37638344987191&appid=d1dd19772a6142d9c438357ee4f10cd5';

    final currentResponse = await http.get(Uri.parse(currentWeatherUrl));
    final forecastResponse = await http.get(Uri.parse(forecastUrl));

    if (currentResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      currentWeather = jsonDecode(currentResponse.body);
      forecast = jsonDecode(forecastResponse.body)['list'];
      notifyListeners();
    } else {
      // Handle errors
    }
  }
}
