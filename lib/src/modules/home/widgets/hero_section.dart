import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Image.asset(
        'lib/assets/images/Home Banner.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
