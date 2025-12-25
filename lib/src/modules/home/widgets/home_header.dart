import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
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
          _buildAppointmentDivider(),
          const SizedBox(height: 16),
          _buildAppointmentDetails(),
          const SizedBox(height: 24),
          _buildStatsCard(),
        ],
      ),
    );
  }

  Widget _buildAppointmentDivider() {
    return Row(
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
    );
  }

  Widget _buildAppointmentDetails() {
    final textStyle = TextStyle(
      color: Colors.white.withValues(alpha: .9),
      fontSize: 13,
    );
    return Row(
      children: [
        Image.asset(
          'lib/assets/images/Icon - Calender.png',
          width: 16,
          height: 16,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Text('14 Oct 2020', style: textStyle),
        const SizedBox(width: 16),
        Image.asset(
          'lib/assets/images/Icon -Clock.png',
          width: 16,
          height: 16,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Text('12:30 PM', style: textStyle),
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
            style: textStyle,
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
    );
  }

  Widget _buildStatsCard() {
    return Container(
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
    );
  }

  Widget _statItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
