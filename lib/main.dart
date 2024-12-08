import 'package:flutter/material.dart';
import 'package:translation/Screens/home_page.dart';

void main() {
  runApp(const BlindAsistanceApplication());
}

class BlindAsistanceApplication extends StatelessWidget {
  const BlindAsistanceApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Homepage());
  }
}
