part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final Forecast cityForecast;

  const WeatherLoaded(this.cityForecast);
  @override
  List<Object> get props => [cityForecast];
}

final class WeatherLoadingFailure extends WeatherState {
  final Object? exception;

  const WeatherLoadingFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}
