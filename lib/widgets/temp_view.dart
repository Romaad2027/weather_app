import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const TempView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(snapshot.data!.list![0].getIconUrl(), color: Colors.grey,),
          const SizedBox(width: 20.0),
          Column(
            children: [
              Text(
                '${snapshot.data!.list![0].main!.temp!.toInt()} °C',
                style: const TextStyle(fontSize: 54.0, color: Colors.black87),
              ),
              Text(snapshot.data!.list![0].weather![0].description!),
            ],
          )
        ],
      ),
    );
  }
}
