import 'package:weather_app_flutter/dart_object/mainn.dart';
import 'package:weather_app_flutter/dart_object/weather.dart';

class ForecastList {
  int dt;
  Mainn mainn;
  List<Weather> weather;

  ForecastList({this.dt, this.mainn, this.weather,});

  ForecastList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    mainn = json['main'] != null ? new Mainn.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.mainn != null) {
      data['main'] = this.mainn.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    return data;
  }
}