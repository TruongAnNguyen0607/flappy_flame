import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';

class Bg extends PositionComponent {
  double _time = 0;
  bool _moving = true;

  Bg(Vector2 size) : super(size: size.clone(), priority: -100);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size.setFrom(size);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_moving) _time += dt;
  }

  @override
  void render(Canvas canvas) {
    final bounds = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(
      bounds,
      Paint()
        ..shader = Gradient.linear(
          Offset.zero,
          Offset(0, size.y),
          [
            const Color(0xFF69C8ED),
            const Color(0xFFC6F0ED),
            const Color(0xFFFFF0CC),
          ],
          [0, 0.65, 1],
        ),
    );
    final sun = Offset(size.x * 0.8, size.y * 0.18);
    canvas.drawCircle(sun, 64, Paint()..color = const Color(0x22FFF8D6));
    canvas.drawCircle(sun, 46, Paint()..color = const Color(0x44FFF8D6));
    canvas.drawCircle(sun, 30, Paint()..color = const Color(0xFFFFF4CA));

    canvas.save();
    canvas.clipRect(bounds);
    for (var i = 0; i < 6; i++) {
      final span = size.x + 180;
      final x = ((i * span / 3 - _time * (i.isEven ? 9 : 14)) % span) - 90;
      final y = size.y * (0.12 + (i % 3) * 0.14);
      _cloud(canvas, Offset(x, y), i.isEven ? 1 : 0.7);
    }
    _hills(canvas, size.y * 0.72, 28, 0.3, const Color(0xFF9CD8BB));
    _hills(canvas, size.y * 0.79, 20, 0.6, const Color(0xFF6EBDA0));
    canvas.restore();
  }

  void _cloud(Canvas canvas, Offset origin, double scale) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.scale(scale);
    final paint = Paint()..color = const Color(0xDFFFFFFF);
    final cloud = Path()
      ..addOval(const Rect.fromLTWH(0, 20, 100, 32))
      ..addOval(const Rect.fromLTWH(17, 4, 42, 45))
      ..addOval(const Rect.fromLTWH(45, 12, 38, 35));
    canvas.drawPath(cloud, paint);
    canvas.restore();
  }

  void _hills(
    Canvas canvas,
    double baseline,
    double height,
    double speed,
    Color color,
  ) {
    final path = Path()..moveTo(0, size.y);
    for (double x = 0; x <= size.x + 8; x += 8) {
      path.lineTo(x, baseline + math.sin(x / 110 + _time * speed) * height);
    }
    path
      ..lineTo(size.x, size.y)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  void stopMovement() => _moving = false;
  void restartMovement() => _moving = true;
}
