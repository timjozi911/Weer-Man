import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weer_man/models/weather_model.dart';
import 'package:weer_man/service/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.weatherService) : super(WeatherInitial());

  WeatherService weatherService;

  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherIsLoading();

      try {
        Weather weather = await weatherService.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        if (kDebugMode) {
          print(_);
        }
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
