import 'package:flame/components.dart';
import 'dart:ui';

class Pipe extends SpriteComponent {
  late bool _isBlanchonBehing;
  late bool _isATopPipe;

  Pipe(Image image, Vector2 size, Vector2 position, bool isATopPipe)
    : super(sprite: Sprite(image), position: position, size: size) {
    _isBlanchonBehing = false;
    _isATopPipe = isATopPipe;
  }

  void blanchonPassThePipe() {
    _isBlanchonBehing = true;
  }

  bool get isBlanchonBehing => _isBlanchonBehing;
  bool get isATopPipe => _isATopPipe;
}
