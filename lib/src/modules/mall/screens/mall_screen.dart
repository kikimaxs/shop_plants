import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';

class MallScreen extends StatefulWidget {
  const MallScreen({super.key});

  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _hasText = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.withValues(alpha: .3)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Image.asset(
                  'lib/assets/images/Icon - Search.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Salon',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                if (_hasText) ...[
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Image.asset(
                  'lib/assets/images/Icon - Filter.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.60,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            // Even position (2nd, 4th...) -> Index 1, 3... -> Discount
            final bool isDiscounted = (index + 1) % 2 == 0;
            return _buildCard(isDiscounted);
          },
        ),
      ),
      bottomNavigationBar: bottomBar(context, 1),
    );
  }

  Widget _buildCard(bool isDiscounted) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    'lib/assets/images/Image.jpg', // Using existing asset
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isDiscounted)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.asset(
                      'lib/assets/images/50.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lorem Ipsum',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Lorem ipsum dolor sit amet consectetur adipiscing elit',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                if (isDiscounted) ...[
                  Text(
                    'RM 100.00',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    'RM 50.00',
                    style: TextStyle(
                      color: Color(0xFF2DDA93), // Greenish color from image
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ] else
                  const Text(
                    'RM 100.00',
                    style: TextStyle(
                      color: Color(0xFF2DDA93), // Greenish color from image
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
