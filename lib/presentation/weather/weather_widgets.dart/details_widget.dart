import 'package:flutter/material.dart';
import 'package:todo_list_weather/data/models/weather.dart';

class DetailsWidget extends StatelessWidget {
  final Forecast? forecast;

  const DetailsWidget({super.key, this.forecast});

  @override
  Widget build(BuildContext context) {
    var pressure = (forecast?.list?[0].main?.pressure ?? 0) * 0.750062;
    var humidity = forecast?.list?[0].main?.humidity?.round() ?? '';
    var wind = forecast?.list?[0].wind?.speed?.round() ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerRight,
// Showing Pressure
          child: Row(
            children: [
              Icon(
                Icons.thermostat,
                size: 20,
                color: Theme.of(context).primaryColorDark,
              ),
              Row(
                children: [
                  Text(
                    pressure.round().toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'mm',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 15),
//Showing humidity
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Icon(
                Icons.water_drop,
                size: 20,
                color: Theme.of(context).primaryColorDark,
              ),
              Row(
                children: [
                  Text(
                    humidity.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    '%',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 15),
//Showing wind speed
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Icon(
                Icons.wind_power,
                size: 18,
                color: Theme.of(context).primaryColorDark,
              ),
              Row(
                children: [
                  Text(
                    wind.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'm/s',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
