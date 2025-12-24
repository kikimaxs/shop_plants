import 'package:flutter/material.dart';
import 'src/modules/home/screens/home_screen.dart';
import 'src/modules/mall/screens/mall_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Plants',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF164A3A)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/mall': (_) => const MallScreen(),
        '/discover': (_) => const DiscoverScreen(),
        '/inbox': (_) => const InboxScreen(),
        '/account': (_) => const AccountScreen(),
        '/shop': (_) => const ShopScreen(),
        '/services': (_) => const ServicesScreen(),
        '/posts': (_) => const PostsScreen(),
      },
    );
  }
}
