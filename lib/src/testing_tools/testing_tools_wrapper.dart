import 'package:flutter/material.dart';

import 'color_mode_simulation.dart';
import 'test_environment.dart';

/// Widget that applies [environment] to [child] using [MediaQuery], [Theme],
/// [Localizations] and debug flags
class TestingToolsWrapper extends StatelessWidget {
  const TestingToolsWrapper({
    super.key,
    required this.environment,
    required this.child,
  });

  final TestEnvironment? environment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).copyWith(
      textScaler: environment?.textScaleFactor != null ? TextScaler.linear(environment!.textScaleFactor!) : null,
    );

    Widget body = child;

    if (environment?.colorModeSimulation != null) {
      body = ColorModeSimulator(
        simulation: environment!.colorModeSimulation!,
        child: body,
      );
    }

    return MediaQuery(
      data: mediaQueryData,
      child: Theme(
        data: Theme.of(context),
        child: body,
      ),
    );
  }
}
