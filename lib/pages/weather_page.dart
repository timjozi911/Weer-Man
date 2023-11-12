import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weer_man/auth/secrets.dart';
import 'package:weer_man/models/weather_model.dart';
import 'package:weer_man/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
// api key
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;

// fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

// weather animations

// initial state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // city name
          Text(_weather?.cityName ?? "loading city name"),
          // temprature
          Text('${_weather?.temperature.round()} °C')
        ],
      ),
    );
  }
}
