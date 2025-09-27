import 'package:flutter/material.dart';

class InkScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const InkScale({super.key, required this.child, required this.onTap});

  @override
  State<InkScale> createState() => _InkScaleState();
}

class _InkScaleState extends State<InkScale> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  void _down(_) => setState(() => _scale = 0.98);
  void _up([_]) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _down, onTapCancel: _up, onTapUp: _up, onTap: widget.onTap,
      child: AnimatedScale(scale: _scale, duration: const Duration(milliseconds: 120), curve: Curves.easeOut, child: widget.child),
    );
  }
}
