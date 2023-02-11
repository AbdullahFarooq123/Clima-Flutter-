import 'package:flutter/material.dart';
import 'location_screen.dart';
import '../services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}
class LoadingScreenState extends State<LoadingScreen> {
  void locate() async {
    loadLocationScreen(await WeatherModel().locate());
  }
  void loadLocationScreen(var weatherData){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(locationData: weatherData,)));
  }
  @override
  void initState(){
    super.initState();
    locate();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.yellow,
          size: 100.0,
        ),
      ),
    );
  }
}
