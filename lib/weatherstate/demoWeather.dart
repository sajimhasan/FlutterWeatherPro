import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_01/const.dart'; // Make sure this has your OPENWEATHER_API_KEY
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather/weather.dart';

class Demoweather extends StatefulWidget {
  const Demoweather({super.key});

  @override
  State<Demoweather> createState() => _DemoweatherState();
}

class _DemoweatherState extends State<Demoweather> {
  final WeatherFactory _weatherFactory =
      WeatherFactory(OPENWEATHER_API_KEY, language: Language.ENGLISH);
  Weather? _weather;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWeatherFromLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _builderbody(),
    );
  }

  Widget _builderbody() {
    if (_weather == null && _errorMessage == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Fetching weather...", style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(3, -0.3),
              child: _buildCircle(Colors.deepPurpleAccent),
            ),
            Align(
              alignment: AlignmentDirectional(-3, -0.3),
              child: _buildCircle(Colors.deepPurpleAccent),
            ),
            Align(
              alignment: AlignmentDirectional(0, -1.2),
              child: _buildCircle(Colors.orange, size: 300, shape: BoxShape.rectangle),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(color: Colors.transparent),
            ),
            _mainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(Color color, {double size = 400, BoxShape shape = BoxShape.circle}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: shape),
    );
  }

  Widget _mainContent() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Text("", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          Text(
            "Today's Weather",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: _weathericons(),
            ),
          ),
          Center(child: _correntTemp()),
          Center(child: _datebuilder()),
          Spacer(),
          _infoRow("Sunset", "images/3.png", _sunset()),
          SizedBox(height: 10),
          _infoRow("Sunrise", "images/6.png", _sunrice()),
          SizedBox(height: 10),
          _infoRow("Low Temperature", "images/5.png", _lowTump()),
          SizedBox(height: 10),
          _infoRow("High Temperature", "images/4.png", _maxtump()),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String imagePath, Widget valueWidget) {
    return Row(
      children: [
        Image.asset(imagePath, scale: 4),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            valueWidget,
          ],
        ),
      ],
    );
  }

  Widget _datebuilder() {
    final now = _weather!.date!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat("h:mm a").format(now),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22)),
            SizedBox(width: 10),
            Text(DateFormat("EEEE").format(now),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22)),
          ],
        ),
        Text(DateFormat("d.M.y").format(now),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _weathericons() {
    final iconCode = _weather?.weatherIcon;
    if (iconCode == null) {
      return Icon(Icons.cloud_off, color: Colors.white, size: 80);
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("http://openweathermap.org/img/wn/${iconCode}@4x.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _correntTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(1)}C",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _maxtump() {
    return Text(
      "${_weather?.tempMax?.celsius?.toStringAsFixed(0)}",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _lowTump() {
    return Text(
      "${_weather?.tempMin?.celsius?.toStringAsFixed(0)}",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _sunset() {
    return Text(
      "${_weather?.sunset}",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _sunrice() {
    return Text(
      "${_weather?.sunrise}",
      style: TextStyle(color: Colors.white),
    );
  }

  Future<void> _fetchWeatherFromLocation() async {
    Location location = Location();

    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() => _errorMessage = "Location service not enabled.");
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() => _errorMessage = "Location permission denied.");
          return;
        }
      }

      LocationData locationData = await location.getLocation();
      print("Location: ${locationData.latitude}, ${locationData.longitude}");

      final weather = await _weatherFactory.currentWeatherByLocation(
        locationData.latitude!,
        locationData.longitude!,
      );

      print("Weather fetched: ${weather.toString()}");

      setState(() {
        _weather = weather;
        _errorMessage = null;
      });
    } catch (e) {
      print("Failed to fetch weather: $e");
      setState(() => _errorMessage = "Error fetching weather data.");
    }
  }
}