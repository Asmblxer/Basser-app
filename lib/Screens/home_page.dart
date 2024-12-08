import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translation/Screens/bluetooth_page.dart';
import 'package:translation/Screens/chat_page.dart';
// import 'package:translation/Screens/family_members_page.dart';
import 'package:translation/Screens/numbers_page.dart';
import 'package:translation/Screens/speech_to_text.dart';
import 'package:translation/componants/category_file.dart';
import 'package:translation/Screens/text_to_speech.dart';
import 'package:translation/Screens/location.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late FlutterTts flutterTts; // تعريف كائن Text-to-Speech

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speakWelcomeMessage(); // تشغيل الرسالة الترحيبية
  }

  // رسالة صوتية ترحيبية
  Future<void> _speakWelcomeMessage() async {
    await flutterTts.setLanguage("en-US"); // تعيين اللغة
    await flutterTts.setPitch(1.0); // تعيين طبقة الصوت
    await flutterTts
        .speak("Welcome to the blind application system ."); // الرسالة الصوتية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF6DB),
      appBar: AppBar(
        title: const Text(
          'Blind System .',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: const Color(0xff46322B),
      ),
      body: Column(
        children: [
          Category(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NumbersPage();
              }));
            },
            text: 'Get My Information',
            color: const Color(0xffEF9235),
          ),
          Category(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SpeechToTextPage();
              }));
            },
            text: 'Speech To Text',
            color: const Color(0xff79359F),
          ),
          Category(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Location();
              }));
            },
            text: 'Get Location . ',
            color: const Color(0xff558B37),
          ),
          Category(text: 'Recognize Things .', color: const Color(0xff50ADC7)),
          Category(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TextToSpeechExample();
                }));
              },
              text: 'Text To Speech .',
              color: const Color(0xffEF9235)),
          Category(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const BluetoothConnectPage();
                }));
              },
              text: 'Bluetooth .',
              color: const Color(0xff79359F)),
          Category(
            text: 'Get Location Of Places .',
            color: const Color(0xff558B37),
          ),
          Category(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Chatpage();
              }));
            },
            text: 'BAS Chat . ',
            color: const Color(0xff50ADC7),
          ) ,
        ],
      ),
    );
  }
}
