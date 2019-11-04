import 'package:weather_app_flutter/dart_object/mainn.dart';
import 'package:weather_app_flutter/dart_object/sys.dart';
import 'package:weather_app_flutter/dart_object/weather.dart';

class OpenWeather {
  Mainn mainn;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;
  List<Weather> weather;

  OpenWeather.fromJson(Map<String, dynamic> json) {
    mainn = Mainn.fromJson(json['main']);
    sys = Sys.fromJson(json['sys']);
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];

    if (json['weather'] != null) {
        weather = new List<Weather>();
        json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
        });
      }
    }

}