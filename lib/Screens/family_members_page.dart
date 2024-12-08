import 'package:flutter/material.dart';
import 'package:translation/componants/numbers_page_componant.dart';
import 'package:translation/models/number_class.dart';

class FamilyMembersPage extends StatelessWidget {
  const FamilyMembersPage({Key? kay}) : super(key: kay);
  final List<Number> numbers = const [
    Number(
        image: 'assets/images/family_members/family_father.png',
        jpName: 'ichi',
        enName: 'Father',
        sound: 'sounds/numbers/number_one_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_mother.png',
        jpName: 'Ni',
        enName: 'Mother',
        sound: 'sounds/numbers/number_two_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_grandfather.png',
        jpName: 'San',
        enName: 'Grand Father',
        sound: 'sounds/numbers/number_three_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_grandmother.png',
        jpName: 'Shi',
        enName: 'Grand Mother',
        sound: 'sounds/numbers/number_four_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_son.png',
        jpName: 'Go',
        enName: 'Son',
        sound: 'sounds/numbers/number_five_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_daughter.png',
        jpName: 'Roku',
        enName: 'Daughter',
        sound: 'sounds/numbers/number_six_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_older_brother.png',
        jpName: 'Sebun',
        enName: 'Older Brother ',
        sound: 'sounds/numbers/number_seven_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_older_sister.png',
        jpName: 'Hachi',
        enName: 'Older Sister',
        sound: 'sounds/numbers/number_eight_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_younger_brother.png',
        jpName: 'Kyu',
        enName: 'Younger Brother',
        sound: 'sounds/numbers/number_nine_sound.wav'),
    Number(
        image: 'assets/images/family_members/family_younger_sister.png',
        jpName: 'Ju',
        enName: 'Younger Sister',
        sound: 'sounds/numbers/number_ten_sound.wav'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff46322B),
        title: const Text('My Location .',
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: ListView.builder(
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return Items(
              number: numbers[index],
              color: const Color(0xff558B37),
            );
          }),
    );
  }
}
