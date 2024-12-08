import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  late FlutterTts flutterTts;
  late stt.SpeechToText speechToText;
  final List<Map<String, String>> _chatMessages = [];
  bool _isLoading = false;
  String _userMessage = '';
  final String _languageCode = 'en-US'; // استخدام اللغة الإنجليزية

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    speechToText = stt.SpeechToText();
    _speakWelcomeMessage();
    _startListening(); // فتح الميكروفون تلقائيًا
  }

  // رسالة ترحيبية
  Future<void> _speakWelcomeMessage() async {
    await flutterTts.setLanguage(_languageCode);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak("Welcome to the Blind Assistance System.");
  }

  // بدء الاستماع
  Future<void> _startListening() async {
    bool available = await speechToText.initialize();
    if (available) {
      speechToText.listen(
        localeId: _languageCode,
        onResult: (result) {
          setState(() {
            _userMessage = result.recognizedWords;
          });

          // عند توقف المستخدم عن التحدث
          if (result.finalResult) {
            Future.delayed(const Duration(seconds: 1), () {
              _stopListening().then((_) {
                _sendMessage(); // بدء الرد الصوتي بعد إيقاف الميكروفون
              });
            });
          }
        },
      );
    }
  }

  // إيقاف الاستماع
  Future<void> _stopListening() async {
    await speechToText.stop();
  }

  // إرسال الرسالة والرد الصوتي
  Future<void> _sendMessage() async {
    if (_userMessage.isEmpty) return;

    setState(() {
      _isLoading = true;
      _chatMessages.add({"role": "user", "message": _userMessage});
    });

    String botResponse = _userMessage; // الرد هو النص الذي قاله المستخدم

    setState(() {
      _isLoading = false;
      _chatMessages.add({"role": "bot", "message": botResponse});
    });

    // الرد الصوتي باستخدام نفس النص
    await flutterTts.setLanguage(_languageCode);
    await flutterTts.speak(botResponse);

    // إعادة فتح الميكروفون للاستماع مرة أخرى
    _startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF6DB),
      appBar: AppBar(
        title: const Text(
          'Blind Assistance System',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: const Color(0xff46322B),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                final isUser = message["role"] == "user";
                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message["message"] ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _userMessage.isEmpty ? "Speak now..." : _userMessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
