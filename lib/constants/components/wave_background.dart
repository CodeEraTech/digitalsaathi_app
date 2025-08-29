import 'package:flutter/material.dart';




class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient with blue and purple
    var gradient = LinearGradient(
      colors: [Colors.blue, Colors.purple], // Blue on top, purple on bottom
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0], // Gradient from top to bottom
    );

    // Apply the gradient to the paint
    var paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill
    ..strokeWidth;

    var path = Path();
    // Draw a straight line at the top (the base)
    path.moveTo(0, 0);

    // Draw a straight line at the top (the base)
    path.lineTo(size.width, 0);

    // Move to the point where we want to start the wave
    path.lineTo(size.width, size.height * 0.33); // Adjust to one-third

    // First wave curve
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.45, // Control point adjusted
      size.width * 0.5, size.height * 0.33,   // End point of the curve
    );

    // Second wave curve to make it more wave-like
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.21, // Control point adjusted
      0, size.height * 0.33,                 // End point of the wave
    );

    // Connect the path to the starting point
    path.lineTo(0, 0); // Close the path back to the top-left corner

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
