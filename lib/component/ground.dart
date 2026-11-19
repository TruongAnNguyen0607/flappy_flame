import 'package:flame/components.dart';
import 'dart:ui';

class Ground extends SpriteComponent {
  Ground(Image image, Vector2 size, Vector2 position)
    : super(sprite: Sprite(image), position: position, size: size);

  double get topYPosition => position.y;
}
