import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_pr/ui/routes/app_routes.dart';
import '../../ui/resources/appbg.dart';
import '../api/api.dart';
import '../database/favorite_history.dart';
import '../database/hive_box.dart';
import '../models/coord.dart';
import '../models/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  // xranenie koordinat

  Coord? _coords;

  //  Dannie o pogode

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  // tekushe dannie o pogode

  Current? _current;

  final searchController = TextEditingController();
  final pref = SharedPreferences.getInstance();

  // Glavnaya funksiya zapusk  FutureBuilder

  Future<WeatherData?> setUp({String? cityName}) async {
    cityName = (await pref).getString('city_name');

    _coords = await Api.getCoords(cityName: cityName ?? 'Tashkent');
    _weatherData = await Api.getWeather(_coords);

    _current = _weatherData?.current;
    setCurrentDay();
    setCurrentDayTime();
    setCurrentTime();
    setCurrentTemp();
    setHumidity();
    setWindSpeed();
    setFeelsLike();
    setWeekDay();
    getCurrentCity();

    return _weatherData;
  }



  Future<void> setCurrentCity(BuildContext context, {String? cityName}) async {
    if (searchController.text != '') {
      cityName = searchController.text;
      (await pref).setString('city_name', cityName);
      await setUp(cityName: (await pref).getString('city_name'))
          .then((value) => context.go(AppRoutes.home))
          .then((value) => searchController.clear());
    }else{
      context.go(AppRoutes.home);
    }
  }

  String currentCity = '';

  Future<String> getCurrentCity() async{
    currentCity =  (await pref).getString('city_name') ?? 'Tashkent';
    return capitalise(currentCity);
  }


  String? currentDay;

  String setCurrentDay() {
    final getTime = (_current?.dt ?? 0) + (_weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentDay = DateFormat('MMMM d').format(setTime);
    return currentDay ?? 'Error';
  }

  String? currentDayTime;

  String setCurrentDayTime() {
    final getTime = (_current?.dt ?? 0) + (_weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentDayTime = DateFormat('yMd').format(setTime);

    return currentDayTime ?? 'Error';
  }

  String? currentTime;

  String setCurrentTime() {
    final getTime = (_current?.dt ?? 0) + (_weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentTime = DateFormat('HH:mm a').format(setTime);

    return currentTime ?? 'Error';
  }

  final String _weatherIconUrl = 'https://api.openweathermap.org/img/w/';

  String iconData() {
    return '$_weatherIconUrl${_current?.weather?[0].icon}.png';
  }

  String currentStatus = '';

  String getCurrentStatus() {
    currentStatus = _current?.weather?[0].description ?? 'Ошибка';
    return capitalise(currentStatus);
  }

  String capitalise(String str) => str[0].toUpperCase() + str.substring(1);

  // get temp

  int kelvin = -273;

  int currentTemp = 0;

  int setCurrentTemp() {
    currentTemp = ((_current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  // vlajnost

  int humidity = 0;

  int setHumidity() {
    humidity = ((_current?.humidity ?? 0) / 1).round();
    return humidity;
  }

  // wind speed

  dynamic windSpeed = 0;

  dynamic setWindSpeed() {
    windSpeed = _current?.windSpeed ?? 0;
    return windSpeed;
  }

  // feels like

  int feelsLike = 0;

  int setFeelsLike() {
    feelsLike = ((_current?.feelsLike ?? -kelvin) + kelvin).round();
    return feelsLike;
  }

  final List<String> date = [];
  List<Daily> daily = [];

  void setWeekDay() {
    daily = _weatherData?.daily ?? [];
    for (var i = 1; i < daily.length; i++) {
      if (i == 0 && daily.isNotEmpty) {
        daily.clear();
      }
      var timeNum = daily[i].dt * 1000;
      var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
      var dayTime = DateFormat('EEE').format(itemDate);
      date.add(capitalise(dayTime));
    }
  }

  String setDailyIcons(int index) {
    final String getIcon = '${_weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_weatherIconUrl$getIcon.png';
    return setIcon;
  }

  dynamic setDailyTemp(int index) {
    final dynamic dayTemp = ((_weatherData?.daily?[index].temp?.day ?? -kelvin) + kelvin).round();
    return dayTemp;
  }

  int dailyWindSpeed = 0;

  dynamic setDailyWindSpeed(int index) {
    final int dailyWidSpeed = (_weatherData?.daily?[index].windSpeed ?? 0).round();
    return dailyWidSpeed;
  }

  // time sunRise

  String setSunRise() {
    final getSunTime = (_current?.sunrise ?? 0) + (_weatherData?.timezoneOffset ?? 0);

    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);

    final String sunRise = DateFormat("HH:mm a").format(setSunRise);

    return sunRise;
  }

  String setSunSet() {
    final getSunTime = (_current?.sunset ?? 0) + (_weatherData?.timezoneOffset ?? 0);

    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);

    final String sunSet = DateFormat("HH:mm a").format(setSunSet);

    return sunSet;
  }

  String? currentBg;

  String setBg() {
    int id = _current?.weather?[0].id ?? -1;

    if (id == -1 || _current?.sunset == null || _current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }
    try {
      if (_current?.sunset < _current?.dt) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyNight;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogNight;
        } else if (id >= 800) {
          currentBg = AppBg.shinyNight;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogDay;
        } else if (id >= 800) {
          currentBg = AppBg.shinyDay;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }

    return currentBg ?? AppBg.shinyDay;
  }

  // add favorites

  var box = Hive.box<FavoriteHistory>(HiveBox.favoriteBox);

  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    box
        .add(
          FavoriteHistory(
            cityName: cityName ?? 'Error',
            currentStatus: currentStatus,
            humidity: '${setHumidity()}',
            windSpeed: '$windSpeed',
            icon: iconData(),
            temp: '$currentTemp',
          ),
        )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The city $cityName has been added to favorites list'))));
  }

  Future<void> delete(int index) async {
    box.deleteAt(index);
  }
}
