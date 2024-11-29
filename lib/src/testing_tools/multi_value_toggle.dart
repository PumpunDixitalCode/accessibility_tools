import 'package:flutter/material.dart';

import 'info_button.dart';

class MultiValueToggle<T> extends StatelessWidget {
  const MultiValueToggle({
    super.key,
    required this.value,
    required this.info,
    required this.onTap,
    required this.title,
    required this.values,
    required this.nameBuilder,
  });

  final String title;
  final String info;

  final List<T> values;
  final String Function(T? value) nameBuilder;

  final T? value;
  final void Function(T? value) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 8),
            InfoButton(text: info),
          ],
        ),
        const SizedBox.square(dimension: 8),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              selectedColor: const Color.fromRGBO(3, 136, 211, 1),
              surfaceTintColor: Colors.white,
              backgroundColor: const Color(0xff838383),
              showCheckmark: false,
              label: Text(
                nameBuilder(null),
                style: const TextStyle(color: Colors.white),
              ),
              selected: value == null,
              onSelected: (value) => onTap(null),
            ),
            ...values.map((e) {
              return ChoiceChip(
                selectedColor: const Color.fromRGBO(3, 136, 211, 1),
                surfaceTintColor: Colors.white,
                backgroundColor: const Color(0xff838383),
                showCheckmark: false,
                selected: e == value,
                label: Text(
                  nameBuilder(e),
                  style: const TextStyle(color: Colors.white),
                ),
                onSelected: (_) => onTap(e),
              );
            }),
          ],
        ),
      ],
    );
  }
}
