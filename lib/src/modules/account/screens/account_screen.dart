import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Account')),
      bottomNavigationBar: bottomBar(context, 4),
    );
  }
}
