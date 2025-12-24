import 'package:flutter/material.dart';

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
