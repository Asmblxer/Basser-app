import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const BluetoothConnectApp());
}

class BluetoothConnectApp extends StatelessWidget {
  const BluetoothConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BluetoothConnectPage(),
    );
  }
}

class BluetoothConnectPage extends StatefulWidget {
  const BluetoothConnectPage({super.key});

  @override
  _BluetoothConnectPageState createState() => _BluetoothConnectPageState();
}

class _BluetoothConnectPageState extends State<BluetoothConnectPage> {
  late FlutterBluePlus flutterBlue; // تعريف متغير flutterBlue
  late FlutterTts flutterTts; // تعريف متغير Text-to-Speech
  List<BluetoothDevice> devicesList = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBluePlus(); // تهيئة كائن flutterBlue بشكل صحيح
    flutterTts = FlutterTts(); // تهيئة كائن flutterTts
    _speakWelcomeMessage(); // تشغيل الرسالة الصوتية
    _startScan();
  }

  // رسالة صوتية ترحيبية
  Future<void> _speakWelcomeMessage() async {
    await flutterTts.setLanguage("en-US"); // تعيين اللغة
    await flutterTts.setPitch(1.0); // تعيين طبقة الصوت
    await flutterTts.speak("You are now in Bluetooth page."); // الرسالة الصوتية
  }

  // بدء البحث عن الأجهزة
  void _startScan() {
    if (_isScanning) return; // التحقق إذا كان البحث جاريًا بالفعل
    setState(() => _isScanning = true);
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devicesList.contains(result.device)) {
          setState(() {
            devicesList.add(result.device); // إضافة الجهاز إلى القائمة
          });
        }
      }
    });
  }

  // إيقاف البحث
  void _stopScan() {
    FlutterBluePlus.stopScan();
    setState(() {
      _isScanning = false;
    });
  }

  // الاتصال بالجهاز
  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to ${device.name}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect: $e")),
      );
    }
  }

  @override
  void dispose() {
    _stopScan(); // إيقاف البحث عندما يتم التخلص من الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Device Connection'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Available Devices:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: devicesList.length,
                itemBuilder: (context, index) {
                  final device = devicesList[index];
                  return ListTile(
                    title: Text(
                      device.name.isEmpty ? "Unknown Device" : device.name,
                    ),
                    subtitle: Text(device.id.toString()),
                    trailing: ElevatedButton(
                      onPressed: () => _connectToDevice(device),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text("Connect"),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _isScanning ? _stopScan : _startScan,
              icon: Icon(_isScanning ? Icons.stop : Icons.search),
              label: Text(_isScanning ? 'Stop Scanning' : 'Start Scanning'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
