import 'package:flutter/material.dart';
import 'package:todo_list_weather/data/models/weather.dart';

class TempWidget extends StatelessWidget {
  final Forecast forecast;
  const TempWidget({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    var icon = forecast.list?[0].getIconUrl();
    var temp = forecast.list?[0].main?.temp?.toStringAsFixed(0) ?? '';
    var description = forecast.list?[0].weather?[0].description ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.network(
            icon!,
            scale: 1.2,
            filterQuality: FilterQuality.high,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(description),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            '$temp °C',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
