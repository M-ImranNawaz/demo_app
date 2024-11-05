import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const SwitchWidget({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<SwitchWidget> createState() => _SwitchStateWidget();
}

class _SwitchStateWidget extends State<SwitchWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: _value,
      onChanged: (newValue) {
        setState(() {
          _value = newValue;
        });
        widget.onChanged?.call(newValue);
      },
    );
  }
}
