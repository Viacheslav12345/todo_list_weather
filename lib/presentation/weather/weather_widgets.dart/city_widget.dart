import 'package:flutter/material.dart';
import 'package:todo_list_weather/data/models/weather.dart';
import 'package:intl/intl.dart';

class CityWidget extends StatelessWidget {
  final Forecast? forecast;
  const CityWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    String city = forecast?.city?.name ?? '';
    var formatDate =
        DateTime.fromMillisecondsSinceEpoch(forecast!.list![0].dt! * 1000);
    String date = DateFormat('EEEE, MMM d').format(formatDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              city,
              textAlign: TextAlign.right,
              style: theme.textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Text(date, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
