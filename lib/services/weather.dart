import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';

const apiKey = '33564ba817de58331fee2f50d860e520';

class WeatherModel {
  Future<dynamic> getCityData(String cityname) async {
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey&units=metric');
    var weatherData = await network.getData();
    return weatherData;
  }

  Future<dynamic> getCurrentData() async {
    Location location = Location();
    await location.getCurrentLoc();

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await network.getData();

    return weatherData;
  }

  String? getWeatherIcon(int condition) {
    switch (condition) {
      case < 300:
        return '🌩';
      case < 400:
        return '🌧';
      case < 600:
        return '☔️';
      case < 700:
        return '☃️';
      case < 800:
        return '🌫';
      case 800:
        return '☀️';
      case 804:
        return '☁️';
      default:
        return '🌥️';
    }
  }

  String getMessage(int temp, String city) {
    switch (temp) {
      case > 25:
        return 'It\'s 🍦 time in $city';
      case > 20:
        return 'Time for shorts and 👕 in $city';
      case < 10:
        return 'You\'ll need 🧣 and 🧤in $city';
      default:
        return 'Bring a 🧥 just in case in $city';
    }
  }
}
