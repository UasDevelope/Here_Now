import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';

class ShimmerCommentContainer extends StatelessWidget {
  const ShimmerCommentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simulating the CircleAvatar with shimmer
          Shimmer.fromColors(
            baseColor: AppColors.grey.withValues(alpha: 0.5),
            highlightColor: AppColors.grey.withValues(alpha: 0.2),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.grey.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Simulating the name text
                    Shimmer.fromColors(
                      baseColor: AppColors.grey.withValues(alpha: 0.5),
                      highlightColor: AppColors.grey.withValues(alpha: 0.2),
                      child: Container(
                        height: 10,
                        width: 100,
                        color: AppColors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    // Simulating the date text
                    Shimmer.fromColors(
                      baseColor: AppColors.grey.withValues(alpha: 0.5),
                      highlightColor: AppColors.grey.withValues(alpha: 0.2),
                      child: Container(
                        height: 10,
                        width: 60,
                        color: AppColors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Simulating the comment content
                Shimmer.fromColors(
                  baseColor: AppColors.grey.withValues(alpha: 0.5),
                  highlightColor: AppColors.grey.withValues(alpha: 0.2),
                  child: Container(
                    height: 14,
                    width: double.infinity,
                    color: AppColors.grey.withValues(alpha: 0.3),
                  ),
                ),
                const SizedBox(height: 4),
                Shimmer.fromColors(
                  baseColor: AppColors.grey.withValues(alpha: 0.5),
                  highlightColor: AppColors.grey.withValues(alpha: 0.2),
                  child: Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: AppColors.grey.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
