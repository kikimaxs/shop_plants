import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../components/bottom_nav_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/shop_plants_section.dart';
import '../widgets/location_section.dart';
import '../widgets/home_header.dart';
import '../widgets/new_services_section.dart';
import '../widgets/trending_section.dart';
import '../widgets/category_icons_section.dart';
import '../widgets/primary_actions_section.dart';
import '../widgets/hero_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _currentLatLng;
  bool _locLoading = false;
  String? _locError;

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
      if (!serviceEnabled) throw Exception('Location service disabled');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HomeHeader()),
          const SliverToBoxAdapter(child: HeroSection()),
          const SliverToBoxAdapter(child: PrimaryActionsSection()),
          const SliverToBoxAdapter(child: CategoryIconsSection()),
          const SliverToBoxAdapter(child: NewServicesSection()),
          const SliverToBoxAdapter(child: ShopPlantsSection()),
          const SliverToBoxAdapter(child: TrendingSection()),
          SliverToBoxAdapter(
            child: LocationSection(
              isLoading: _locLoading,
              error: _locError,
              currentLatLng: _currentLatLng,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}
