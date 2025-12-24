import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../components/cards/trending_card.dart';

class Item {
  final String title;
  final String description;
  final String price;
  final String imagePath;
  Item({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color _green = const Color(0xFF164A3A);
  LatLng? _currentLatLng;
  bool _locLoading = false;
  String? _locError;
  final List<Item> _newServices = List.generate(
    6,
    (i) => Item(
      title: 'Lorem Ipsum',
      description: 'Lorem ipsum dolor sit amet consectetur',
      price: 'RM 10.00',
      imagePath: 'lib/assets/images/Image.jpg',
    ),
  );
  final List<Item> _trending = List.generate(
    8,
    (i) => Item(
      title: 'Lorem Ipsum',
      description: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      price: 'RM 10.00',
      imagePath: 'lib/assets/images/Image.jpg',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildHero()),
          SliverToBoxAdapter(child: _buildPrimaryActions()),
          SliverToBoxAdapter(child: _buildCategoryIcons()),
          SliverToBoxAdapter(child: _buildNewServices()),
          SliverToBoxAdapter(child: _buildShopPlants()),
          SliverToBoxAdapter(child: _buildTrendingBanner()),
          SliverToBoxAdapter(child: _buildTrendingGrid()),
          SliverToBoxAdapter(child: _buildLocationSection()),
        ],
      ),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    setState(() {
      _locLoading = true;
      _locError = null;
    });
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location service disabled');
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLatLng = LatLng(pos.latitude, pos.longitude);
      });
    } catch (e) {
      setState(() {
        _locError = e.toString();
      });
    } finally {
      setState(() {
        _locLoading = false;
      });
    }
  }

  Widget _buildHeader() {
    return Container(
      color: _green,
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'LOGO',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'NEXT APPOINTMENT',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: .8),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _roundedIcon('lib/assets/images/Icon - Calender.png'),
              const SizedBox(width: 8),
              Text(
                '14 Oct 2020',
                style: TextStyle(color: Colors.white.withValues(alpha: .9)),
              ),
              const SizedBox(width: 16),
              _roundedIcon('lib/assets/images/Icon - Clock.png'),
              const SizedBox(width: 8),
              Text(
                '12:30 PM',
                style: TextStyle(color: Colors.white.withValues(alpha: .9)),
              ),
              const SizedBox(width: 16),
              _roundedIcon('lib/assets/images/Icon - Location.png'),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '123 Plant Street, 1/1 ...',
                  style: TextStyle(color: Colors.white.withValues(alpha: .9)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _circleButton('lib/assets/images/Icon -Arrow.png'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _infoCard('CREDIT', 'RM100.00')),
              const SizedBox(width: 12),
              Expanded(child: _infoCard('POINTS', '10')),
              const SizedBox(width: 12),
              Expanded(child: _infoCard('PACKAGE', '1')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundedIcon(String path) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(path, fit: BoxFit.contain),
      ),
    );
  }

  Widget _circleButton(String path) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .15),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Image.asset(path, fit: BoxFit.contain),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: _green.withValues(alpha: .8), fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: _green,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return SizedBox(
      height: 200,
      child: Image.asset(
        'lib/assets/images/Home Banner.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPrimaryActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: _primaryButton(
              'SHOP',
              () => Navigator.pushNamed(context, '/shop'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _primaryButton(
              'SERVICES',
              () => Navigator.pushNamed(context, '/services'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _primaryButton(
              'POSTS',
              () => Navigator.pushNamed(context, '/posts'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton(String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(label),
    );
  }

  Widget _buildCategoryIcons() {
    final icons = [
      'lib/assets/images/Button - Icon 1.png',
      'lib/assets/images/Button - Icon 2.png',
      'lib/assets/images/Button - Icon 3.png',
      'lib/assets/images/Button - Icon 4.png',
      'lib/assets/images/Button - Icon 5.png',
    ];
    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        separatorBuilder: (context, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F3),
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

  Widget _buildNewServices() {
    return Padding(
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
              Text('View All', style: TextStyle(color: _green)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _newServices.length,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              separatorBuilder: (context, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  _serviceCard(_newServices[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(Item item, {bool withShadow = true}) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
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
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('Lorem Ipsum', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
              style: TextStyle(color: _green, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopPlants() {
    final icons = [
      'lib/assets/images/Shop Plants - Icon 1.png',
      'lib/assets/images/Shop Plants - Icon 2.png',
      'lib/assets/images/Shop Plants - Icon 3.png',
      'lib/assets/images/Shop Plants - Icon 4.png',
      'lib/assets/images/Shop Plants - Icon 5.png',
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'lib/assets/images/Shop Plants - Icon Main.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 78,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: icons.length,
              separatorBuilder: (context, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) => Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F3),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(icons[index]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  color: _green,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingBanner() {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: _green)),
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

  Widget _buildTrendingGrid() {
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

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LOCATION', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 220,
              child: _locLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _currentLatLng != null
                  ? FlutterMap(
                      options: MapOptions(
                        initialCenter: _currentLatLng!,
                        initialZoom: 14,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLatLng!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_locError ?? 'Location belum aktif'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _initLocation,
                            child: const Text('Aktifkan Lokasi'),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          _locationTile(
            'Sunway Pyramid',
            '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
            '10am - 10pm',
          ),
          const SizedBox(height: 12),
          _locationTile(
            'The Gardens Mall',
            '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
            '10am - 10pm',
          ),
        ],
      ),
    );
  }

  Widget _locationTile(String title, String address, String hours) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Row(
          children: [
            Image.asset(
              'lib/assets/images/Icon - Location.png',
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(address, style: TextStyle(color: _green)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Image.asset(
              'lib/assets/images/Icon - Clock.png',
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 8),
            Text(hours),
          ],
        ),
      ],
    );
  }
}

Widget bottomBar(BuildContext context, int currentIndex) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 8),
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(
              context,
              0,
              currentIndex,
              'lib/assets/images/Nav Icon - Home.png',
              'lib/assets/images/Nav Icon - Home Green.png',
              '/home',
            ),
            _navItem(
              context,
              1,
              currentIndex,
              'lib/assets/images/Nav Icon - Mall.png',
              'lib/assets/images/Nav Icon - Mall Green.png',
              '/mall',
            ),
            _navItem(
              context,
              2,
              currentIndex,
              'lib/assets/images/Nav Icon - Discover.png',
              'lib/assets/images/Nav Icon - Discover.png',
              '/discover',
            ),
            _navItem(
              context,
              3,
              currentIndex,
              'lib/assets/images/Nav Icon - Inbox.png',
              'lib/assets/images/Nav Icon - Inbox.png',
              '/inbox',
            ),
            _navItem(
              context,
              4,
              currentIndex,
              'lib/assets/images/Nav Icon - Account.png',
              'lib/assets/images/Nav Icon - Account.png',
              '/account',
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _navItem(
  BuildContext context,
  int index,
  int currentIndex,
  String normalPath,
  String activePath,
  String route,
) {
  final bool active = currentIndex == index;
  return GestureDetector(
    onTap: () {
      if (!active) {
        Navigator.pushReplacementNamed(context, route);
      }
    },
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFE9F2EE) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Image.asset(
          active ? activePath : normalPath,
          width: 26,
          height: 26,
        ),
      ),
    ),
  );
}

class MallScreen extends StatelessWidget {
  const MallScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Mall')),
      bottomNavigationBar: bottomBar(context, 1),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Discover')),
      bottomNavigationBar: bottomBar(context, 2),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Inbox')),
      bottomNavigationBar: bottomBar(context, 3),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Account')),
      bottomNavigationBar: bottomBar(context, 4),
    );
  }
}

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
          itemBuilder: (_, i) => _ShopItemCard(item: items[i]),
        ),
      ),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}

class _ShopItemCard extends StatelessWidget {
  final Item item;
  const _ShopItemCard({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(
              item.imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(item.title, style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              item.description,
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
                color: Color(0xFF164A3A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
        itemBuilder: (context, i) => _ServiceListTile(item: items[i]),
      ),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}

class _ServiceListTile extends StatelessWidget {
  final Item item;
  const _ServiceListTile({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              item.imagePath,
              width: 120,
              height: 96,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  item.price,
                  style: const TextStyle(color: Color(0xFF164A3A)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: const Center(child: Text('Posts content')),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}
