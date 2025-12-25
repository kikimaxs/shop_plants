import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';
import '../../../data/models/item.dart';
import '../widgets/service_list_tile.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> items = List.generate(
      8,
      (i) => Item(
        title: 'Service $i',
        description: 'Service description',
        price: 'RM ${(i + 1) * 8}.00',
        imagePath: 'lib/assets/images/Image.jpg',
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) => ServiceListTile(item: items[i]),
      ),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}
