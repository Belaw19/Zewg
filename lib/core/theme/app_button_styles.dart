import 'package:flutter/material.dart';

ButtonStyle primaryInteractiveButtonStyle({
  required Color backgroundColor,
  required Color foregroundColor,
  OutlinedBorder? shape,
  EdgeInsetsGeometry? padding,
  Size? minimumSize,
  double? elevation,
  Color? shadowColor,
}) {
  return ButtonStyle(
    minimumSize: minimumSize != null ? MaterialStatePropertyAll<Size>(minimumSize) : null,
    padding: padding != null ? MaterialStatePropertyAll<EdgeInsetsGeometry>(padding) : null,
    shape: shape != null ? MaterialStatePropertyAll<OutlinedBorder>(shape) : null,
    elevation: MaterialStateProperty.resolveWith<double?>((states) {
      if (elevation == null) return null;
      if (states.contains(MaterialState.pressed)) return elevation * 0.7;
      if (states.contains(MaterialState.hovered)) return elevation * 0.85;
      return elevation;
    }),
    shadowColor: shadowColor != null ? MaterialStatePropertyAll<Color>(shadowColor) : null,
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.pressed)) return const Color(0xFFD0D4D8);
      if (states.contains(MaterialState.hovered)) return const Color(0xFFDEE2E6);
      return backgroundColor;
    }),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.pressed)) return const Color(0xFF1F2933);
      if (states.contains(MaterialState.hovered)) return const Color(0xFF24323D);
      return foregroundColor;
    }),
    animationDuration: const Duration(milliseconds: 180),
  );
}
