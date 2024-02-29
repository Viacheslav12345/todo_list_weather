import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_weather/presentation/weather/weather_cubit/weather_cubit.dart';
import 'package:todo_list_weather/presentation/weather/weather_cubit/weather_widgets.dart/city_widget.dart';
import 'package:todo_list_weather/presentation/weather/weather_cubit/weather_widgets.dart/details_widget.dart';
import 'package:todo_list_weather/presentation/weather/weather_cubit/weather_widgets.dart/temp_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
      return switch (state) {
        WeatherInitial() || WeatherLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        WeatherLoaded() => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TempWidget(forecast: state.cityForecast),
                DetailsWidget(forecast: state.cityForecast),
                CityWidget(forecast: state.cityForecast),
              ],
            ),
          ),
        WeatherLoadingFailure() => const Text('Error'),
      };
    });
  }
}
