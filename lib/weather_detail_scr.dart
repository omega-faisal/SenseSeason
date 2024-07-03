import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'Models/weather_model.dart';
import 'api.dart';
import 'cities.dart';
import 'imageres.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = true;
  String city = "";
  int serviceNo = 0;
  String temp = "";
  String maxTemp = "";
  String minTemp = "";
  String feelsLike = "";
  String description = "";
  String pressure = "";
  String humidity = "";
  String sunRise = "";
  String sunSet = "";
  String clouds = "";
  String windSpeed = "";
  String date = "";
  String day = DateFormat('EEEE').format(DateTime.now());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    await Hive.openBox('city-weather');
    if (serviceNo == 1) {
      if (city.isNotEmpty) {
        final WeatherResponse? response = await API.fetchWeather(city);
        if (!mounted) return;
        if (response != null) {
          setState(() {
            temp = (response.main.temp - 273.15).truncate().toString();
            maxTemp = (response.main.tempMax - 273.15).truncate().toString();
            minTemp = (response.main.tempMin - 273.15).truncate().toString();
            feelsLike =
                (response.main.feelsLike - 273.15).truncate().toString();
            description = response.weather[0].description;
            pressure = response.main.pressure.toString();
            humidity = response.main.humidity.toString();
            sunRise = DateFormat('jm').format(
                DateTime.fromMillisecondsSinceEpoch(response.sys.sunrise * 1000,
                        isUtc: true)
                    .toLocal());
            sunSet = DateFormat('jm').format(
                DateTime.fromMillisecondsSinceEpoch(response.sys.sunset * 1000,
                        isUtc: true)
                    .toLocal());
            clouds = response.clouds.all.toString();
            windSpeed = response.wind.speed.toString();
            final tempDate = response.dt;
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                tempDate * 1000,
                isUtc: true);
            date = DateFormat('dd-MM-yyyy').format(dateTime.toLocal());
            _createItem({
              "city": city,
              "temp": temp,
              "minTemp": minTemp,
              "maxTemp": maxTemp,
              "humidity": humidity,
              "feelsLike": feelsLike,
              "description": description,
              "pressure": pressure,
              "sunRise": sunRise,
              "sunSet": sunSet,
              "clouds": clouds,
              "windSpeed": windSpeed,
              "date": date,
              "day": day
            });
          });
        }
      }
    } else if (serviceNo == 2) {
      if (shared_pref.items.isNotEmpty) {
        final items02 = shared_pref.items;
        final cityData = items02[0];
        if (cityData.isNotEmpty) {
          setState(() {
            city = shared_pref.cityName ?? "";
            temp = cityData['temp'] ?? "";
            minTemp = cityData['minTemp'] ?? "";
            maxTemp = cityData['maxTemp'] ?? "";
            humidity = cityData['humidity'] ?? "";
            feelsLike = cityData['feelLike'] ?? "";
            description = cityData['description'] ?? "";
            pressure = cityData['pressure'] ?? "";
            sunRise = cityData['sunRise'] ?? "";
            sunSet = cityData['sunSet'] ?? "";
            clouds = cityData['clouds'] ?? "";
            windSpeed = cityData['windSpeed'] ?? "";
            date = cityData['date'];
            day = cityData['day'] ?? "";
          });
        } else {
          if (kDebugMode) {
            print("sab golmal hai bhaiya01");
          }
        }
      } else {
        if (kDebugMode) {
          print("sab golmal hai bhaiya02");
        }
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  final _testBox = Hive.box('city-weather');

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _testBox.add(newItem);
    _displayData();
  }

  void _displayData() {
    final data = _testBox.keys.map((key) {
      final item = _testBox.get(key);
      return {
        "key": key,
        "city": item['city'],
        "temp": item['temp'],
        "minTemp": item['minTemp'],
        "maxTemp": item['maxTemp'],
        "humidity": item['humidity'],
        "feelsLike": item['feelsLike'],
        "description": item['description'],
        "pressure": item['pressure'],
        "sunRise": item['sunRise'],
        "sunSet": item['sunSet'],
        "clouds": item['clouds'],
        "windSpeed": item['windSpeed'],
        "date": item['date'],
        "day": item['day']
      };
    }).toList();
    shared_pref.items = data.reversed.toList();
    if (kDebugMode) {
      print("items length is ->${shared_pref.items.length}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    serviceNo = args.serviceNo;
    city = args.city;
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => Scaffold(
              backgroundColor: const Color(0xFFB24727),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0xFFB24727),
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/city');
                    },
                    child:
                        const Icon(Icons.arrow_back_ios, color: Colors.white)),
              ),
              body: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$day, $date',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 1),
                            ),
                            Text(
                              city,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            ),
                            SizedBox(height: 35.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 15.h),
                                    child: Icon(
                                      Icons.cloud,
                                      color: Colors.white,
                                      size: 130.h,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$temp°C',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 45,
                                          fontFamily: "SF"),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      description,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "SFT"),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      '$feelsLike°C',
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontFamily: "SFT"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 270.h,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  dataContainer(ImageRes.highTemp, "Max.temp",
                                      '$maxTemp°C'),
                                  dataContainer(ImageRes.lowTemp, "Min.temp",
                                      '$minTemp°C'),
                                  dataContainer(ImageRes.pressureImage,
                                      "Pressure", '${pressure}hPa'),
                                  dataContainer(ImageRes.humidityImage,
                                      "Humidity", '$humidity%'),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSunInfo(sunRise, Icons.wb_sunny_outlined),
                                _buildSunInfo('$clouds%', Icons.cloud_queue),
                                _buildSunInfo('${windSpeed}knots', Icons.air),
                                _buildSunInfo(
                                    sunSet, Icons.nights_stay_outlined),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isLoading=true;
                                });
                                await _loadData();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 15.h),
                                height: 50.h,
                                width: 250.w,
                                decoration: appBoxDecoration(
                                    color: Colors.white,
                                    borderWidth: 1.h,
                                    radius: 10.h,
                                    borderColor: Colors.pink.shade100),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.refresh,color: Color(0xffB24727),),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text("Refresh",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            )
                            // Container(
                            //   padding: EdgeInsets.all(7.h),
                            //   alignment: Alignment.center,
                            //   decoration: BoxDecoration(
                            //     color: Colors.black.withOpacity(0.4),
                            //     borderRadius: BorderRadius.circular(10.h),
                            //   ),
                            //   width: 430.w,
                            //   height: 105.h,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       _buildForecast(
                            //           'THU', '6:00 PM', ImageRes.sunnyDayImage),
                            //       _buildForecast('FRI', '3:00 PM',
                            //           ImageRes.lightRainyDayImage),
                            //       _buildForecast('SAT', '12:00 PM',
                            //           ImageRes.sunnyDayImage),
                            //       _buildForecast(
                            //           'SUN', '9:00 AM', ImageRes.sunnyDayImage),
                            //       _buildForecast('MON', '6:00 AM',
                            //           ImageRes.lightRainyDayImage),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
            ));
  }

  Widget _buildSunInfo(String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 2.w),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

// Widget _buildForecast(String day, String time, String image) {
//   return Column(
//     children: [
//       Text(
//         day,
//         style: const TextStyle(color: Colors.white, fontSize: 16),
//       ),
//       SizedBox(
//         height: 5.h,
//       ),
//       Image.asset(
//         image,
//         height: 35.h,
//       ),
//       const Text(
//         "30°/25°",
//         style: TextStyle(color: Colors.white70, fontSize: 14),
//       ),
//     ],
//   );
// }
}

Widget dataContainer(
    String containerImage, String containerText, String textValue) {
  return Container(
    padding: EdgeInsets.all(5.h),
    margin: EdgeInsets.only(right: 7.h),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.4),
      borderRadius: BorderRadius.circular(10.h),
    ),
    height: 97.h,
    width: 85.w,
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          containerImage,
          height: 40.h,
          width: 30.h,
          color: Colors.white,
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          textValue,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "SF",
              fontWeight: FontWeight.w500),
        ),
        Text(
          containerText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "SFT",
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

BoxDecoration appBoxDecoration(
    {Color color = Colors.white,
    double radius = 15,
    double borderWidth = 1.5,
    Color borderColor = Colors.black}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth));
}
