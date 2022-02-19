import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/bottom_list_view.dart';
import 'package:weather_app/widgets/city_view.dart';
import 'package:weather_app/widgets/detail_view.dart';
import 'package:weather_app/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;

  const WeatherForecastScreen({Key? key, required this.locationWeather})
      : super(key: key);

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Future<WeatherForecast>? forecastObject;
  String _cityName = 'Mykolaiv';

  //String _cityName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.locationWeather != null) {
      forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName);
    }
    forecastObject!.then((value) {
      print(value.list![0].weather![0].main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('openweathermap.org'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecastByLocation();
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_city),
            onPressed: () async {
              String? tappedName = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CityScreen()));
              if (tappedName != null) {
                _cityName = tappedName;
                setState(() {
                  forecastObject =
                      WeatherApi().fetchWeatherForecast(cityName: _cityName);
                });
              }
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CityView(snapshot: snapshot),
                      const SizedBox(
                        height: 50,
                      ),
                      TempView(snapshot: snapshot),
                      const SizedBox(
                        height: 50,
                      ),
                      DetailView(snapshot: snapshot),
                      const SizedBox(
                        height: 50,
                      ),
                      BottomListView(snapshot: snapshot),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.black87,
                      ),
                      Text(
                        'If nothing happens, you typed wrong city \n or you have problems with your network',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
