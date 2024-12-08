import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextToSpeechExample(),
    );
  }
}

class TextToSpeechExample extends StatefulWidget {
  const TextToSpeechExample({super.key});

  @override
  _TextToSpeechExampleState createState() => _TextToSpeechExampleState();
}

class _TextToSpeechExampleState extends State<TextToSpeechExample> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _controller = TextEditingController();

  // إعدادات الصوت الافتراضية
  final double _pitch = 1.0; // النغمة
  final double _speed = 0.5; // سرعة الكلام
  final String _language = "en-US"; // اللغة الافتراضية

  @override
  void initState() {
    super.initState();
    _setTtsSettings();
    _speakWelcomeMessage(); // تشغيل الرسالة الترحيبية
  }

  // تهيئة إعدادات الصوت
  Future<void> _setTtsSettings() async {
    await flutterTts.setPitch(_pitch);
    await flutterTts.setSpeechRate(_speed);
    await flutterTts.setLanguage(_language);
  }

  // رسالة ترحيبية عند فتح الصفحة
  Future<void> _speakWelcomeMessage() async {
    await flutterTts.speak(
        "You are now in the Text-to-Speech page.  we will convert it into speech.");
  }

  // وظيفة التحدث
  Future<void> _speak() async {
    String text = _controller.text;
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  // وظيفة التوقف
  Future<void> _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text-to-Speech Example'),
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
                'Enter Text to Speak:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Type here...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.text_fields),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _speak,
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Speak'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _stop,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
