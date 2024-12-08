import 'package:flutter/material.dart';
import 'package:translation/componants/numbers_page_componant.dart';
import 'package:translation/models/number_class.dart';
import 'package:flutter_tts/flutter_tts.dart'; // مكتبة تحويل النص إلى صوت

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  final FlutterTts flutterTts = FlutterTts(); // كائن لتحويل النص إلى صوت

  final List<Number> numbers = const [
    Number(
        image: 'assets/images/number_one.png',
        jpName: 'ichi',
        enName: 'One',
        sound: 'sounds/numbers/number_one_sound.wav'),
    Number(
        image: 'assets/images/number_two.png',
        jpName: 'Ni',
        enName: 'Two',
        sound: 'sounds/numbers/number_two_sound.wav'),
    Number(
        image: 'assets/images/number_three.png',
        jpName: 'San',
        enName: 'Three',
        sound: 'sounds/numbers/number_three_sound.wav'),
    Number(
        image: 'assets/images/number_four.png',
        jpName: 'Shi',
        enName: 'Four',
        sound: 'sounds/numbers/number_four_sound.wav'),
    Number(
        image: 'assets/images/number_five.png',
        jpName: 'Go',
        enName: 'Five',
        sound: 'sounds/numbers/number_five_sound.wav'),
    Number(
        image: 'assets/images/number_six.png',
        jpName: 'Roku',
        enName: 'Six',
        sound: 'sounds/numbers/number_six_sound.wav'),
    Number(
        image: 'assets/images/number_seven.png',
        jpName: 'Sebun',
        enName: 'Seven',
        sound: 'sounds/numbers/number_seven_sound.wav'),
    Number(
        image: 'assets/images/number_eight.png',
        jpName: 'Hachi',
        enName: 'Eight',
        sound: 'sounds/numbers/number_eight_sound.wav'),
    Number(
        image: 'assets/images/number_nine.png',
        jpName: 'Kyu',
        enName: 'Nine',
        sound: 'sounds/numbers/number_nine_sound.wav'),
    Number(
        image: 'assets/images/number_ten.png',
        jpName: 'Ju',
        enName: 'Ten',
        sound: 'sounds/numbers/number_ten_sound.wav'),
  ];

  @override
  void initState() {
    super.initState();
    _speakWelcomeMessage(); // تشغيل الرسالة الترحيبية عند فتح الصفحة
  }

  Future<void> _speakWelcomeMessage() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak("You are now get your information page we will appear this information now .");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff46322B),
        title: const Center(
          child: Text('Your Information Page',
              style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
      ),
      body: ListView.builder(
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return Items(
              number: numbers[index],
              color: const Color(0xffEF9235),
            );
          }),
    );
  }
}
