import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weatherit/cities.dart';
import 'package:weatherit/weather_detail_scr.dart';

import 'imageres.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('city-weather');
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather UI',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      routes:{

    // When navigating to the "/" route, build the FirstScreen widget.
    '/city': (context) => const Cities(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/weather_det': (context) => const WeatherScreen(),
    },
      home: const Cities(),
    );
  }
}


