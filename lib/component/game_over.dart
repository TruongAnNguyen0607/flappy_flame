import 'package:flame/components.dart';
import 'dart:ui';

class GameOver extends SpriteComponent {
  GameOver(Image image, Vector2 size, Vector2 position)
    : super(sprite: Sprite(image), position: position, size: size) {
    this.anchor = Anchor.center;
  }
}
