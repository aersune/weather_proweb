

// https://api.openweathermap.org/data/2.5/weather?q=London&appid=49cc8c821cd2aff9af04c9f98c36eb74

// https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&exclude=hourly,minutely&appid=49cc8c821cd2aff9af04c9f98c36eb74



import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/coord.dart';
import '../models/weather_data.dart';

class Api {
  static final apiKey = dotenv.get('API_KEY');
  static final dio = Dio();


  static Future<Coord> getCoords({String? cityName}) async{

    final response = await dio.get('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    try {
      final coords = Coord.fromJson(response.data);
      return coords;
    }catch(_){
      final coords = Coord.fromJson(response.data);
      return coords;
    }

  }


  static Future<WeatherData?> getWeather(Coord? coord) async{
    if(coord != null){
      final lat = coord.lat.toString();
      final lon = coord.lon.toString();
      final response = await dio.get('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey');
      return  WeatherData.fromJson(response.data);
    }
    return null;
  }




}
