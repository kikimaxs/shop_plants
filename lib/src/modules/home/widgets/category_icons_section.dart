import 'package:flutter/material.dart';

class CategoryIconsSection extends StatelessWidget {
  const CategoryIconsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      'lib/assets/images/Button - Icon 1.png',
      'lib/assets/images/Button - Icon 2.png',
      'lib/assets/images/Button - Icon 3.png',
      'lib/assets/images/Button - Icon 4.png',
      'lib/assets/images/Button - Icon 5.png',
    ];
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        separatorBuilder: (context, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F4F3),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(icons[index]),
            ),
          );
        },
      ),
    );
  }
}
