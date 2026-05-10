import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Pops when possible; otherwise navigates to [fallbackLocation] (e.g. after `context.go`).
void popOrGo(BuildContext context, String fallbackLocation) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(fallbackLocation);
  }
}
