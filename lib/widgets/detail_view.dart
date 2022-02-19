import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilities/forecast_util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pressure = snapshot.data!.list![0].main!.pressure! * 0.750062;
    int humidity = snapshot.data!.list![0].main!.humidity!;
    double windSpeed = snapshot.data!.list![0].wind!.speed!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Util.getItem(FontAwesomeIcons.thermometerThreeQuarters, pressure.round(), 'mm Hg'),
        Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
        Util.getItem(FontAwesomeIcons.wind, windSpeed.toInt(), 'm/s'),
      ],
    );
  }
}
