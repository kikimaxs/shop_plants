import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Inbox')),
      bottomNavigationBar: bottomBar(context, 3),
    );
  }
}
