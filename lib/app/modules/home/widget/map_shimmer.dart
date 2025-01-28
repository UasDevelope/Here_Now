import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/colors.dart';

class ShimmerMapContainer extends StatelessWidget {
  const ShimmerMapContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.stealBlue.withOpacity(0.3),
      highlightColor: AppColors.stealBlue.withOpacity(0.6),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.stealBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
