

# Modern Linear Slider

A value slider works by touching and dragging in the increasing or decreasign direction, and not affected by tapping which gives more decent experience for touch devices

<img src="https://raw.githubusercontent.com/muhammad369/modern_linear_slider/refs/heads/master/img1.gif?raw=true" height="600">

## Usage Example

```dart
ModernLinearSlider(
  backgroundColor: Colors.black26,
  foregroundColor: Colors.blueAccent,
  disabledColor: Colors.black38,
  value: val.toDouble(),
  onValueChanging: (i) {
    setState(() {
      val = i.toInt();
    });
  },
  onValueChanged: (i) {},
),

```