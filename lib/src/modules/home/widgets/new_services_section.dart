import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/item.dart';

class NewServicesSection extends StatelessWidget {
  const NewServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> newServices = List.generate(
      6,
      (i) => Item(
        title: 'Lorem Ipsum',
        description: 'Lorem ipsum dolor sit amet consectetur',
        price: 'RM 10.00',
        imagePath: 'lib/assets/images/Image.jpg',
      ),
    );

    return Container(
      color: const Color(0xFFF4F4F4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NEW SERVICES',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Recommended based on your preference',
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: .5),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: newServices.length,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                separatorBuilder: (context, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    _serviceCard(newServices[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceCard(Item item) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Container(
              color: const Color(0xFFF4F4F4),
              child: Image.asset(
                item.imagePath,
                height: 120,
                width: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('Lorem Ipsum', style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              item.price,
              style: const TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
