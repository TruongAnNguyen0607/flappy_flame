import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_blanchon/component/bird.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'overlapping flaps report ceiling contact after effects update',
    () async {
      final recorder = PictureRecorder();
      Canvas(recorder).drawRect(const Rect.fromLTWH(0, 0, 64, 64), Paint());
      final picture = recorder.endRecording();
      final image = picture.toImageSync(64, 64);
      final game = FlameGame()..onGameResize(Vector2(400, 800));
      final bird = Bird(
        SpriteAnimation.spriteList([Sprite(image)], stepTime: 0.2),
        Vector2.all(64),
        Vector2(200, 100),
      );
    // Run the lifecycle normally managed by GameWidget in this headless test.
    // ignore: invalid_use_of_internal_member
    await game.load();
    // ignore: invalid_use_of_internal_member
    game.mount();
      game.add(bird);
      await game.ready();
      game.update(0);
      expect(bird.hitCeiling, isFalse);

      var touchedCeiling = false;
      for (var frame = 0; frame < 60; frame++) {
        if (frame % 3 == 0) bird.flutter();
      await game.ready();
        game.update(1 / 60);
        expect(bird.toRect().top, greaterThanOrEqualTo(-0.000001));
        if (bird.hitCeiling) {
          touchedCeiling = true;
          bird.die(600);
          break;
        }
      }
      expect(touchedCeiling, isTrue);
      for (var frame = 0; frame < 40; frame++) {
      await game.ready();
        game.update(1 / 60);
      }
      expect(bird.y, closeTo(632, 0.001));
      bird.reloadDefaultPosition();
      expect(bird.hitCeiling, isFalse);
      expect(bird.position, Vector2(200, 100));
      game.onRemove();
      image.dispose();
      picture.dispose();
    },
  );
}
