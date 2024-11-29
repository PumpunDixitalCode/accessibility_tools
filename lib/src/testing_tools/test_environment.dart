import 'package:flutter/material.dart';

import 'color_mode_simulation.dart';

/// Currently set environment values
///
/// TODO support more settings:
/// MediaQuery.devicePixelRatio
/// MediaQuery.platformBrightness
/// MediaQuery.highContrast
/// MediaQuery.disableAnimations
/// MediaQuery.invertColors
@immutable
class TestEnvironment {
  const TestEnvironment({
    this.textScaleFactor,
    this.colorModeSimulation,
  });

  final double? textScaleFactor;
  final ColorModeSimulation? colorModeSimulation;

  @override
  bool operator ==(covariant TestEnvironment other) {
    if (identical(this, other)) return true;

    return other.textScaleFactor == textScaleFactor && other.colorModeSimulation == colorModeSimulation;
  }

  @override
  int get hashCode {
    return textScaleFactor.hashCode ^ colorModeSimulation.hashCode;
  }

  @override
  String toString() {
    return '''TestEnvironment(textScaleFactor: $textScaleFactor, colorModeSimulation: $colorModeSimulation)''';
  }
}
