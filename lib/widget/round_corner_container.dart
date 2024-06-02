
import 'package:flutter/widgets.dart';

import '../util/color_manager.dart';

class RoundCornerContainer extends StatelessWidget {
  const RoundCornerContainer(
      {super.key, required this.child, this.roundAll = true, this.color, this.borderColor, this.boxRadius = 20, this.customRadius});

  final Widget child;
  final double boxRadius;
  final bool roundAll;
  final BorderRadius? customRadius;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorManager.white,
        border: Border.all(width: 1.0, color: borderColor ?? ColorManager.grey03),
        borderRadius: customRadius ?? (roundAll
            ? BorderRadius.all(Radius.circular(boxRadius))
            : BorderRadius.vertical(top: Radius.circular(boxRadius))),
      ),
      child: child,
    );
  }
}