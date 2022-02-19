import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilities/forecast_util.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecast> snapshot, int index){
  DateTime date = DateTime.fromMillisecondsSinceEpoch(snapshot.data!.list![index].dt! * 1000);
  String dayOfWeek = Util.getFormattedDate(date).split(',')[0]; // f.e. Tue
  String tempMin = snapshot.data!.list![index].main!.tempMin!.toStringAsFixed(0);
  String icon = snapshot.data!.list![index].getIconUrl();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(dayOfWeek, style: const TextStyle(fontSize: 25, color: Colors.white),),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '$tempMin °C',
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Image.network(icon, scale: 1.2, color: Colors.white,)
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );
}