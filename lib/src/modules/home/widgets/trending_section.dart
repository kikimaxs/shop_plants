import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../components/cards/trending_card.dart';
import '../../../data/models/item.dart';

class TrendingSection extends StatefulWidget {
  const TrendingSection({super.key});

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  List<Item> _trending = [];

  @override
  void initState() {
    super.initState();
    _loadTrending();
  }

  Future<void> _loadTrending() async {
    try {
      final items = await TrendingData.load();
      if (mounted) {
        setState(() {
          _trending = items;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBanner(),
        _buildGrid(),
      ],
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/Trending Discoveries.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final left = <Widget>[];
    final right = <Widget>[];
    for (var i = 0; i < _trending.length; i++) {
      final bool tall = i % 4 == 0 || i % 4 == 3;
      final card = TrendingCard(item: _trending[i], tall: tall);
      final target = i.isEven ? left : right;
      target.add(card);
      if (i != _trending.length - 1) {
        target.add(const SizedBox(height: 12));
      }
    }
    return Container(
      color: const Color(0xFF112F22),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Column(children: left)),
            const SizedBox(width: 12),
            Expanded(child: Column(children: right)),
          ],
        ),
      ),
    );
  }
}
