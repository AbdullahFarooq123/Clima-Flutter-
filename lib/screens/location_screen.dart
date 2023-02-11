import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key, required this.locationData}) : super(key: key);
  final locationData;
  final WeatherModel model = WeatherModel();

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late int condition;
  late String cityName;

  void updateUi(dynamic locationData) {
    print(locationData);
    setState(() {
      if(locationData == null){
        temperature = 0;
        condition = 0;
        cityName = "";
        return;
      }
      temperature = locationData["main"]["temp"].toInt();
      condition = locationData["weather"][0]["id"];
      cityName = locationData["name"];
    });
  }

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      updateUi(await widget.model.locate());
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>const CityScreen()));
                      if(cityName!=null){
                        updateUi(await widget.model.getCityWeather(cityName));
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      widget.model.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${widget.model.getMessage(temperature)} in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
