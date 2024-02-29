import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_list_weather/common/constants.dart';
import 'package:todo_list_weather/data/models/weather.dart';

class WeatherService {
  Future<Forecast> getWeather(String lon, String lat) async {
    var queryParameters = {
      'appid': Constants.appId,
      'units': 'metric',
      'lon': lon,
      'lat': lat
    };

    var uri =
        Uri.https(Constants.domain, Constants.weatherPath, queryParameters);

    log('request: ${uri.toString()}');

// Http library is a simple and easy-to-use package for basic HTTP requests.
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error response');
    }
  }
}
