import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Discover')),
      bottomNavigationBar: bottomBar(context, 2),
    );
  }
}
