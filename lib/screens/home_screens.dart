// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/services/weather_service.dart';
// Make sure this import matches your project structure

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherService _weatherService;

  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService();
  }

  Future<void> _fetchWeather(double latitude, double longitude) async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final data = await _weatherService.fetchCurrentWeather(latitude, longitude, weatherProvider.isCelsius);
    if (data != null) {
      // Process and display weather data
      // For example, you could update the state or use a provider to hold the data
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Column(
        children: [
          // Toggle for temperature units
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Celsius'),
              Switch(
                value: weatherProvider.isCelsius,
                onChanged: (value) {
                  weatherProvider.toggleTemperatureUnit();
                },
              ),
              const Text('Fahrenheit'),
            ],
          ),
          // Map
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                // ignore: deprecated_member_use
                center: const LatLng(51.5, -0.09),  // Default coordinates
                // ignore: deprecated_member_use
                zoom: 13.0,
                onTap: (tapPosition, point) {
                  _fetchWeather(point.latitude, point.longitude);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                // Add more layers or markers if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
