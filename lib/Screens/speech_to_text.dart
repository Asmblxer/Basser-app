import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const SpeechToText());
}

class SpeechToText extends StatelessWidget {
  const SpeechToText({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpeechToTextPage(),
    );
  }
}

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  late stt.SpeechToText _speech; // مكتبة تحويل الصوت إلى نص
  late FlutterTts flutterTts; // مكتبة تحويل النص إلى صوت
  bool _isListening = false; // للتحقق إذا كان الجهاز يستمع
  String _text = "Press the button and start speaking..."; // النص الناتج

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    flutterTts = FlutterTts();
    _speakWelcomeMessage(); // تشغيل الرسالة الترحيبية عند الدخول للصفحة
  }

  // تشغيل الرسالة الترحيبية
  Future<void> _speakWelcomeMessage() async {
    await flutterTts.setLanguage("en-US"); // تعيين اللغة الإنجليزية
    await flutterTts.setPitch(1.0); // ضبط حدة الصوت
    await flutterTts.speak(
        "You are now in speech to text page. You can now speak and we will transfer your sound into text."); // تشغيل الرسالة
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('Status: $val'),
        onError: (val) => print('Error: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech to Text'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  _text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _listen,
              icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
              label: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
