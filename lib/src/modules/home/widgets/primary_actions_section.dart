import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PrimaryActionsSection extends StatelessWidget {
  const PrimaryActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(label),
    );
  }
}
