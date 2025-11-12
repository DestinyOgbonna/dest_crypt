import 'dart:math' as math;

import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class PortfolioRiskScreen extends StatelessWidget {
  const PortfolioRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                    ),
                  ),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyColor,
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portfolio\nRisk Score',
                        style: AppStyles.blackBold16.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Updated:\nJust Now',
                            textAlign: TextAlign.right,
                            style: AppStyles.blackSemi13,
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            children: [
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.24,
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Low Risk', style: AppStyles.blackSemi13),
                              Text('High Risk', style: AppStyles.blackSemi13),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // High Risk Assets
                      _buildRiskCard(
                        color: AppColors.redColor,
                        title: 'High Risk Assets',
                        subtitle: 'Within the recommended norm',
                        percentage: 24,
                        gaugeValue: 0.4,
                        gaugeColor: AppColors.redColor,
                      ),
                      const SizedBox(height: 10),

                      _buildRiskCard(
                        color: AppColors.orangeColor,
                        title: 'Medium Risk Assets',
                        subtitle: 'Above the recommended',
                        percentage: 14,
                        gaugeValue: 0.25,
                        gaugeColor: AppColors.orangeColor,
                      ),
                      const SizedBox(height: 10),

                      _buildRiskCard(
                        color: AppColors.greenColor,
                        title: 'Low Risk Assets',
                        subtitle: 'Within the recommended norm',
                        percentage: 62,
                        gaugeValue: 0.62,
                        gaugeColor: AppColors.greenColor,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskCard({
    required Color color,
    required String title,
    required String subtitle,
    required int percentage,
    required double gaugeValue,
    required Color gaugeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(title, style: AppStyles.blackSemi13),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppStyles.blackSemi13.copyWith(color: AppColors.textBlack),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$percentage%',
                style: AppStyles.blackBold14.copyWith(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: GaugePainter(value: gaugeValue, color: gaugeColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double value;
  final Color color;

  GaugePainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Background arc
    final backgroundPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.75,
      math.pi * 1.5,
      false,
      backgroundPaint,
    );

    // Foreground arc
    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.75,
      math.pi * 1.5 * value,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(GaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}
