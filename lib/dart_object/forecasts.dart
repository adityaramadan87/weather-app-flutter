import 'package:weather_app_flutter/dart_object/forecast_list.dart';

class Forecasts {
  List<ForecastList> forecastList;

  Forecasts({this.forecastList});

  Forecasts.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      forecastList = new List<ForecastList>();
      json['list'].forEach((v) {
        forecastList.add(new ForecastList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastList != null) {
      data['list'] = this.forecastList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}