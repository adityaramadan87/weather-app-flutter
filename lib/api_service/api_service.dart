import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app_flutter/dart_object/open_weather.dart';
import 'package:weather_app_flutter/dart_object/forecasts.dart';

Future<Stream<OpenWeather>> getWeather() async {
  final String url = 'https://api.openweathermap.org/data/2.5/weather?q=Jakarta&appid=d0d7a0d307b90d0f9cc936e98ce50667&units=metric';

  final client = new http.Client();
  final streamedRest = await client.send(
    http.Request('get', Uri.parse(url))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => OpenWeather.fromJson(data));

}

Future<Stream<Forecasts>> getForecast() async {
  final String urlForecast = 'http://api.openweathermap.org/data/2.5/forecast?q=Jakarta&appid=d0d7a0d307b90d0f9cc936e98ce50667&units=metric';
  
  final client = new http.Client();
  final streamedRest = await client.send(
    http.Request('get', Uri.parse(urlForecast))
  );
  
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Forecasts.fromJson(data));
  
}