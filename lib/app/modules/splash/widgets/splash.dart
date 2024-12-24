import 'package:flutter/cupertino.dart';
import 'package:here_now/app/utils/colors.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../../utils/images.dart';

class SplashWidget {
  static DecorationImage splashAssetImage() {
    return DecorationImage(image: AssetImage(Images.logo));
  }

  static JumpingDots jumpingDots() {
    return JumpingDots(
      numberOfDots: 4,
      animationDuration: Duration(milliseconds: 300),
      color: AppColors.white,
    );
  }
}
