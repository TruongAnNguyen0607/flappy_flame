import 'package:flame/components.dart';
import 'dart:ui';

import 'priority_sprite_component.dart';

class ScoreElement extends PrioritySpriteComponent {
  ScoreElement(Image image, Vector2 size) : super(1, image, size: size) {
    this.anchor = Anchor.center;
  }
}
