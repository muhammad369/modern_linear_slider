import 'package:flutter/widgets.dart';

class _Painter extends CustomPainter {
  double value;
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
    double valuePosition = value * size.width / 100;

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

    canvas.clipRect(
      Rect.fromLTWH(
        ltr ? 0 : size.width - valuePosition,
        0,
        valuePosition,
        size.height,
      ),
    );

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

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as _Painter).value != value;
  }
}

class ModernLinearSlider extends StatelessWidget {
  final double width, height;
  final Color backgroundColor, foregroundColor, disabledColor;
  final double value;
  final bool enabled, ltr;
  final Function(double value) onValueChanging;
  final Function(double value) onValueChanged;

  const ModernLinearSlider({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledColor,
    this.ltr = true,

    /// value takes from 0 to 100
    required this.value,
    this.enabled = true,
    required this.onValueChanging,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Listener(
        //onPointerDown: enabled ? onPointerDown : null,
        onPointerMove: enabled
            ? (event) => onPointerMove(event, constraints.maxWidth)
            : null,
        onPointerUp: enabled ? onPointerUp : null,
        child: CustomPaint(
          painter: _Painter(
            backgroundColor: backgroundColor,
            activeColor: enabled ? foregroundColor : disabledColor,
            value: value,
            ltr: ltr,
          ),
          child: SizedBox(width: width, height: height),
        ),
      ),
    );
  }

  //void onPointerDown(PointerDownEvent event) {}

  void onPointerMove(PointerMoveEvent event, double maxWidth) {
    print('maxWidth===> $maxWidth');
    print('dx===> ${event.delta.dx}');
    //
    double delta = (event.delta.dx / maxWidth);
    print('delta ====> $delta');
    double newValue = value + (ltr ? delta : -delta);
    if (newValue < 0) newValue = 0;
    if (newValue > 100) newValue = 100;
    onValueChanging(newValue);
    //
  }

  void onPointerUp(PointerUpEvent event) {
    onValueChanged(value);
    print('-----------');
  }
}
