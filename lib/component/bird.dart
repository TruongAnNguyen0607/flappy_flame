import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'priority_sprite_animation_component.dart';

class Bird extends PrioritySpriteAnimationComponent {
  late Vector2 _defaultPosition;
  bool _isFluttering = false;
  Timer? _currentFlutteringTimer;
  bool hitCeiling = false;
  static const FLUTTERING_DELAY = 250;
  static const STAGGING_ANIMATION_DELAY = 750;
  static const double fallSpeed = 80;

  Bird(SpriteAnimation birdAnimation, Vector2 size, Vector2 position)
    : super(1, birdAnimation, size: size, position: position) {
    _defaultPosition = Vector2(position.x, position.y);
    anchor = Anchor.center;
  }

  void reloadDefaultPosition() {
    hitCeiling = false;
    position = Vector2(_defaultPosition.x, _defaultPosition.y);
    add(RotateEffect.to(0, EffectController(duration: 0)));
  }

  void clearEffects() => removeAll(children.whereType<Effect>());

  @override
  void updateTree(double dt) {
    super.updateTree(dt);
    // Apply the ceiling after flap effects, including the rotated sprite bounds.
    final top = toRect().top;
    hitCeiling = top <= 0;
    if (top < 0) {
      position.y -= top;
    }
  }

  void flutter() {
    _clearFlutteringTimer();
    _isFluttering = true;
    final moveUp = MoveEffect.to(
      Vector2(position.x, position.y - 85),
      EffectController(duration: FLUTTERING_DELAY / 1000, curve: Curves.linear),
    );
    final rotateUp = RotateEffect.to(
      -pi / 4,
      EffectController(duration: 0.25, curve: Curves.easeOut),
    );
    add(CombinedEffect([moveUp, rotateUp]));
    _currentFlutteringTimer = Timer(
      Duration(milliseconds: FLUTTERING_DELAY),
      () => _isFluttering = false,
    );
  }

  void fall(double dt) {
    if (!_isFluttering) {
      position.y += fallSpeed * dt;
      angle = min(pi / 2, angle + pi * dt);
    }
  }

  void die(double groundTopPosition) {
    _clearFlutteringTimer();
    clearEffects();
    final moveToGround = MoveEffect.to(
      Vector2(position.x, groundTopPosition + spriteHeight / 2),
      EffectController(duration: 0.5),
    );
    final deadRotation = RotateEffect.to(
      pi / 2,
      EffectController(duration: 0.5, curve: Curves.linear),
    );
    add(CombinedEffect([moveToGround, deadRotation]));
    _stopAnimation();
  }

  void staggingAnimation() {
    add(
      SequenceEffect([
        MoveEffect.to(
          Vector2(position.x, position.y - 10),
          EffectController(duration: 0.1875),
        ),
        MoveEffect.to(
          Vector2(position.x, position.y + 10),
          EffectController(duration: 0.375),
        ),
        MoveEffect.to(position.clone(), EffectController(duration: 0.1875)),
      ], infinite: true),
    );
    _resetAnimation();
  }

  void _clearFlutteringTimer() => _currentFlutteringTimer?.cancel();

  void _stopAnimation() {
    animation!.loop = false;
    playing = false;
  }

  void _resetAnimation() {
    animation!.loop = true;
    playing = true;
    animationTicker!.reset();
  }

  double get bottomYPosition => position.y + spriteHeight / 2;
  double get spriteHeight => size.y;
  double get spriteWidth => size.x;
}
