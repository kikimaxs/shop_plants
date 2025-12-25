import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ShopPlantsSection extends StatefulWidget {
  const ShopPlantsSection({super.key});

  @override
  State<ShopPlantsSection> createState() => _ShopPlantsSectionState();
}

class _ShopPlantsSectionState extends State<ShopPlantsSection> {
  final ScrollController _shopScrollController = ScrollController();
  double _shopScrollValue = 0.0;

  @override
  void initState() {
    super.initState();
    _shopScrollController.addListener(_onShopScroll);
  }

  @override
  void dispose() {
    _shopScrollController.dispose();
    super.dispose();
  }

  void _onShopScroll() {
    if (!_shopScrollController.hasClients) return;
    final max = _shopScrollController.position.maxScrollExtent;
    final off = _shopScrollController.offset.clamp(0.0, max);
    setState(() {
      _shopScrollValue = max > 0 ? (off / max) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      'lib/assets/images/Shop Plants - Icon 1.png',
      'lib/assets/images/Shop Plants - Icon 2.png',
      'lib/assets/images/Shop Plants - Icon 3.png',
      'lib/assets/images/Shop Plants - Icon 4.png',
      'lib/assets/images/Shop Plants - Icon 5.png',
    ];

    return Container(
      padding: const EdgeInsets.only(top: 16),
      color: const Color(0xFFF4F4F4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildLogo(),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: _buildSlider(icons)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildCustomScrollIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 100,
      child: Container(
        height: 104,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFF4F4F4), Color(0xFFF4F4F4)],
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'lib/assets/images/Shop Plants - Icon Main.png',
            height: 104,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(List<String> icons) {
    return SizedBox(
      height: 94,
      child: Stack(
        children: [
          ListView.separated(
            controller: _shopScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: icons.length,
            separatorBuilder: (context, _) => const SizedBox(width: 2),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 94,
                height: 94,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Image.asset(icons[index]),
                ),
              );
            },
          ),
          _buildFadeOverlay(isLeft: true),
          _buildFadeOverlay(isLeft: false),
        ],
      ),
    );
  }

  Widget _buildFadeOverlay({required bool isLeft}) {
    return Positioned(
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Container(
          width: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
              colors: [
                const Color(0xFFF4F4F4),
                const Color(0xFFF4F4F4).withValues(alpha: .0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomScrollIndicator() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double trackWidth = constraints.maxWidth;
        final double knobWidth = 40;
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            final double newPosition =
                (_shopScrollValue * trackWidth) + details.delta.dx;
            final double newScrollValue = (newPosition / trackWidth).clamp(
              0.0,
              1.0,
            );
            setState(() {
              _shopScrollValue = newScrollValue;
            });
            if (_shopScrollController.hasClients) {
              final double max = _shopScrollController.position.maxScrollExtent;
              _shopScrollController.jumpTo(newScrollValue * max);
            }
          },
          child: SizedBox(
            height: 20,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Container(height: 2, color: AppColors.primary),
                  ),
                ),
                Positioned(
                  left: _shopScrollValue * (trackWidth - knobWidth),
                  top: 6,
                  child: Container(
                    width: knobWidth,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .12),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
