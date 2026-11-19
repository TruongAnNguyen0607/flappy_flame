import 'package:flame/components.dart';

class PrioritySpriteAnimationComponent extends SpriteAnimationComponent {
  PrioritySpriteAnimationComponent(
    int priority,
    SpriteAnimation spriteAnimation, {
    Vector2? position,
    Vector2? size,
  }) : super(
         priority: priority,
         animation: spriteAnimation,
         position: position,
         size: size,
       );
}
