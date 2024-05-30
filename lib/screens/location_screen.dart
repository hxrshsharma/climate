import 'package:climate/screens/alert.dart';
import 'package:climate/services/weather.dart';
import 'package:climate/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherstate = WeatherModel();
  int? tempreature;
  int? feels;
  String? icon;
  String? message;

  @override
  void initState() {
    updateWeather(widget.locationWeather);
    super.initState();
  }

  void updateWeather(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        return showAlertDialog(context);
      }
      double temp = weatherData['main']['temp'];
      tempreature = temp.toInt();
      feels = weatherData['main']['feels_like'].toInt();
      var condition = weatherData['weather'][0]['id'];
      var city = weatherData['name'];
      icon = weatherstate.getWeatherIcon(condition!);
      message = weatherstate.getMessage(tempreature!, city!);
    });
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData =await weatherstate.getCurrentData();
                      updateWeather(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var input = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );
                      if (input != null) {
                        var weatherData = await weatherstate.getCityData(input);
                        updateWeather(weatherData);
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
                  children: [
                    Text(
                      "$tempreature",
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon',
                      style: kConditionTextStyle,
                    ),
                    Text(
                      "($feels)",
                      style: kConditionTextStyle1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
