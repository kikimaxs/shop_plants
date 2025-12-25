import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';
import '../../../data/models/item.dart';
import '../widgets/shop_item_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> items = List.generate(
      10,
      (i) => Item(
        title: 'Plant $i',
        description: 'Nice plant',
        price: 'RM ${(i + 1) * 5}.00',
        imagePath: 'lib/assets/images/Image.jpg',
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: items.length,
          itemBuilder: (_, i) => ShopItemCard(item: items[i]),
        ),
      ),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}
