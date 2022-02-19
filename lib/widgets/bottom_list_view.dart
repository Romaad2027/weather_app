import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';

import 'forecast_card.dart';

class BottomListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const BottomListView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '7-day Weather Forecast'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 140,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ListView.separated(
              itemBuilder: (context, index) => snapshot.data!.list![index].dtTxt!.contains('15:00:00') ? Container(
                width: MediaQuery.of(context).size.width / 2.7,
                height: 160,
                color: Colors.black87,
                child: forecastCard(snapshot, index),
              ) : const SizedBox.shrink(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0,),
              itemCount: snapshot.data!.list!.length,
          ),
        ),
      ],
    );
  }
}
