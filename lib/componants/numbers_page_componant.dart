import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:translation/models/number_class.dart';

class Items extends StatelessWidget {
  const Items({super.key, required this.number, required this.color});
  final Number number;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        color: color,
        child: Row(
          children: [
            Container(
                color: const Color(0xffFFF6DC),
                child: Image.asset(number.image)),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number.jpName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    number.enName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 220),
                child: IconButton(
                    onPressed: () {
                      final player = AudioPlayer();
                      player.play(AssetSource(number.sound));
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 32,
                    ))

                )
          ],
        ));
  }
}
