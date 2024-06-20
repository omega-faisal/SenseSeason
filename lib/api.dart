import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'Models/forecastModel.dart';
import 'Models/weather_model.dart';

class API {
  static String ApiKey = "e7ca6ee7483b3f492a62b909b96bbd0f";

  static Future<WeatherResponse?> fetchWeather(String city) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$ApiKey'));
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        return null;
      } else {
        Fluttertoast.showToast(
            msg: "Weather Could not be Fetched.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        throw Exception(
            'Failed to load weather data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load charges: $e');
    }
  }

  static Future<WeatherResponse02?> getForecast(String city) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$ApiKey'));
      final jsonResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print(jsonResponse);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("fetch weather has been successfully  hit");
        }
        return WeatherResponse02.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        return null;
      } else {
        Fluttertoast.showToast(
            msg: "Weather Could not be Fetched.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        throw Exception(
            'Failed to load weather data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load charges: $e');
    }
  }
}
