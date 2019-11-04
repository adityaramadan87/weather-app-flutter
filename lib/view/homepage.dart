import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app_flutter/api_service/api_service.dart';
import 'package:weather_app_flutter/dart_object/forecasts.dart';
import 'package:weather_app_flutter/dart_object/open_weather.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: <Widget>[
              new HeaderView(),
              new BodyView(),
            ],
        ),
    );
  }
}

class BodyView extends StatefulWidget {
  @override
  _BodyViewState createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {

  OpenWeather _openWayae;
  Forecasts _forecasts;
  var formater;
  var dateFormater;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenWayae();
    listenForecasts();
    formater = new DateFormat('HH:mm');
    dateFormater = new DateFormat('MMM d, y \n HH:mm a');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1000,
        color: Colors.blueAccent,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: new Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage("http://openweathermap.org/img/wn/"+ _openWayae.weather[0].icon +"@2x.png" ),

                    )
                ),
              ),
            ),
            new Padding(padding: EdgeInsets.all(16),
              child:
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 4, 10),
                      child: new Text(_openWayae.name +'\n'+_openWayae.weather[0].main , style: TextStyle(fontFamily: 'Varela', fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.right,),
                    ),
                    new Text(_openWayae.mainn.temp.round().toString() + '°C', style: TextStyle(fontFamily: 'Varela', fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                  ]
              ),
            ),


            new Padding(
              padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: new Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50),),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Icon(Icons.filter_1, size: 50, color: Colors.lightBlue,),
                              new Text("Pressure \n"+ _openWayae.mainn.pressure.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Varela"),textAlign: TextAlign.center,)
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              new Icon(Icons.filter_2, size: 50, color: Colors.lightBlue,),
                              new Text("Humidity \n"+ _openWayae.mainn.humidity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Varela"),textAlign: TextAlign.center,)
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              new Icon(Icons.flag, size: 50, color: Colors.lightBlue,),
                              new Text("Country \n"+ _openWayae.sys.country, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Varela"),textAlign: TextAlign.center,)
                            ],
                          ),
                        ],
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                new Icon(Icons.wb_sunny, size: 50, color: Colors.lightBlue,),
                                new Text("Sunrise \n" + formater.format(DateTime.fromMillisecondsSinceEpoch(_openWayae.sys.sunset * 1000)), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Varela"),textAlign: TextAlign.center,)
                              ],
                            ),
                            new Column(
                              children: <Widget>[
                                new Icon(Icons.brightness_medium, size: 50, color: Colors.lightBlue,),
                                new Text("Sunset \n"+ formater.format(DateTime.fromMillisecondsSinceEpoch(_openWayae.sys.sunrise * 1000)) , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Varela"),textAlign: TextAlign.center,)
                              ],
                            ),
                            new Column(
                              children: <Widget>[
                                new Icon(Icons.filter_6, size: 50, color: Colors.lightBlue,),
                                new Text("Temp max \n"+ _openWayae.mainn.tempMax.round().toString() + '°C', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Varela"),textAlign: TextAlign.center,)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(20),
              child: new Column(
                children: <Widget>[
                  new Text("Forecast in Jakarta", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold, fontFamily: "Varela"),),
                  new Padding(
                    padding: EdgeInsets.all(16),
                    child: new Container(
                      height: 180,
                      child: ListView.builder(
                        itemCount: _forecasts.forecastList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return new Card(
                            color: Colors.white,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                            ),
                            child: new Container(
                              height: 150,
                              width: 150,
                              child: new Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  new Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: new Text(dateFormater.format(DateTime.fromMillisecondsSinceEpoch(_forecasts.forecastList[index].dt * 1000)),textAlign: TextAlign.center,  style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold, fontFamily: "Varela")),),

                                  new Padding(padding: EdgeInsets.all(5),
                                    child: new Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage("http://openweathermap.org/img/wn/"+ _forecasts.forecastList[index].weather[0].icon +"@2x.png" ),

                                          )
                                      ),
                                    ),
                                  ),

                                  new Padding(padding: EdgeInsets.all(5), child: new Text(_forecasts.forecastList[index].mainn.temp.round().toString()+ '°C', style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold, fontFamily: "Varela")),),

                                  new Padding(padding: EdgeInsets.fromLTRB(10,5,10,5), child: new Text(_forecasts.forecastList[index].weather[0].description, style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold, fontFamily: "Varela"),),)

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void listenWayae() async {

    final Stream<OpenWeather> stream = await getWeather();
    stream.listen((OpenWeather opWeather) =>
      setState(() => _openWayae = opWeather)
    );

  }

  void listenForecasts() async {

    final Stream<Forecasts> stream = await getForecast();
    stream.listen((Forecasts forecast) =>
      setState(() => _forecasts = forecast)
    );

  }

}


class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      margin: MediaQuery.of(context).padding,
      child: new SizedBox(
        height: 60.0,
        child: new Center(
          child: new Text(
            "Weather",
            style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Varela'),
          ),
        ),
      ),
    );
  }
}

