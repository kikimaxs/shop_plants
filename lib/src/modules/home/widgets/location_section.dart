import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';

class LocationSection extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final LatLng? currentLatLng;

  const LocationSection({
    super.key,
    required this.isLoading,
    this.error,
    this.currentLatLng,
  });

  @override
  Widget build(BuildContext context) {
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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : currentLatLng != null
                  ? _buildMap()
                  : _buildError(),
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

  Widget _buildMap() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: currentLatLng!,
        initialZoom: 14.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: currentLatLng!,
              width: 40,
              height: 40,
              child: const Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildError() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Text(
          error ?? 'Location unavailable',
          style: const TextStyle(color: Colors.grey),
        ),
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
