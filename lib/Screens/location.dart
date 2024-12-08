import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const Location());
}

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationExample(),
    );
  }
}

class LocationExample extends StatefulWidget {
  const LocationExample({super.key});

  @override
  _LocationExampleState createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  late FlutterTts flutterTts; // متغير لتشغيل الرسائل الصوتية
  double _latitude = 0.0;
  double _longitude = 0.0;
  double _distance = 0.0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts(); // تهيئة مكتبة النص إلى كلام
    _speakWelcomeMessage(); // تشغيل الرسالة الترحيبية
  }

  // تشغيل الرسالة الترحيبية
  Future<void> _speakWelcomeMessage() async {
    await flutterTts.setLanguage("en-US"); // تعيين اللغة
    await flutterTts.setPitch(1.0); // ضبط درجة الصوت
    await flutterTts.speak("You are now in the location page.   Now You can get your current location and calculate the distance between your current location and another location ."); // تشغيل الرسالة
  }

  // Function to get current location
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  // Function to calculate distance between current location and entered location
  Future<void> _getDistance() async {
    double destinationLatitude = 0.0;
    double destinationLongitude = 0.0;

    // Assuming user enters coordinates manually in the format "lat, lon"
    if (_controller.text.isNotEmpty) {
      List<String> coordinates = _controller.text.split(",");
      if (coordinates.length == 2) {
        destinationLatitude = double.parse(coordinates[0].trim());
        destinationLongitude = double.parse(coordinates[1].trim());

        double distanceInMeters = Geolocator.distanceBetween(
            _latitude, _longitude, destinationLatitude, destinationLongitude);

        setState(() {
          _distance = distanceInMeters / 1000; // Convert to kilometers
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Example'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Get Your Current Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Latitude: $_latitude, Longitude: $_longitude',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Destination Coordinates (Latitude, Longitude):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'e.g., 37.7749, -122.4194',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.place),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _getDistance,
                icon: const Icon(Icons.calculate),
                label: const Text('Get Distance'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              if (_distance > 0)
                Text(
                  'Distance: ${_distance.toStringAsFixed(2)} km',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
