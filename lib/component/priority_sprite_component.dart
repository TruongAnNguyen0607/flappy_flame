import 'dart:ui';
import 'package:flame/components.dart';

class PrioritySpriteComponent extends SpriteComponent {
  PrioritySpriteComponent(
    int priority,
    Image image, {
    Vector2? position,
    Vector2? size,
  }) : super(
         priority: priority,
         sprite: Sprite(image),
         position: position,
         size: size,
       );
}
