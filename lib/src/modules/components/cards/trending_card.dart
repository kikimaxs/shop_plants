import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart' show Item;
import 'dart:convert';
import 'package:flutter/services.dart';

class TrendingCard extends StatelessWidget {
  final Item item;
  final bool tall;
  const TrendingCard({super.key, required this.item, this.tall = false});

  @override
  Widget build(BuildContext context) {
    final double imageHeight = 160;
    final double cardHeight = tall ? 10 : 8;
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
          SizedBox(height: cardHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(item.description),
          ),
        ],
      ),
    );
  }
}

class TrendingData {
  static Future<List<Item>> load() async {
    final String data = await rootBundle.loadString(
      'lib/assets/data/trending.json',
    );
    final List<dynamic> list = json.decode(data);
    return list.map((e) {
      final m = e as Map<String, dynamic>;
      return Item(
        title: m['title'] ?? '',
        description: m['description'] ?? '',
        price: m['price'] ?? '',
        imagePath: m['imagePath'] ?? '',
      );
    }).toList();
  }
}
