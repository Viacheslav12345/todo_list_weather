import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_weather/data/models/weather.dart';
import 'package:todo_list_weather/data/services/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherService weatherService;
  WeatherCubit(
    this.weatherService,
  ) : super(WeatherInitial());

  Future<void> onLoadForecast(String lon, String lat) async {
    try {
      var cityForecast = await weatherService.getWeather(lon, lat);
      emit(WeatherLoaded(cityForecast));
    } catch (e) {
      emit(WeatherLoadingFailure(exception: e));
    }
  }
}
