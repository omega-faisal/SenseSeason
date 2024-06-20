
class WeatherResponse02 {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherEntry02> list;

  WeatherResponse02({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  factory WeatherResponse02.fromJson(Map<String, dynamic> json) {
    return WeatherResponse02(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: (json['list'] as List)
          .map((entry) => WeatherEntry02.fromJson(entry))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((entry) => entry.toJson()).toList(),
    };
  }
}

class WeatherEntry02 {
  final int dt;
  final Main02 main;
  final List<Weather02> weather;
  final Clouds02 clouds;
  final Wind02 wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final String dtTxt;
  final Rain? rain;

  WeatherEntry02({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    this.rain,
  });

  factory WeatherEntry02.fromJson(Map<String, dynamic> json) {
    return WeatherEntry02(
      dt: json['dt'],
      main: Main02.fromJson(json['main']),
      weather: (json['weather'] as List)
          .map((entry) => Weather02.fromJson(entry))
          .toList(),
      clouds: Clouds02.fromJson(json['clouds']),
      wind: Wind02.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((entry) => entry.toJson()).toList(),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'sys': sys.toJson(),
      'dt_txt': dtTxt,
      'rain': rain?.toJson(),
    };
  }
}

class Main02 {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  Main02({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main02.fromJson(Map<String, dynamic> json) {
    return Main02(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }
}

class Weather02 {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather02({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather02.fromJson(Map<String, dynamic> json) {
    return Weather02(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Clouds02 {
  final int all;

  Clouds02({required this.all});

  factory Clouds02.fromJson(Map<String, dynamic> json) {
    return Clouds02(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    return {'all': all};
  }
}

class Wind02 {
  final double speed;
  final int deg;
  final double gust;

  Wind02({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind02.fromJson(Map<String, dynamic> json) {
    return Wind02(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class Sys {
  final String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(pod: json['pod']);
  }

  Map<String, dynamic> toJson() {
    return {'pod': pod};
  }
}

class Rain {
  final double? threeH;

  Rain({this.threeH});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      threeH: json['3h']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '3h': threeH,
    };
  }
}


//WeatherResponse response = WeatherResponse.fromJson(json.decode(jsonString));
//   print(response.list[0].weather[0].description);  // Output: clear sky