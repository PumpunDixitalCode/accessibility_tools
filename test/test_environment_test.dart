import 'package:accessibility_tools/src/testing_tools/color_mode_simulation.dart';
import 'package:accessibility_tools/src/testing_tools/test_environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TestEnvironment comparison works', () {
    expect(const TestEnvironment(), equals(const TestEnvironment()));
    expect(
      const TestEnvironment(
        textScaleFactor: 1.0,
        colorModeSimulation: ColorModeSimulation.deuteranopia,
      ),
      equals(
        const TestEnvironment(
          textScaleFactor: 1.0,
          colorModeSimulation: ColorModeSimulation.deuteranopia,
        ),
      ),
    );

    expect(
      const TestEnvironment(
        textScaleFactor: 2.0,
        colorModeSimulation: ColorModeSimulation.deuteranopia,
      ),
      isNot(
        const TestEnvironment(
          textScaleFactor: 1.0,
          colorModeSimulation: ColorModeSimulation.deuteranopia,
        ),
      ),
    );
  });
}
