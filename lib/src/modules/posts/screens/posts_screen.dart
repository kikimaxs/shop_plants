import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';

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
