import 'package:flutter/material.dart';

import 'weather_model.dart';
import 'rest_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CIS 3334 Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<List<DailyForcast>> futureWeatherForcasts;

  @override
  void initState() {
    // call fetchWeather...
    print('in InitState about to get weather...');
    futureWeatherForcasts = fetchWeather();
  }

  Widget weatherTile (DailyForcast dailyForcast) {
    //print ("Inside weatherTile and setting up tile for positon ${position}");
    return ListTile(
      leading: weatherIcon(dailyForcast.weather[0].main),
      title: Text('Temperature will be ${dailyForcast.temp.day.toString()}'),
      subtitle: Text(dailyForcast.weather[0].main),
    );
  }

  Image weatherIcon(String weatherDescription) {
    if (weatherDescription == "Rain") {
      return Image(image: AssetImage('graphics/rain.png'));
    }
    if (weatherDescription == "Clouds") {
      return Image(image: AssetImage('graphics/cloud.png'));
    }
    return Image(image: AssetImage('graphics/sun.png'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: futureWeatherForcasts,
        builder: (context, snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.none) {
            return Container();
            // TODO: add loading text field
          }
          List<DailyForcast> myForcastList = snapshot.data!;
          return ListView.builder(
            itemCount: myForcastList.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: weatherTile(myForcastList[position]),
              );
            },
          );
        }
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
