import 'package:flutter/widgets.dart';

class _Painter extends CustomPainter {
  int value;
  Color backgroundColor, activeColor;
  bool ltr;

  _Painter({
    required this.value,
    required this.activeColor,
    required this.backgroundColor,
    this.ltr = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.fill;

    // draw bg
    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        size.width,
        size.height,
        Radius.circular(size.height / 2),
      ),
      backgroundPaint,
    );

    canvas.save();

    // draw the foreground
    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        size.width,
        size.height,
        Radius.circular(size.height / 2),
      ),
      activePaint,
    );

    canvas.clipRect(
      Rect.fromLTWH(
        ltr ? value.toDouble() : 0,
        0,
        size.width - value.toDouble(),
        size.height,
      ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as _Paint).value != value;
  }
}

class ModernLinearSlider extends StatelessWidget {
  final double width, height;
  final Color backgroundColor, foregroundColor, disabledColor;
  final int value;
  final bool enabled;
  final Function(int value) onValueChanging;
  final Function(int value) onValueChanged;

  const ModernLinearSlider({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledColor,

    /// value takes from 0 to 100
    required this.value,
    this.enabled = true,
    required this.onValueChanging,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: enabled ? onPointerDown : null,
      onPointerMove: enabled ? onPointerMove : null,
      onPointerUp: enabled ? onPointerUp : null,
      child: CustomPaint(
        painter: _Painter(
          backgroundColor: backgroundColor,
          activeColor: enabled ? foregroundColor : disabledColor,
          value: value,
        ),
        child: SizedBox(width: width, height: height),
      ),
    );
  }

  void onPointerDown(PointerDownEvent event) {}

  static final int _factor = 1;

  void onPointerMove(PointerMoveEvent event) {
    int newValue = value + (event.localDelta.dx.toInt() * _factor);
    if (newValue < 0) newValue = 0;
    if (newValue > 100) newValue = 100;
    onValueChanging(newValue);
  }

  void onPointerUp(PointerUpEvent event) {
    onValueChanged(value);
  }
}
