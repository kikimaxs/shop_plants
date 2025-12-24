import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart' show Item;

class TrendingCard extends StatelessWidget {
  final Item item;
  final bool tall;
  const TrendingCard({super.key, required this.item, this.tall = false});

  @override
  Widget build(BuildContext context) {
    final double imageHeight = tall ? 160 : 120;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              item.imagePath,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('Lorem Ipsum', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(item.description),
          ),
        ],
      ),
    );
  }
}
