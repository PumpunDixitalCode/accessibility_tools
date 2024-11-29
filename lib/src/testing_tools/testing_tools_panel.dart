import 'package:flutter/material.dart';

import 'color_mode_simulation.dart';
import 'multi_value_toggle.dart';
import 'slider_toggle.dart';
import 'test_environment.dart';

/// Testing tools panel widget with various toggles and settings. Changing any
/// setting produces a new instance of [TestEnvironment] delivered
/// via [onEnvironmentUpdate]
class TestingToolsPanel extends StatefulWidget {
  const TestingToolsPanel({
    super.key,
    required this.onClose,
    required this.environment,
    required this.onEnvironmentUpdate,
  });

  final TestEnvironment environment;
  final VoidCallback onClose;
  final void Function(TestEnvironment environment) onEnvironmentUpdate;

  @override
  State<TestingToolsPanel> createState() => _TestingToolsPanelState();
}

class _TestingToolsPanelState extends State<TestingToolsPanel> {
  late double? textScaleFactor;

  late bool? boldText;

  late TargetPlatform? targetPlatform;
  late VisualDensity? visualDensity;
  late Locale? localeOverride;
  late TextDirection? textDirection;

  late bool? semanticsDebuggerEnabled;
  late ColorModeSimulation? colorModeSimulation;

  @override
  Widget build(BuildContext context) {
    this.textScaleFactor = widget.environment.textScaleFactor;
    colorModeSimulation = widget.environment.colorModeSimulation;

    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor =
        this.textScaleFactor != null ? TextScaler.linear(this.textScaleFactor!) : mediaQuery.textScaler;
    const gap = SizedBox(height: 18);

    return Stack(
      children: [
        Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: MediaQuery.paddingOf(context),
            child: Column(
              children: [
                Toolbar(
                  onClose: widget.onClose,
                  onResetAll: () => widget.onEnvironmentUpdate(
                    const TestEnvironment(),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      SliderTile(
                        label: '''Escala de texto: ${textScaleFactor.scale(1.0).toStringAsFixed(1)}''',
                        info: '''Cambia la escala del texto en la aplicación''',
                        value: textScaleFactor.scale(1.2),
                        min: 1.2,
                        max: 1.7,
                        onChanged: (value) {
                          this.textScaleFactor = value;
                          _notifyTestEnvironmentChanged();
                        },
                      ),
                      gap,
                      MultiValueToggle<ColorModeSimulation?>(
                        title: 'Ayudas visuales',
                        info: '''Simula diferentes tonalidades de colores para las distintas condiciones de visión''',
                        value: colorModeSimulation,
                        onTap: (value) {
                          colorModeSimulation = value;
                          _notifyTestEnvironmentChanged();
                        },
                        values: ColorModeSimulation.values,
                        nameBuilder: (e) => e?.name ?? 'Off',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _notifyTestEnvironmentChanged() {
    widget.onEnvironmentUpdate(
      TestEnvironment(
        textScaleFactor: textScaleFactor,
        colorModeSimulation: colorModeSimulation,
      ),
    );
  }
}

@visibleForTesting
class Toolbar extends StatelessWidget {
  const Toolbar({
    super.key,
    required this.onClose,
    required this.onResetAll,
  });

  final VoidCallback onClose;
  final VoidCallback onResetAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cerrar',
            onPressed: onClose,
          ),
          Expanded(
            child: Text(
              'Herramienas de accesibilidad',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: onResetAll,
            child: const Text('Valores por defecto', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
