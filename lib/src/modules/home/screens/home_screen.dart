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
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }
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
  final ScrollController _shopScrollController = ScrollController();
  double _shopScrollValue = 0.0;
  final List<Item> _newServices = List.generate(
    6,
    (i) => Item(
      title: 'Lorem Ipsum',
      description: 'Lorem ipsum dolor sit amet consectetur',
      price: 'RM 10.00',
      imagePath: 'lib/assets/images/Image.jpg',
    ),
  );
  List<Item> _trending = [];

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
    _loadTrending();
    _shopScrollController.addListener(() {
      if (!_shopScrollController.hasClients) return;
      final max = _shopScrollController.position.maxScrollExtent;
      final off = _shopScrollController.offset.clamp(0.0, max);
      setState(() {
        _shopScrollValue = max > 0 ? (off / max) : 0.0;
      });
    });
  }

  @override
  void dispose() {
    _shopScrollController.dispose();
    super.dispose();
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

  Future<void> _loadTrending() async {
    try {
      final items = await TrendingData.load();
      setState(() {
        _trending = items;
      });
    } catch (_) {}
  }

  Widget _buildHeader() {
    return Container(
      color: _green,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'LOGO',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: .5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'NEXT APPOINTMENT',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: .5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                'lib/assets/images/Icon - Calender.png',
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                '14 Oct 2020',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .9),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'lib/assets/images/Icon -Clock.png',
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                '12:30 PM',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .9),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'lib/assets/images/Icon - Location.png',
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '123 Plant Street, 1/1 ...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .9),
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .2),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'lib/assets/images/Icon -Arrow.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(child: _statItem('CREDIT', 'RM100.00')),
                Container(
                  width: 1,
                  height: 32,
                  color: Colors.grey.withValues(alpha: .3),
                ),
                Expanded(child: _statItem('POINTS', '10')),
                Container(
                  width: 1,
                  height: 32,
                  color: Colors.grey.withValues(alpha: .3),
                ),
                Expanded(child: _statItem('PACKAGE', '1')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: _green,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: _green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
                Text('View All', style: TextStyle(color: _green)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _newServices.length,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                separatorBuilder: (context, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    _serviceCard(_newServices[index]),
              ),
            ),
          ],
        ),
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
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
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
    return Container(
      padding: const EdgeInsets.only(top: 16),
      color: const Color(0xFFF4F4F4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
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
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 94,
                    child: Stack(
                      children: [
                        ListView.separated(
                          controller: _shopScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: icons.length,
                          separatorBuilder: (context, _) =>
                              const SizedBox(width: 2),
                          itemBuilder: (context, index) => Container(
                            width: 94,
                            height: 94,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Image.asset(icons[index]),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: IgnorePointer(
                            child: Container(
                              width: 24,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    const Color(0xFFF4F4F4),
                                    const Color(
                                      0xFFF4F4F4,
                                    ).withValues(alpha: .0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: IgnorePointer(
                            child: Container(
                              width: 24,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    const Color(0xFFF4F4F4),
                                    const Color(
                                      0xFFF4F4F4,
                                    ).withValues(alpha: .0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double trackWidth = constraints.maxWidth;
                final double knobWidth = 40;
                return GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final double newPosition =
                        (_shopScrollValue * trackWidth) + details.delta.dx;
                    final double newScrollValue = (newPosition / trackWidth)
                        .clamp(0.0, 1.0);
                    setState(() {
                      _shopScrollValue = newScrollValue;
                    });
                    if (_shopScrollController.hasClients) {
                      final double max =
                          _shopScrollController.position.maxScrollExtent;
                      _shopScrollController.jumpTo(newScrollValue * max);
                    }
                  },
                  child: SizedBox(
                    height: 20,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: Container(height: 2, color: _green),
                          ),
                        ),
                        Positioned(
                          left: _shopScrollValue * (trackWidth - knobWidth),
                          top: 6,
                          child: Container(
                            width: knobWidth,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _green,
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
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Image.asset(
                'lib/assets/images/Icon - Location.png',
                width: 16,
                height: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                address,
                style: const TextStyle(
                  color: Color(0xFF4C9DA6),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF4C9DA6),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Image.asset(
              'lib/assets/images/Icon - Clock.png',
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 12),
            Text(hours, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

Widget bottomBar(BuildContext context, int currentIndex) {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 8),
      ],
    ),
    child: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _navItem(
            context,
            0,
            currentIndex,
            'lib/assets/images/Nav Icon - Home.png',
            'lib/assets/images/Nav Icon - Home Green.png',
            '/home',
            'HOME',
          ),
          _navItem(
            context,
            1,
            currentIndex,
            'lib/assets/images/Nav Icon - Mall.png',
            'lib/assets/images/Nav Icon - Mall Green.png',
            '/mall',
            'MALL',
          ),
          _navItem(
            context,
            2,
            currentIndex,
            'lib/assets/images/Nav Icon - Discover.png',
            'lib/assets/images/Nav Icon - Discover.png',
            '/discover',
            'DISCOVER',
          ),
          _navItem(
            context,
            3,
            currentIndex,
            'lib/assets/images/Nav Icon - Inbox.png',
            'lib/assets/images/Nav Icon - Inbox.png',
            '/inbox',
            'INBOX',
          ),
          _navItem(
            context,
            4,
            currentIndex,
            'lib/assets/images/Nav Icon - Account.png',
            'lib/assets/images/Nav Icon - Account.png',
            '/account',
            'ACCOUNT',
          ),
        ],
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
  String label,
) {
  final bool active = currentIndex == index;
  final Color activeColor = const Color(0xFF164A3A);
  final Color inactiveColor = Colors.grey.withValues(alpha: .6);

  return Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!active) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: active
              ? Border(bottom: BorderSide(color: activeColor, width: 3))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              active ? activePath : normalPath,
              width: 24,
              height: 24,
              color: active ? null : inactiveColor,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: active ? activeColor : inactiveColor,
                letterSpacing: 1.0,
              ),
            ),
          ],
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
