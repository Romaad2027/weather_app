import 'dart:convert';
import 'dart:developer';

import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {String? cityName}) async {

    var queryParameters = {
      'APPID': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': cityName,
    };
    return httpRequest(queryParameters);
  }

  Future<WeatherForecast> fetchWeatherForecastByLocation(
      {String? cityName}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String>? parameters;
    if(location.permissionDenied == true){
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': 'London',
      };
      parameters = queryParameters;
    }
    else {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
      parameters = queryParameters;
    }
    return httpRequest(parameters);
  }

  Future<WeatherForecast> httpRequest(var parameters) async{
    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parameters);

    log('request :${uri.toString()}');
    var response = await http.get(uri);
    print('response: ${response.body}');
    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
