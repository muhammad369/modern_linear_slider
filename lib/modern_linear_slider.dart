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

class ModernLinearSlider extends StatefulWidget {
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
  State<ModernLinearSlider> createState() => _ModernLinearSliderState();
}

class _ModernLinearSliderState extends State<ModernLinearSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Listener(
        onPointerDown: widget.enabled ? onPointerDown : null,
        onPointerMove: widget.enabled
            ? (event) => onPointerMove(event, constraints.maxWidth)
            : null,
        onPointerUp: widget.enabled ? onPointerUp : null,
        child: CustomPaint(
          painter: _Painter(
            backgroundColor: widget.backgroundColor,
            activeColor: widget.enabled
                ? widget.foregroundColor
                : widget.disabledColor,
            value: widget.value,
            ltr: widget.ltr,
          ),
          child: SizedBox(width: widget.width, height: widget.height),
        ),
      ),
    );
  }

  double startingX = 0, startingValue = 0;

  void onPointerDown(PointerDownEvent event) {
    startingX = event.position.dx;
    startingValue = widget.value;
    // print('startingX ===> ${startingX} = value==> $startingValue');
  }

  void onPointerMove(PointerMoveEvent event, double maxWidth) {
    double dx = event.position.dx - startingX;
    //
    double delta = (dx / maxWidth);
    //print('delta ====> $delta');
    if (delta < 0.01 && delta > -0.01) return;

    double newValue = startingValue + (widget.ltr ? delta : -delta) * 100;
    //print('new value ===> $newValue');
    if (newValue < 0) newValue = 0;
    if (newValue > 100) newValue = 100;
    widget.onValueChanging(newValue);
    //
  }

  void onPointerUp(PointerUpEvent event) {
    widget.onValueChanged(widget.value);
    //print('-----------');
  }
}
