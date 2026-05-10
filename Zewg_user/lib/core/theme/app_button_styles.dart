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
    minimumSize: minimumSize != null
        ? WidgetStatePropertyAll<Size>(minimumSize)
        : null,
    padding: padding != null
        ? WidgetStatePropertyAll<EdgeInsetsGeometry>(padding)
        : null,
    shape: shape != null ? WidgetStatePropertyAll<OutlinedBorder>(shape) : null,
    elevation: WidgetStateProperty.resolveWith<double?>((states) {
      if (elevation == null) return null;
      if (states.contains(WidgetState.pressed)) return elevation * 0.7;
      if (states.contains(WidgetState.hovered)) return elevation * 0.85;
      return elevation;
    }),
    shadowColor: shadowColor != null
        ? WidgetStatePropertyAll<Color>(shadowColor)
        : null,
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) return const Color(0xFFD0D4D8);
      if (states.contains(WidgetState.hovered)) return const Color(0xFFDEE2E6);
      return backgroundColor;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) return const Color(0xFF1F2933);
      if (states.contains(WidgetState.hovered)) return const Color(0xFF24323D);
      return foregroundColor;
    }),
    animationDuration: const Duration(milliseconds: 180),
  );
}
