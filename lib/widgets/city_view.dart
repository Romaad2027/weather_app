import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  const CityView({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot<WeatherForecast> snapshot;

  @override
  Widget build(BuildContext context) {
    var city = snapshot.data!.city!.name;
    var country = snapshot.data!.city!.country;
    final formattedDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data!.list![0].dt! * 1000);
    return Container(
      child: Column(
        children: [
          Text(
            '$city, $country',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black87),
          ),
          Text(
            Util.getFormattedDate(formattedDate),
            style: const TextStyle(
              fontSize: 15.0,
            ),
          )
        ],
      ),
    );
  }
}
