import '../services/networking.dart';
import '../services/location.dart';

class WeatherModel {
  late double _latitude;
  late double _longitude;
  late String openWeatherMapUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> locate() async {
    Location location = Location();
    await location.getLocation();
    _latitude = location.latitude;
    _longitude = location.longitude;
    NetworkHelper networking = NetworkHelper(
        url: '$openWeatherMapUrl?lat=$_latitude&lon=$_longitude&appid=$key&units=metric');
    return await networking.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url =
        '$openWeatherMapUrl?q=$cityName&appid=$key&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var data = await networkHelper.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
